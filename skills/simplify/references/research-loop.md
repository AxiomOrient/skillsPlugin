# Research Loop

Use this loop when the skill misses valid simplification candidates or over-recommends cosmetic churn.

## Source Priority

1. Official product docs for evaluation and workflow primitives
2. Local skill conventions and neighboring execution skills
3. Real misses from recent repository work

## Loop

1. Capture the missed candidates exactly.
2. Classify the miss:
- missing lens coverage
- poor prioritization
- weak stop rules
- proof guidance mismatch
- delegation contract mismatch
- scope manifest mismatch
3. Update one of:
- trigger description
- lens definitions
- checklist
- eval cases
4. If the miss happened in a large repo, replay it as read-only auto-research:
- make one scope manifest
- run separate reuse, quality, efficiency, and proof-mapping investigations
- require file:line evidence and proof suggestions
- synthesize in the main flow and choose one slice only
5. Re-run the local validation task from `eval.md`.
6. Keep the revision only if the missed candidate is now detected without widening into architecture churn.
