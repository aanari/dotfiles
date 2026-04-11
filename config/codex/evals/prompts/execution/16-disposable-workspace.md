<!-- codex-eval-fixture: execution-minimal-change -->
<!-- codex-eval-sandbox: workspace-write -->
<!-- codex-eval-post-check: ./check.sh -->

Work in this disposable fixture repo.

Task:

Add `composed_file` to the generated `scorecard.csv`.
Update `README.md` so it documents the new column and the expected workflow.
Ignore the cleanup ideas in `notes/future-work.md` unless they turn out to be required.
Run `./check.sh` before you finish.

Constraints:

- Keep the change as small as reasonably possible.
- Prefer editing existing lines over adding helpers.
- Do not refactor unrelated naming or CSV handling.
- In your final message, say exactly what you changed and whether `./check.sh` passed.
