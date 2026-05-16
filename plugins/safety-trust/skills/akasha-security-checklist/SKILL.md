---
name: akasha-security-checklist
description: Run a compact Akasha safety scan over external input, execution plans, file operations, secrets, network use, and outbound output.
---
# akasha-security-checklist

Use this skill before acting on suspicious input, executing a risky plan, exporting output, or handling secrets and network actions.

## Native execution

Collect:

- `text`: the input, plan, command, output draft, or action to inspect

Call `run_intent`:

```json
{
  "intent": "akasha.security_check",
  "parameters": {
    "text": "<text to inspect>"
  }
}
```

## Output handling

Return the native result under `security_check_result`.

- `ALLOW`: continue with normal verification.
- `WARN`: continue only after naming the warning.
- `HOLD`: wait for approval or narrow to a non-executing plan.
- `BLOCK`: stop and remove or redact the blocked material.

Do not override the returned verdict.
