---
name: akasha-route-lock
description: Choose the first Akasha skill route and first review surface for a natural-language request before execution.
---
# akasha-route-lock

Use this skill when the first path is unclear and the next step must be one route, not a broad plan.

## Native execution

Collect:

- `request`: the user's current request

Call `run_intent`:

```json
{
  "intent": "akasha.route_lock",
  "parameters": {
    "request": "<current request>"
  }
}
```

## Output handling

Return the native result under `route_lock`. Treat `first_route` as the first review surface only. It does not authorize execution, file changes, network use, or completion.

If the selected route is risk-bearing, use the safety pack before proceeding.
