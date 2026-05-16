# Validation Checklist

Use this before adding any skill or plugin pack.

## Repository Check

- No root-level `ama-skill-plugin.json` unless the whole repo is intentionally one plugin.
- No `.codex-plugin` manifests for AMA-native packs.
- No copied Codex `agents/openai.yaml`.
- No copied desktop process skills.
- Every installable pack lives under `plugins/<category>/`.

## Plugin Check

- `ama-skill-plugin.json` exists.
- `id` is stable and category-specific.
- `name`, `version`, and `description` are non-empty.
- `skills` paths are relative and stay inside the plugin.
- The plugin contains only one coherent mobile category.

## Skill Check

- `SKILL.md` has valid frontmatter.
- `name` is kebab-case and mobile-user-facing.
- `description` explains when AMA should select the skill.
- Instructions are short and operational.
- Required input and missing-input behavior are clear.
- Tool calls, if any, use only `run_js` or `run_intent`.

## Runtime Check

For instruction-only skills:

- `load_skill` returns the expected instructions.
- No `scripts/` directory exists.
- Instructions do not mention unavailable tools.

For WebKit skills:

- script exposes `window.ai_edge_gallery_get_result`.
- script accepts JSON string input.
- script returns a JSON-encoded `AMASkillScriptResponse`.
- output completes within mobile timeout.
- webview and asset paths are relative.

For native intent skills:

- Swift host intent exists and is registered.
- input schema matches the skill's JSON parameters.
- approval policy matches side effects.
- failure and denial results are handled.

## Mobile UX Check

- No terminal commands.
- No arbitrary local paths.
- No repository assumptions.
- No desktop automation language.
- Permission and approval states are user-readable.
- Artifact share/export paths use host surfaces.
