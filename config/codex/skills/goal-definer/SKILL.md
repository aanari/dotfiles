---
name: goal-definer
description: Turn an underspecified task into a strong, auditable Goal. Use when a user wants help defining or refining a /goal for work whose path is uncertain but whose finish line can be verified.
---

# Define a strong Goal

Help the user turn a plain-language problem into one compact `/goal` that acts as a completion contract, not a larger task prompt.

## Decide whether a Goal fits

Use a Goal when the outcome has a clear finish line but the next action depends on what the model learns: debugging, profiling, benchmark tuning, flaky-test investigation, migrations, multi-step refactors, or evidence-backed research. A normal prompt is better for a one-off edit, explanation, short review, or vague request with no defensible finish line.

## Drafting method

Inspect the current conversation and available repository or research context first. Do not invent filenames, commands, thresholds, evidence, or permissions. Infer reasonable details only when they are visible in context; otherwise state an assumption or ask at most one concise question when the missing detail materially changes completion.

Build the Goal around these six elements:

1. **Outcome:** what must be true at the end, stated as an observable or measurable result.
2. **Verification surface:** the specific tests, benchmark, command output, artifact, report, or source evidence that proves it.
3. **Constraints:** behavior, APIs, tests, privacy, performance, or other properties that must not regress.
4. **Boundaries:** allowed files, repositories, data, tools, and external actions.
5. **Iteration policy:** after each attempt, inspect evidence, record what changed and what it showed, then choose the next highest-value valid action.
6. **Blocked stop condition:** when to stop without claiming success, and what to report: attempted paths, evidence gathered, blocker, uncertainty, and input needed to continue.

Use this compact shape when appropriate:

`/goal <desired end state>, verified by <specific evidence>, while preserving <constraints>. Use <boundaries>. After each attempt, <evidence and next-action policy>. If blocked or no valid path remains, stop and report <attempts, evidence, blocker, uncertainty, and needed input>.`

Make the Goal narrow enough to audit but broad enough to let the Agentic Harness discover the right path. Define what counts as complete before work begins. For research, require a claim inventory and an evidence ledger that separates confirmed results, approximate or proxy support, blocked claims, and remaining uncertainty; do not turn a plausible artifact into an exact reproduction claim.

## Response and lifecycle

Return the draft Goal first, in a single copyable code span. Add only brief notes about assumptions, missing information, or why a normal prompt is preferable. Do not activate, complete, pause, resume, or clear a Goal merely because you drafted it. If the user explicitly asks to activate an accepted Goal, preserve its boundaries and require concrete evidence before completion. Reaching a budget limit or encountering a blocker is not success.

Reference: https://developers.openai.com/cookbook/examples/codex/using_goals_in_codex
