// Desktop notification when CloudCode finishes a turn or needs input.
//
// One implementation, byte-identical on the Mac and on a cloudtop over SSH.
//
// Sink: /dev/tty, opened in-process. CloudCode runs plugins inside the server,
// whose stdout is a pipe rather than the user's terminal, so an escape written
// there never reaches the emulator. The server process does keep the
// controlling terminal while a TUI is attached. Shelling out to a helper that
// writes to the terminal, as bin/agent-notify does, cannot work either:
// CloudCode detaches child processes from that terminal, so the child cannot
// open /dev/tty at all. (A helper that does not need a terminal, such as the
// G3N sender in the gdotfiles bin/notify, is unaffected by this.)
//
// Sequence: a bare BEL, then OSC 777, DCS-wrapped when tmux is in the path.
// Byte-identical to what bin/agent-notify emits for Codex and Claude in the
// personal ~/.dotfiles repo. That script is not deployed on a cloudtop, but
// keeping the bytes the same means every agent alerts the same way wherever it
// runs. See sequence() for why the leading BEL carries the persistence.
//
// The OSC is emitted unconditionally rather than behind a terminal allow-list.
// Such a list keys off TERM_PROGRAM, which SSH does not forward to a cloudtop,
// so it silently downgrades every remote notification to a bare BEL. Terminals
// that do not implement OSC 777 discard it.
//
// Env:
//   CLOUDCODE_NOTIFY_DISABLE=1         skip all notifications
//   CLOUDCODE_NOTIFY_NO_PASSTHROUGH=1  skip the tmux DCS wrapper (use when
//                                      tmux lacks `allow-passthrough`)

import { openSync, writeSync, closeSync } from "fs";
import { hostname } from "os";
import { basename } from "path";

const ESC = "\x1b";
const BEL = "\x07";

// The rule: nothing worth saying, no notification.
//
// A completed turn is only announced when there is an assistant reply to quote.
// There is no generic fallback, because a banner reading "turn complete" reports
// the one thing already visible on screen, and a banner you learn to ignore is
// worse than none.
//
// That also makes an interrupt silent, which is the behaviour you want and the
// reason the fallback had to go rather than be special-cased. session.idle does
// fire when you ctrl-c a turn, but no assistant reply is captured for it, so it
// falls straight into the no-content case.
//
// session.error is not handled at all. Its only observed content was the literal
// string "session error", which fails the same test. A genuine overnight API
// failure therefore passes unannounced; reinstating that case means finding the
// real error text and quoting it, not restoring a constant.
//
// permission.asked keeps a fixed string because "needs your input" is not a
// status report, it is the whole message - there is nothing else to say and
// acting on it is the point.
const NEEDS_INPUT = "needs your input";

// ";" separates OSC 777 fields and BEL terminates the string, so either one
// arriving from a session title or an assistant reply would truncate the
// sequence mid-flight.
const clean = (text) => text.replace(/[\x00-\x1f;]/g, " ").trim();

const MAX_LABEL = 60;

// What the assistant actually said, which is the only genuinely useful thing to
// put in a completion banner. Both comparable agents do this and nothing less:
// Codex previews the response at 200 graphemes
// (AGENT_NOTIFICATION_PREVIEW_GRAPHEMES in its tui, falling back to "Agent turn
// complete" only when empty) and Claude Code hands hooks the whole thing as
// `last_assistant_message`. 200 matches Codex; macOS truncates well before it.
const MAX_PREVIEW = 200;

// CloudCode names a session before it has anything to name it after, so an
// untouched one reads "New session - <timestamp>". That is worse than nothing
// in a banner; fall back to the directory instead.
const isPlaceholderTitle = (t) => !t || /^New session\b/.test(t);

// ASCII only, per the house rule: "..." rather than a Unicode ellipsis.
const truncate = (text, max = MAX_LABEL) =>
  text.length <= max ? text : `${text.slice(0, max - 3)}...`;

// Collapse the newlines and runs of whitespace a markdown reply is full of; a
// banner is one line however the text arrives.
const oneLine = (text) => text.split(/\s+/).filter(Boolean).join(" ");

// Name the source when the session is remote. With a Mac and a cloudtop both
// notifying the same Ghostty, an unqualified "CloudCode" does not say which
// one just finished.
const title = () => {
  if (!process.env.SSH_CONNECTION && !process.env.SSH_TTY) return "CloudCode";
  return `CloudCode (${clean(hostname().split(".")[0])})`;
};

