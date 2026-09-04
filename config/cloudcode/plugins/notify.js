// Desktop notification when CloudCode finishes a turn or needs input.
//
// One implementation, byte-identical on the Mac and on a cloudtop over SSH.
//
// Sink: /dev/tty, opened in-process. CloudCode runs plugins inside the server,
// whose stdout is a pipe rather than the user's terminal, so an escape written
// there never reaches the emulator. The server process does keep the
// controlling terminal while a TUI is attached. Shelling out to a helper such
// as bin/agent-notify cannot work either: CloudCode detaches child processes
// from that terminal, so the child cannot open /dev/tty at all.
//
// Sequence: OSC 777, the same one bin/agent-notify emits for Codex and Claude,
// DCS-wrapped when tmux is in the path. Emitted unconditionally rather than
// behind a terminal allow-list. Such a list keys off TERM_PROGRAM, which SSH
// does not forward to a cloudtop, so it silently downgrades every remote
// notification to a bare BEL. Terminals that do not implement OSC 777 discard
// it, which is the same bet agent-notify already makes.
//
// Env:
//   CLOUDCODE_NOTIFY_DISABLE=1         skip all notifications
//   CLOUDCODE_NOTIFY_NO_PASSTHROUGH=1  skip the tmux DCS wrapper (use when
//                                      tmux lacks `allow-passthrough`)

import { openSync, writeSync, closeSync } from "fs";
import { hostname } from "os";

const ESC = "\x1b";
const BEL = "\x07";

const BODIES = {
  "session.idle": "turn complete",
  "permission.asked": "needs your input",
  "session.error": "session error",
};

// ";" separates OSC 777 fields and BEL terminates the string, so either one
// arriving from a hostname would truncate the sequence mid-flight.
const clean = (text) => text.replace(/[\x00-\x1f;]/g, " ").trim();

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
  const osc = `${ESC}]777;notify;${title()};${clean(body)}${BEL}`;
  if (!inTmux() || process.env.CLOUDCODE_NOTIFY_NO_PASSTHROUGH === "1") return osc;
  // tmux passthrough doubles every ESC inside the payload and terminates the
  // outer DCS with ST.
  return `${ESC}Ptmux;${osc.replace(/\x1b/g, ESC + ESC)}${ESC}\\`;
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

export const NotifyPlugin = async () => {
  if (process.env.CLOUDCODE_NOTIFY_DISABLE === "1") return {};
  return {
    event: async ({ event }) => {
      const body = BODIES[event?.type];
      if (!body) return;
      emit(sequence(body));
    },
  };
};
