Codex eval suite

This suite is built around real work patterns from this machine:

- architecture critique
- proposal rewriting
- executive-readable prose
- technical explanation
- review-style analysis

The source material for these prompts lives in local anonymized fixtures under `config/codex/evals/fixtures/` plus dotfiles-local config files.

Most prompts are analysis-only so runs stay stable and comparable.
There is also one disposable workspace prompt under `prompts/execution/16-disposable-workspace.md` that exercises real edits, docs updates, and verification behavior in a copied fixture repo.

Variants:

- `with-global-instructions`
- `minimal-global-instructions`

These variants are meant to answer a specific question: what changes when the actual global instruction file we set in `model_instructions_file` is present versus a minimal neutral instructions file?

Typical run:

```sh
codex-eval --all
```

Current repo-focused run:

```sh
codex-eval --all --workdir /Users/ali/.dotfiles
```

Outputs go under `~/.codex/eval-runs/<timestamp>/`.

For the disposable workspace prompt, the harness also saves:

- a copied workspace under the run directory
- `*.status.txt`
- `*.diffstat.txt`
- `*.diff.txt`
- `*.post-check.log`
