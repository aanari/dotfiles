Bridge vs BridgeX

Bridge is the base protocol for connecting tools, runtimes, and external clients.

BridgeX is a packaged transport/profile around Bridge. It adds conventions for session packaging, richer envelopes, and a more opinionated wire format so different environments can interoperate with fewer bespoke adapters.

Important distinction:

- Bridge = the underlying protocol contract
- BridgeX = a compatibility and transport layer built on top of Bridge

In practice, people often blur the two because BridgeX is the most visible deployed form of Bridge in some environments.
