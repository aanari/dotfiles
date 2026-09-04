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

### If banners still vanish

The macOS banner is not the only signal, and it is the least reliable one: how
long it stays up is entirely up to that Alert style setting, and macOS will
replace rather than stack repeat notifications from one app.

The durable signals come from Ghostty itself, driven by the bare BEL that every
notifier here sends ahead of the OSC. They are governed by `bell-features` in
`config/ghostty/config`, and unlike the banner they persist by construction:

| feature     | effect                                        | clears when          |
| ----------- | --------------------------------------------- | -------------------- |
| `attention` | bounces the Ghostty dock icon                 | Ghostty regains focus |
| `title`     | prefixes the tab title with a bell emoji      | re-focus or keypress |
| `border`    | draws a border around the alerted surface     | re-focus or keypress |

`config/ghostty/config` sets `bell-features = title,attention`, so those two are
on and `border` is not. Add `border` to that line if you want something visible
without checking the dock. Audio stays off because Ghostty defaults to
`no-audio,no-system`; you do not have to silence anything.

So a missed banner is recoverable: the dock icon is still bouncing and the tab
still reads with a bell until you look at it.

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

The body is what the assistant actually said, previewed at 200 characters on one
line. That is what makes the banner worth reading: "turn complete" tells you a
turn ended, which you can already see.

Both comparable agents do exactly this, so the plugin follows them rather than
inventing something. Codex previews its response at 200 graphemes and falls back
to "Agent turn complete" only when the response is empty; Claude Code hands hooks
the whole thing as `last_assistant_message` and its docs specifically recommend
that field over parsing the transcript, for notification hooks.

CloudCode exposes no equivalent field, so the plugin accumulates it: the assistant
message id comes from `message.updated`, its text from the `message.part.updated`
events that stream under that id. Only text under the id flagged `assistant`
counts, so your own prompt is never quoted back at you.

When there is nothing to quote - a prompt for input, or a turn that produced no
text - the banner falls back to naming the state and the session, taking the title
from `session.updated` and then the directory name.

Interrupting a turn with ctrl-c raises `session.error`, and that fires no
notification at all. Being told a session errored at the moment you deliberately
stopped it is noise; you are already at the keyboard. Claude Code draws the same
line, its `Stop` hook explicitly not running on a user interrupt. The cost is that
a genuine overnight API failure also passes unannounced - reinstating only that
case needs the abort told apart from a real error, and the payload arriving on
ctrl-c has not been pinned down.

## Verify

```sh
test-notifications      # byte-level checks + a real tmux passthrough test
```

Then trigger one real turn per agent. You should get a banner, plus a bouncing
dock icon and a bell on the tab title that stay until you look. Nothing here
suppresses a notification while the terminal is focused, so you do not need to
switch windows to see one.

## Troubleshoot

- No banner on the Mac: Ghostty lacks Notification permission, or a Focus / Do Not
  Disturb is active.
- Banner appears but vanishes: set Ghostty's Alert style to **Alerts** (above). If
  it still vanishes, that is macOS, not this wiring - rely on the dock bounce and
  the tab bell instead (see "If banners still vanish").
- Nothing over SSH: confirm the remote tmux has `allow-passthrough` and that the
  plugin is deployed there. `TERM_PROGRAM` is irrelevant - nothing keys off it any
  more.
- CloudCode debugging: `~/.local/share/cloudcode/log/` - look for `service=plugin`
  and `type=session.idle publishing`.
