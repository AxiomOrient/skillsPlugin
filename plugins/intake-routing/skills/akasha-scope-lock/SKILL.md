---
name: akasha-scope-lock
description: Lock the current request into a bounded scope, explicit non-goals, done criteria, verification items, assumptions, and stop conditions through AMA native execution.
---
# akasha-scope-lock

Use this skill when a user request is broad, ambiguous, expanding, or likely to drift before execution.

## Native execution

Collect:

- `request`: the user's current request
- optional `inScope`: explicit included items
- optional `outOfScope`: explicit excluded items
- optional `doneWhen`: completion criteria
- optional `verification`: checks the result must satisfy

Call `run_intent`:

```json
{
  "intent": "akasha.scope_lock",
  "parameters": {
    "request": "<current request>"
  }
}
```

Pass optional arrays only when the user supplied them or they are needed to preserve a prior decision.

## Output handling

Return the native result under `scope_lock`. Do not claim execution or completion. The result only owns scope, non-goals, done criteria, verification list, assumptions, and stop conditions.

If the result says risk tokens are present, route next to `akasha-gate-judgment` or `akasha-security-checklist`.
