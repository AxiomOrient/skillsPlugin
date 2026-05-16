# Templates

## Category Plugin

Path:

```text
plugins/<category>/ama-skill-plugin.json
```

```json
{
  "schemaVersion": "ama.skill.plugin.v1",
  "id": "io.axiomorient.ama.skills.<category>",
  "name": "AMA <Category> Skills",
  "version": "0.1.0",
  "description": "Mobile <category> skills for AMA.",
  "homepage": "https://github.com/AxiomOrient/skillsPlugin/tree/main/plugins/<category>",
  "skills": [
    {
      "path": "skills/<skill-name>",
      "selected": true
    }
  ]
}
```

## Instruction-Only Skill

Path:

```text
plugins/<category>/skills/<skill-name>/SKILL.md
```

```markdown
---
name: <skill-name>
description: <mobile user-facing trigger and outcome>
---

Use this skill when <specific mobile user request>.

Required input:
- <input>

If the input is missing, ask one concise follow-up question.

When ready, <answer or transform the content>.

Do not call tools for this skill.
```

## WebKit Skill

```markdown
---
name: <skill-name>
description: <mobile visual or deterministic transformation outcome>
---

Use this skill when <trigger>.

Collect:
- <field>

Call `run_js` with `index.html` and:

{
  "field": "<value>"
}

After the result, summarize what was created and offer share/export if an artifact exists.
```

```text
plugins/<category>/skills/<skill-name>/
  SKILL.md
  scripts/
    index.html
```

## Native Intent Skill

```markdown
---
name: <skill-name>
description: <native mobile action>
---

Use this skill when <trigger>.

Collect:
- <field>

Call `run_intent` with:

{
  "intent": "<registered.intent.name>",
  "parameters": {
    "field": "<value>"
  }
}

Report the host result. If approval or permission is denied, say that the action was not completed.
```
