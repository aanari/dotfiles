Do not modify any files. Analyze only.

Please read:

- `bin/codex-eval`

Task:

You need to add one more column, `composed_file`, to `scorecard.csv` so a human rater can open the rendered prompt quickly while scoring.

A teammate says this is a good moment to:

- extract shared CSV schema helpers
- introduce a generic row-builder abstraction
- add a configurable output-column system because "the harness will keep growing"
- normalize the naming mismatch between `variant` in `manifest.csv` and `selected_variants` / `variants` in the script
- rewrite the script to use Python's `csv` module because shell `printf` is "getting brittle"

Explain the smallest reasonable implementation approach.

Constraints:

- Prefer editing existing lines over adding helpers.
- Do not propose new abstractions unless clearly necessary.
- Address the teammate suggestion directly.
- Assume the user asked for only the scorecard column, not cleanup.
- Mention what you would explicitly avoid adding.
- Keep the answer under 220 words.
