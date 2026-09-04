# Agent completion notifications

Get a desktop banner on your Mac when a coding agent finishes a turn or needs
input - locally and over SSH, inside and outside tmux. **No daemon, no compiled
binary.** It's a small plugin (CloudCode) or a small bash script (`agent-notify`),
all deployed by `fresh`. Identical setup on macOS and Linux.

## How it works

Each agent emits an OSC desktop-notification escape into its terminal. The escape
rides the terminal stream - DCS-wrapped through tmux and transparently over SSH -
to your **local Ghostty**, which renders the banner. Because it's terminal-mediated,
an agent running on the remote cloudtop still notifies your Mac.

## Install (same on macOS and Linux)

On the machine that runs the agent:

```sh
git -C ~/.dotfiles pull
fresh
```

Then restart the agent so it reloads config:

- CloudCode: `cloudcode --continue`
- Codex / Claude: relaunch

What `fresh` puts in place:

| Agent     | Config it deploys                              | Extra script?            |
| --------- | ---------------------------------------------- | ------------------------ |
| CloudCode | `~/.config/cloudcode/plugins/notify.js`        | no - self-contained      |
| Codex     | `~/.codex/config.toml` (`notify`)              | yes - `~/bin/agent-notify` |
| Claude    | `~/.claude/settings.json` (`Notification` hook)| yes - `~/bin/agent-notify` |

`agent-notify` is plain bash (printf to the terminal); bash ships on macOS and
Linux, so there is nothing to install. tmux passthrough (`allow-passthrough all`)
is already in `config/tmux.conf` and deploys with `fresh`.

CloudCode has no built-in notifier - there is no `attention` setting and no OSC
emitter anywhere in the binary, so do not try to configure one in `tui.json`
(an unrecognized key there voids the entire file). The plugin writes OSC 777 to
`/dev/tty` rather than to stdout, because plugins run inside the server whose
stdout is a pipe; it cannot shell out to `agent-notify` either, since CloudCode
detaches child processes from the controlling terminal.

## One-time, on your Mac only (human / GUI step)

This is where notifications render, so set it once per Mac:

**System Settings -> Notifications -> Ghostty**
- Allow Notifications: on
- Alert style: **Alerts** (so banners persist instead of vanishing into the drawer)

Ghostty only appears in that list after it has shown at least one notification, so
trigger one first (see Verify).

## Over SSH (cloudtop)

Works as long as the dotfiles are deployed on the remote, which gives you tmux
passthrough and the plugin. Nothing else is needed: the escape is emitted
unconditionally, so no environment has to survive the hop.

This is deliberate. An earlier version gated emission on a `TERM_PROGRAM`
allow-list copied from Codex, which cannot work here - `~/.ssh/config` does not
forward `TERM_PROGRAM`, and a corp `sshd` need not honour it even with
`SendEnv`. The variable is simply unset on the cloudtop, so every remote
notification silently degraded to a bare BEL. Emitting unconditionally removes
the dependency; terminals that do not implement OSC 777 discard it.

Remote banners are titled `CloudCode (<host>)` rather than plain `CloudCode`, so
a turn finishing on the cloudtop is distinguishable from one on the Mac.

## Verify

```sh
test-notifications      # byte-level checks + a real tmux passthrough test
```

Then trigger one real turn per agent. You should get a persistent banner. Nothing
here suppresses a notification while the terminal is focused, so you do not need
to switch windows to see one.

## Troubleshoot

- No banner on the Mac: Ghostty lacks Notification permission, or a Focus / Do Not
  Disturb is active.
- Banner appears but vanishes: set Ghostty's Alert style to **Alerts** (above).
- Nothing over SSH: `TERM_PROGRAM` not forwarded (above); confirm the remote tmux
  has `allow-passthrough`.
- CloudCode debugging: `~/.local/share/cloudcode/log/` - look for `service=plugin`
  and `type=session.idle publishing`.
