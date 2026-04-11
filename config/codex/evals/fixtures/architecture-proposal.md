Proposal: Hosted Runner for a General Agent Runtime

Summary

This proposal describes a supported way to run the runtime on a major cloud provider using dedicated virtual machines and a host-managed sandbox. The long-term product goal is to make one cloud the easiest place to deploy the runtime, so the provider's managed model API becomes the natural default for teams that want a supported path instead of a pile of shell scripts.

Non-goals

- Multi-tenant isolation on shared hosts
- A new core execution protocol
- Full bidirectional sync between local and remote workspaces

Proposal

Each user session gets a short-lived sandbox on a dedicated VM. The host is responsible for machine identity, short-lived token resolution, audit collection, and sandbox lifecycle. The sandbox is responsible only for running the workload and talking to narrowly scoped host-side services.

The control path should reuse the existing remote execution pattern, most likely SSH into a host-side launcher. We should avoid inventing a new transport unless the current model proves unworkable. The launcher creates the sandbox, stages the workspace, injects minimal runtime configuration, and forwards execution into the sandbox.

The working assumption is one sandbox per session. During the session, the remote workspace inside the sandbox is canonical. We are not proposing a fully mirrored local/remote model in v1. That is more complex, and the dedicated-host assumption makes it reasonable to optimize for a single remote-canonical execution model first.

Security model

The default runtime should be a lightweight host-managed sandbox rather than containers or microVMs. The main reasons are startup speed, lower packaging overhead, and closer alignment with the current host execution model. Stronger isolation technologies remain interesting, but they add operational complexity and can obscure debugging in a product that still needs operator visibility.

The host should remain the only place that resolves cloud identity. The sandbox should not receive broad, long-lived credentials. Instead, the host obtains short-lived scoped tokens and injects only the minimum runtime configuration needed for model access and storage access. User identity, workload identity, and sandbox identity must remain logically distinct even if they are all ultimately mediated by the host.

Network and audit controls should be built around two emerging capabilities:

- a host-level egress control path that can answer "what destination was attempted and was it allowed?"
- a syscall-observation path that can answer "what file or process action was attempted and what happened?"

These capabilities are promising and already useful for telemetry, but they are still young. The proposal assumes they will be sufficient to support a deny-by-default outbound policy plus useful operator audit logs in v1, with room to tighten policy later.

Why now

Several pieces that used to be missing are now available or close enough:

- a viable lightweight sandbox path on standard provider VMs
- better host-side visibility into outbound traffic and local execution
- enough recent demand for a "supported cloud path" that packaging now matters as much as core features

Taken together, this means the hosted runner can be a thin layer on top of the current runtime rather than a new platform. If we can make deployment easy enough, the cloud provider becomes the natural place to run the runtime and the provider model API becomes the default choice for teams that want the shortest path to production.

Distribution model

We should support two installation shapes:

- a machine image for the opinionated path
- a startup script for users who want the same outcome with more control

These should converge on the same runtime layout and management model. The image is better for the "click once, get a supported box" story. The startup script is better for gradual adoption and reproducible infra.

Operational model

The host owns:

- sandbox creation and teardown
- workspace staging
- token resolution
- audit export
- operator-facing health checks

The sandbox owns:

- runtime processes
- model requests through the approved path
- temporary files and working state for the live session

The current assumption is that sandbox state is short-lived and session-scoped. Durable artifacts should be exported explicitly rather than relying on the sandbox filesystem itself as a long-term storage layer.

Open questions

- How do we preserve clear end-user attribution once requests are mediated by a host launcher?
- What is the minimum useful audit story for v1 versus a stronger future policy story?
- What survives VM restart, sandbox crash, or reconnect?
- How strongly do we need to defend against bypassing the launcher from the remote entry path?
- Is the "thin layer, no major core changes" claim still true once we account for remote-canonical workspace semantics?
