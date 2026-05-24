---
name: autoskill
description: Observe the user's screen via screenpipe, detect repeated research workflows, match them against existing scientific-agent-skills, and draft new skills (or composition recipes that chain existing ones) for the patterns not yet covered. Use when the user asks to analyze their recent work and propose skills based on what they actually do. Requires the screenpipe daemon (https://github.com/screenpipe/screenpipe) running locally on port 3030 — the skill has no other data source and will refuse to run if screenpipe is unreachable. All detection runs locally; only redacted cluster summaries reach the LLM.
---

# AMA Desktop-Deferred Skill

allowed-tools: desktop runtime only

This skill is installed as part of `Scientific Deferred Desktop` for catalog visibility, but it is unavailable for local execution on AMA iOS.

## Required Mobile Flow

1. Do not attempt local execution on iOS.
2. Call `run_intent` with intent `scientific.deferred_desktop_preflight` if the user asks whether this can run.
3. Explain that this requires a future desktop/daemon bridge or a separate non-iOS runtime.

Recommended parameters:

```json
{
  "skill": "autoskill",
  "requestedRuntime": "desktop-only runtime"
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- iOS execution available: `false`.

## Reference Files Installed

- `.gitignore`
- `config.yaml`
- `references/https-proxy.md`
- `references/screenpipe-config.yaml`
