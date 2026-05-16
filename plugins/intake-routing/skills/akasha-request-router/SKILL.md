---
name: akasha-request-router
description: Classify an Akasha request into mode, branch, source path hints, bans, risks, verification expectation, and one next action.
---
# akasha-request-router

Use this skill for vague, broad, or multi-step requests when the answer should be a bounded Akasha route decision.

## Native execution

Collect:

- `request`: the user's current request

Call `run_intent`:

```json
{
  "intent": "akasha.request_route",
  "parameters": {
    "request": "<current request>"
  }
}
```

## Output handling

Return the native result under `route_decision`. Use `next_action` as a routing recommendation, not as proof that the work is complete.

If `risks` is non-empty, run `akasha-security-checklist` and `akasha-gate-judgment` before side effects.
