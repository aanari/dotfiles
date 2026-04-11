`tool bridge`

The `tool bridge` command is the CLI surface that lets users inspect, run, and debug Bridge-related behavior locally.

It is not the same thing as the protocol itself, and it is not the same thing as BridgeX.

You can think about the three layers like this:

- Bridge: the protocol
- BridgeX: a packaged transport/profile for that protocol
- `tool bridge`: the user-facing command for working with Bridge from the CLI

Most confusion comes from people using the command name as shorthand for the whole stack.
