Memory Core Notes

The system has a background memory-consolidation feature called "dreaming." It is not a second live reasoning loop. It is a scheduled sweep that looks at recently useful short-term evidence and decides what, if anything, should become durable memory.

Recent change

Dreaming used to be split across loosely related jobs. It is now one managed sweep with three internal phases:

- light
- REM
- deep

The phases always run in that order when dreaming is enabled.

Inputs

The sweep currently pulls from:

- recent daily memory notes
- short-term recall and retrieval traces
- redacted session-derived snippets staged for analysis

Light

Light sleep is the staging phase. It gathers recent snippets, dedupes them, groups near-duplicates, and records weak reinforcement signals such as "this concept kept resurfacing."

REM

REM is the pattern phase. It looks for recurring concepts, recurring task shapes, and candidate "lasting truths." REM still does not write durable memory; it only enriches candidates with more evidence.

Deep

Deep sleep is the commit phase. It scores candidates using:

- frequency
- retrieval quality
- diversity of contexts and queries
- recency decay
- recurrence across multiple days
- concept richness

Only candidates that clear thresholds are promoted into `MEMORY.md`.

Outputs

- `memory/.dreams/` stores machine-readable intermediate state
- `DREAMS.md` stores human-readable summaries and a "dream diary"
- `MEMORY.md` stores durable promoted memory

Important boundaries

- The dream diary is not the source of truth
- Promotion is tied back to grounded snippets and current files
- Only deep sleep writes durable memory

Mental model

Think of dreaming as offline memory compaction plus promotion. If a fact or procedure keeps resurfacing across notes, searches, and sessions, dreaming is the process that notices the repetition and eventually turns it into a durable memory entry.