const inTmux = () =>
  Boolean(process.env.TMUX) || /^(screen|tmux)/.test(process.env.TERM ?? "");

const sequence = (body) => {
  let osc = `${ESC}]777;notify;${title()};${clean(body)}${BEL}`;
  if (inTmux() && process.env.CLOUDCODE_NOTIFY_NO_PASSTHROUGH !== "1") {
    // tmux passthrough doubles every ESC inside the payload and terminates the
    // outer DCS with ST.
    osc = `${ESC}Ptmux;${osc.replace(/\x1b/g, ESC + ESC)}${ESC}\\`;
  }
  // A bare BEL first, unwrapped, exactly as bin/agent-notify does it. This is
  // what drives Ghostty's bell-features: `attention` bounces the dock until the
  // app regains focus and `title` prefixes the tab with a bell, both of which
  // persist on their own rather than depending on the macOS notification alert
  // style. The banner alone is at the mercy of that setting; these are not.
  // Silent, since the config sets no-audio and no-system. It also flags the
  // tmux window for monitor-bell.
  //
  // The BEL that terminates the OSC above does not do this: it is consumed as
  // the string terminator while the parser is inside the sequence.
  return `${BEL}${osc}`;
};

const emit = (text) => {
  let fd;
  try {
    fd = openSync("/dev/tty", "w");
    writeSync(fd, text);
  } catch {
    // No controlling terminal (cloudcode serve, headless run). Nothing to do.
  } finally {
    if (fd !== undefined) {
      try {
        closeSync(fd);
      } catch {}
    }
  }
};

export const NotifyPlugin = async (input) => {
  if (process.env.CLOUDCODE_NOTIFY_DISABLE === "1") return {};

  // session.idle carries only a sessionID, so "turn complete" on its own cannot
  // say which session finished - useless when several are running across two
  // machines. session.updated does carry the title and directory, so keep the
  // last one seen per session and label the notification with it.
  const labels = new Map();
  const fallback = input?.directory ? basename(input.directory) : "";

  // The assistant's reply, per session. session.idle names no message, so the
  // text has to be accumulated as it streams: message.updated says which
  // message id is the assistant's, message.part.updated carries the text under
  // that id. Parts arrive repeatedly while the reply streams, so last write
  // wins and the final one is the complete text.
  const speaking = new Map(); // sessionID -> assistant messageID
  const reply = new Map(); // sessionID -> latest assistant text

  // A long-lived server sees many sessions; keep these from growing forever.
  const cap = (map) => {
    if (map.size > 64) map.delete(map.keys().next().value);
  };

  const remember = (info) => {
    if (!info?.id) return;
    const label = isPlaceholderTitle(info.title)
      ? basename(info.directory ?? "")
      : info.title;
    if (label) labels.set(info.id, label);
    cap(labels);
  };

  return {
    event: async ({ event }) => {
      const type = event?.type;
      const props = event?.properties;

      if (type === "session.updated") {
        remember(props?.info);
        return;
      }
      if (type === "message.updated") {
        const info = props?.info;
        if (info?.role === "assistant" && info.id && info.sessionID) {
          speaking.set(info.sessionID, info.id);
          cap(speaking);
        }
        return;
      }
      if (type === "message.part.updated") {
        const part = props?.part;
        if (
          part?.type === "text" &&
          part.sessionID &&
          part.messageID === speaking.get(part.sessionID)
        ) {
          reply.set(part.sessionID, part.text ?? "");
          cap(reply);
        }
        return;
      }

      const sessionID = props?.sessionID;

      if (type === "session.idle") {
        const said = oneLine(clean(reply.get(sessionID) ?? ""));
        reply.delete(sessionID);
        // No reply to quote, so nothing worth interrupting you for. An
        // interrupted turn arrives here.
        if (!said) return;
        emit(sequence(truncate(said, MAX_PREVIEW)));
        return;
      }

      if (type === "permission.asked") {
        const label = labels.get(sessionID) || fallback;
        emit(
          sequence(
            label ? `${NEEDS_INPUT} - ${truncate(label)}` : NEEDS_INPUT,
          ),
        );
      }
    },
  };
};
