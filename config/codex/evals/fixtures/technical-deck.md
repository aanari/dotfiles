Slide 1

Hosted Runner: A Simpler Path to a Supported Cloud Deployment

Notes:

- We want the runtime to feel deployable, not merely installable.
- The goal is to turn operational friction into a product advantage.

Slide 2

Why this matters now

Notes:

- Recent platform work means the deployment layer can finally become strategically additive rather than operationally unfortunate.
- Teams are no longer asking only "can this run?" They are asking "what is the default supported way to run it without becoming part-time infrastructure staff?"

Slide 3

What we are proposing

Notes:

- One dedicated VM, one host-managed sandbox per session, one cloud-native path that feels coherent enough to recommend with a straight face.
- Reuse the current remote execution shape where possible instead of embarking on a transport innovation journey.

Slide 4

Why this is better than "just give them a script"

Notes:

- Scripts produce installations. Supported paths produce trust.
- The difference is not convenience alone; it is whether the operational shape is legible enough to become the team's default answer.

Slide 5

Security posture

Notes:

- The sandbox is not a magical trust boundary, but it is the right pragmatic boundary for v1.
- Host-side mediation, audit, and scoped identity should let us be usefully safe before we are perfectly elegant.

Slide 6

Business outcome

Notes:

- If we make this path easy enough, the cloud provider becomes the obvious place to run the runtime and the provider model API becomes the obvious model layer.
- Operational packaging can become distribution strategy rather than background toil.

Slide 7

What we are not doing

Notes:

- No ambitious sync model.
- No major core rewrite.
- No broad platform abstraction project disguised as a quick win.

Slide 8

Ask

Notes:

- Align on the hosted runner direction.
- Accept a pragmatic v1 security boundary.
- Invest in the smallest packaging layer that can plausibly become the supported default.
