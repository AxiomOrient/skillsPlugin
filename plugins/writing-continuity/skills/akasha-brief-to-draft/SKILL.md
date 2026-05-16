---
name: akasha-brief-to-draft
description: Turn a short brief into a structured first draft with tone lock, audience, assumptions, gaps, and revision checklist.
---
# akasha-brief-to-draft

Use this skill when the user provides a brief and wants a usable first draft, not a discussion about how to write one.

## Native execution

Collect:

- `brief`: the source brief
- `audience`: target reader
- optional `tone`: tone lock
- optional `format`: `memo`, `proposal`, `message`, or `doc`

Call `run_intent`:

```json
{
  "intent": "akasha.brief_to_draft",
  "parameters": {
    "brief": "<brief>",
    "audience": "<target reader>",
    "tone": "clear and bounded",
    "format": "doc"
  }
}
```

## Output handling

Return the native result under `draft_result`. Make clear that factual claims still require evidence review before final use.
