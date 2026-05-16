---
name: akasha-summarize
description: Compress a session, document, or action log into a bounded Akasha capsule with summary, decisions, risks, open items, and next action.
---
# akasha-summarize

Use this skill when the user needs a compact handoff, session capsule, or bounded summary.

## Native execution

Collect:

- `text`: text to summarize
- optional `limitWords`: approximate summary word limit

Call `run_intent`:

```json
{
  "intent": "akasha.summarize",
  "parameters": {
    "text": "<text to summarize>",
    "limitWords": 80
  }
}
```

## Output handling

Return the native result under `summary_capsule`. This skill does not persist state. If persistence is needed, the host must provide a separate state-writing intent.
