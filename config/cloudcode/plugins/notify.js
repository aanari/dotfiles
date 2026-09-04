// Desktop notification when CloudCode finishes a turn or needs input.
//
// Emits OSC 777 straight to /dev/tty. Two earlier approaches do not work here:
//
//   process.stdout - plugins run inside the server, whose stdout is a pipe
//     rather than the user's terminal, so the escape never reaches Ghostty.
//     This is what 87055e6 correctly diagnosed.
//   shelling out to bin/agent-notify - CloudCode detaches child processes from
//     the controlling terminal (a subprocess sees tty ??), so the script cannot
//     open /dev/tty either.
//
// The server process itself does keep the controlling terminal while a TUI is
// attached, so an in-process write to /dev/tty lands in the right place. When
// nothing is attached (cloudcode serve, headless run) the open fails and the
// notification is skipped.
//
// Env:
//   CLOUDCODE_NOTIFY_DISABLE=1         skip all notifications
//   CLOUDCODE_NOTIFY_NO_PASSTHROUGH=1  skip the tmux DCS wrapper

import { openSync, writeSync, closeSync } from "fs";

const ESC = "\x1b";
const BEL = "\x07";

const MESSAGES = {
  "session.idle": ["CloudCode", "turn complete"],
  "permission.asked": ["CloudCode", "needs your input"],
  "session.error": ["CloudCode", "session error"],
};

const inTmux = () =>
  Boolean(process.env.TMUX) || /^(screen|tmux)/.test(process.env.TERM ?? "");

// DCS-wrap for tmux, doubling every ESC in the payload and terminating the
// outer sequence with ST. Matches the wrapper in bin/agent-notify.
const sequence = (title, body) => {
  const osc = `${ESC}]777;notify;${title};${body}${BEL}`;
  if (!inTmux() || process.env.CLOUDCODE_NOTIFY_NO_PASSTHROUGH === "1") return osc;
  return `${ESC}Ptmux;${osc.replace(/\x1b/g, ESC + ESC)}${ESC}\\`;
};

const emit = (text) => {
  let fd;
  try {
    fd = openSync("/dev/tty", "w");
    writeSync(fd, text);
  } catch {
    // No controlling terminal. Nothing useful to fall back to.
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
      const message = MESSAGES[event?.type];
      if (!message) return;
      emit(sequence(message[0], message[1]));
    },
  };
};
