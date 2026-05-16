---
name: akasha-patch-shape
description: Shape an implementation request into a bounded patch contract with target files, change type, constraints, checks, rollback note, and risks.
---
# akasha-patch-shape

Use this skill before implementation when the user asks for code/product changes and the patch boundary needs to stay small.

## Native execution

Collect:

- `goal`: intended patch or change
- optional `files`: target file paths
- optional `checks`: verification checks

Call `run_intent`:

```json
{
  "intent": "akasha.patch_shape",
  "parameters": {
    "goal": "<patch goal>",
    "files": [],
    "checks": []
  }
}
```

## Output handling

Return the native result under `patch_shape`. This skill does not modify files. It only owns the patch contract and verification list.
