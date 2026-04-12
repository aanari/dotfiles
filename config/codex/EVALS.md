Codex behavior evals

The goal is not to find the prettiest wording. The goal is to find the smallest default behavior change that improves real work without making the model softer, chattier, or less precise.

Core principle:

- Evaluate on your own task mix, not generic benchmark trivia.

Suggested variants:

1. Codex with the current global instructions file
2. Codex with a minimal neutral global instructions file

Task buckets:

1. Back-and-forth
2. Design docs
3. Execution

Sample prompts:

Back-and-forth:

- "Push back on this architecture decision and tell me what is weak about it."
- "Rewrite this paragraph so it sounds more natural but still technically serious."
- "Help me think through the tradeoff between speed and safety here."

Design docs:

- "Take these notes and turn them into a proposal section that flows well in prose."
- "Make this document more executive-readable without dumbing it down."
- "Reduce the bullet spam and make the argument tighter."

Execution:

- "Go make this change and keep me updated as you work."
- "Review this file and focus on bugs, regressions, and missing tests."
- "Refactor this explanation so it is clearer, shorter, and more direct."
- Include at least one disposable workspace task that requires a real edit, a doc update, and a lightweight verification command.
- Include at least one disposable workspace task that requires partial progress plus an explicit stop before a higher-blast-radius action.

Scoring rubric:

Score each output from 1 to 5 on:

- Naturalness
- Concision
- Correctness
- Directness
- Willingness to act
- Non-annoyingness

Failure modes to watch:

- sounds like a memo
- too much recap
- too many bullets
- too much hedging
- explains instead of acting
- warmer, but less precise

Recommended workflow:

1. Pick 8 to 12 prompts from your real work.
2. Make sure at least one prompt is a real execution task in a disposable fixture repo.
3. Run each prompt against each variant.
4. Save the transcripts.
5. For execution prompts, inspect the diff and check artifacts, not just the final message.
6. Score them quickly.
7. Tune only the smallest default layer that addresses the recurring failures.

Keep the surrounding config stable, change only the instruction file layer, and evaluate on real usage.
