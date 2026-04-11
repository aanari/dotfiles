Contributor Note: Eval Run Layout

Summary

The eval harness writes each run under `~/.codex/eval-runs/<timestamp>/`.

Layout

- `manifest.csv` records `variant`, `prompt_id`, `category`, `output_file`, `events_file`, and `stderr_file` for each case
- `scorecard.csv` is a manual scoring sheet; the harness prepopulates identifying columns and leaves scoring columns blank
- `runs/<variant>/<category>/` contains the rendered prompt, final output, event log, and stderr for each case

Defaults

The prompts in this suite are analysis-only. They should not modify files. The harness keeps outputs grouped by run timestamp so multiple runs can be compared later without overwriting prior results.

Operational note

This layout is meant to optimize traceability and comparison, not storage efficiency. Old runs can be deleted manually when they are no longer useful.
