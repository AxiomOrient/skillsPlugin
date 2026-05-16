---
name: akasha-gate-judgment
description: Return ALLOW, WARN, HOLD, BLOCK, or ESCALATE for a proposed action using supplied checks, missing proof, and risk wording.
---
# akasha-gate-judgment

Use this skill when a decision must be opened, warned, held, blocked, or escalated before proceeding.

## Native execution

Collect:

- `text`: proposed action or decision
- optional `checksPassed`: number of checks known to have passed
- optional `checksFailed`: number of checks known to have failed
- optional `missingChecks`: missing proof items

Call `run_intent`:

```json
{
  "intent": "akasha.gate_judgment",
  "parameters": {
    "text": "<proposed action>",
    "checksPassed": 0,
    "checksFailed": 0,
    "missingChecks": []
  }
}
```

## Output handling

Return the native result under `gate_judgment`.

Only proceed on `ALLOW`. For every other judgment, report `required_before_continue` and stop unless the user explicitly resolves it.
