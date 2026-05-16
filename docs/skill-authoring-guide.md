# Skill Authoring Guide

Use this guide when writing a new AMA skill package.

## Minimal Skill

```text
plugins/create/skills/create-qr-code/
  SKILL.md
```

```markdown
---
name: create-qr-code
description: Create a QR code preview from text or a URL for sharing on mobile.
---

When the user asks to create a QR code, collect the text or URL to encode.
If the value is missing, ask one concise follow-up question.
When ready, call `run_js` with `index.html` and JSON data:

{
  "value": "<text or URL>",
  "label": "<optional label>"
}

After the preview is created, offer to share or export the artifact if the host exposes artifact intents.
```

## Frontmatter

Required:

- `name`: stable, kebab-case, mobile-user-facing.
- `description`: one sentence telling the model when to use the skill.

Optional metadata:

```yaml
metadata:
  require-secret: true
  require-secret-description: API key for the native service.
  homepage: https://example.com
```

## Instruction Body

The body should be short and operational:

- when to use the skill
- what inputs are required
- what tool to call, if any
- exact JSON shape
- what to say after success
- what to do when input is missing or permission is denied

Do not include long philosophical guidelines or desktop workflow rules.

## Tool Use Patterns

### Instruction-only

Use when the skill can answer from prompt/context/reference documents.

Do not call `run_js` or `run_intent`.

### WebKit script-backed

Use when the skill needs deterministic local transformation or a visual artifact.

`SKILL.md` should name the script and JSON payload. The script should return `AMASkillScriptResponse`.

### Native intent-backed

Use when the skill needs device or app actions.

`SKILL.md` should call:

```text
run_intent
```

with the exact registered intent name and parameters.

## Response Shape Rules

For `run_js`, scripts can return:

```json
{
  "result": "Created the preview.",
  "webview": {
    "url": "preview.html",
    "title": "Preview",
    "aspectRatio": 1.333
  },
  "artifacts": [
    {
      "filename": "preview.html",
      "mimeType": "text/html",
      "text": "<html>...</html>",
      "role": "webview"
    }
  ]
}
```

For `run_intent`, the host returns `ToolResult`; the skill should not invent success if the host reports failure.

## Mobile UX Rules

- Ask at most one focused follow-up question when required input is missing.
- Prefer previews, share sheets, export sheets, and native controls over file paths.
- Treat permissions and approval as normal user flow.
- Keep generated UI small, touch-friendly, and readable.
- Never tell the user to open terminal commands.
