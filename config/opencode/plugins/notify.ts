// Desktop notification when a session goes idle (turn done).
//
// opencode loads local plugins from ~/.config/opencode/plugins/ (plural). The
// plugin runs in opencode's process, so process.stdout is the pane's terminal
// (the same path the documented zed-bell example uses). We emit OSC 777, which
// reaches Ghostty locally and over SSH, and DCS-wrap it ourselves when inside
// tmux since tmux does not forward OSC 9/777 natively.
//
// `process` is a Node/Bun global; declared here only so this dotfiles repo
// (which has no @types/node) stays lint-clean. It is erased at compile time.
declare const process: { env: Record<string, string | undefined>; stdout: { write(s: string): void } }

export const Notify = async () => ({
  event: async ({ event }: any) => {
    if (event.type !== "session.idle") return
    const ESC = "\x1b"
    const BEL = "\x07"
    let osc = `${ESC}]777;notify;opencode;turn complete${BEL}`
    if (process.env.TMUX) osc = `${ESC}Ptmux;${ESC}${osc}${ESC}\\`
    // Raw bell first flags the tmux window; then the (wrapped) desktop notification.
    process.stdout.write(BEL + osc)
  },
})
