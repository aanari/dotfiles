# Agent completion notifications

Get a desktop banner on your Mac when a coding agent finishes a turn or needs
input - locally and over SSH, inside and outside tmux. **No daemon, no compiled
binary.** It's native config (CloudCode) or a small bash script (`agent-notify`),
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
| CloudCode | `~/.config/cloudcode/tui.json` (`attention`)   | no - native to the TUI   |
| Codex     | `~/.codex/config.toml` (`notify`)              | yes - `~/bin/agent-notify` |
| Claude    | `~/.claude/settings.json` (`Notification` hook)| yes - `~/bin/agent-notify` |

`agent-notify` is plain bash (printf to the terminal); bash ships on macOS and
Linux, so there is nothing to install. tmux passthrough (`allow-passthrough all`)
is already in `config/tmux.conf` and deploys with `fresh`.

## One-time, on your Mac only (human / GUI step)

This is where notifications render, so set it once per Mac:

**System Settings -> Notifications -> Ghostty**
- Allow Notifications: on
- Alert style: **Alerts** (so banners persist instead of vanishing into the drawer)

Ghostty only appears in that list after it has shown at least one notification, so
trigger one first (see Verify).

## Over SSH (cloudtop)

Works as long as your dotfiles are deployed on the remote (tmux passthrough + the
config). If banners do not appear over SSH, the usual cause is that SSH does not
forward the terminal identity. Forward it:

```sh
# local ~/.ssh/config
Host <cloudtop-host>
  SendEnv TERM_PROGRAM
# remote /etc/ssh/sshd_config (often already allowed)
AcceptEnv TERM_PROGRAM
```

Confirm on the remote: `echo $TERM_PROGRAM` should print `ghostty`.

## Verify

```sh
test-notifications      # byte-level checks + a real tmux passthrough test
```

Then trigger one real turn per agent and **switch to another window** - CloudCode's
native notifier only fires when the terminal is blurred (by design). You should get
a persistent banner.

## Troubleshoot

- No banner on the Mac: Ghostty lacks Notification permission, a Focus / Do Not
  Disturb is active, or the terminal was still focused (native fires only on blur).
- Banner appears but vanishes: set Ghostty's Alert style to **Alerts** (above).
- Nothing over SSH: `TERM_PROGRAM` not forwarded (above); confirm the remote tmux
  has `allow-passthrough`.
- CloudCode debugging: `~/.local/share/cloudcode/log/` - look for `service=plugin`
  and `type=session.idle publishing`.
