# Checklist

- Lock one bounded candidate only.
- State whether the target was discovered or user-specified.
- Name the dominant surface before proposing a slice.
- Prefer the smallest behavior-preserving slice over broad cleanup.
- Treat keeping cohesive code in one file/module as a valid result when splitting would add indirection, dependency churn, or weaker local reasoning.
- Recommend a split only when the boundary is real: different contract, owner, effect, test surface, change cadence, or reusable behavior.
- Recommend exactly one execute lane.
- Keep proof narrow and relevant to the chosen slice.
