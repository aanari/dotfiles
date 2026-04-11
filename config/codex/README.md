Codex layering

Operational layers:

1. `~/.codex/config.toml`
   Persistent defaults such as model, reasoning effort, trust, and UI settings.
2. `~/.codex/rules/default.rules`
   Approval allowlists for specific command prefixes.
3. CLI flags
   Per-run overrides such as `--yolo`, `-a never`, `-s danger-full-access`, and `-c key=value`.

Instruction layers:

1. Built-in Codex instructions
   App-owned. Do not edit internal Codex state for this.
2. `AGENTS.md`
   Best stable place for default writing and repo-specific guidance.

Practical use:

- Use `codex --yolo` when you want no approval friction for that run.
- Keep `config.toml` sane by default.
- Put default behavior changes in `AGENTS.md`.
- Use `EVALS.md` to compare instruction/config variants on your real task mix.
- Use `codex-eval` to run the local eval suite.
