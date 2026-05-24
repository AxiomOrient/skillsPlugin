# AMA Skill Rulebook

These rules are mandatory for skills in this repository.

## 1. Mobile Purpose First

Every skill must serve an end-user mobile task. Do not add development-process skills unless the task is explicitly useful inside the mobile agent experience.

Good:

- "Summarize a captured note and offer share/export actions."
- "Turn a user prompt into a QR code preview."
- "Log a mood entry and show a simple trend."

Bad:

- "Review project completion."
- "Run XcodeBuildMCP."
- "Analyze repository architecture."

## 2. Plugin Category Is The Install Unit

Do not put all skills into one plugin. Use category plugins so users can install and remove a coherent pack.

Required pattern:

```text
plugins/<category>/ama-skill-plugin.json
plugins/<category>/skills/<skill-name>/SKILL.md
```

Examples:

- `plugins/create`
- `plugins/device`
- `plugins/productivity`
- `plugins/media`
- `plugins/knowledge`
- `plugins/export`

## 3. Prefer AMA-Specific Names

Skill names should describe mobile user outcomes, not desktop process lanes.

Use:

- `create-qr-code`
- `device-torch-control`
- `note-to-shareable-summary`
- `artifact-export-assistant`

Avoid:

- `analyze-*`
- `execute-*`
- `review-*`
- `qa-*`
- `xbmcp-*`

Those names describe development workflow, not mobile user value.

## 4. Instruction-Only Skills Must Stay Instruction-Only

If a skill has no executable backing, it must not mention `run_js`. It should tell the model how to respond using available chat context.

It may mention `run_intent` only when the plugin manifest, QA document, or AMA host code identifies a registered Swift host intent that owns the behavior. In that case the skill is not instruction-only; it is a thin host-intent skill.

Instruction-only skills can include:

- `references/`
- static examples
- short decision rules
- response style guidance

They must not include:

- `scripts/`
- `.py`, `.sh`, `.js`, `.ts`, `.rb`, `.php`
- instructions to use shell, CLI, local repo tools, or desktop apps

If the source skill originally required scripts or desktop tools, preserve the useful reference material but mark execution as mobile-unavailable, remote-preflight, deferred-desktop, or Swift-host-intent backed. Do not hide the missing runtime.

## 5. WebKit Skills Must Be Mobile-Sized

If a skill uses `run_js`, it must be written for AMA's WebKit runner:

- entrypoint is an HTML or JS-backed file under `scripts/`
- exposes `window.ai_edge_gallery_get_result(inputJSON, secret)`
- returns JSON matching `AMASkillScriptResponse`
- finishes quickly; current runner uses a 15 second timeout
- uses relative assets inside the skill package

Do not port desktop Node or Python helpers into `scripts/`.

## 6. Device Or App Actions Must Be Swift

If a behavior requires device state, app state, filesystem export, connector upload, permissions, or external app interaction, implement the behavior as a Swift host intent in AMA.

The skill should call `run_intent` only with registered intent names and parameters.

## 6a. External Runtime Work Must Be Routed

Python, R, MATLAB, shell, Node, desktop browser automation, GPU workloads, large scientific files, and external service operations must not run locally inside an iOS skill package.

Allowed routes:

- `remote-preflight`: install the skill and route work to a Swift preflight intent that checks provider, consent, artifact count, and data sensitivity.
- `ios-native`: replace the narrow behavior with a Swift host intent, such as numeric evaluation or Markdown artifact rendering.
- `deferred-desktop`: install the skill as unavailable on mobile and explain why a desktop/runtime environment is required.
- `instruction-only`: keep only documentation and response guidance when no execution is required.

## 7. Artifacts Are Runtime Outputs

Skills do not write files into arbitrary folders. They produce artifacts through the runtime response and then use host artifact intents for preview, share, or export.

## 8. Secrets Are Explicit

If a skill requires a secret, declare it in frontmatter. The runtime will check the configured secret before script execution.

## 9. No Hidden Desktop Assumptions

A valid AMA skill cannot require:

- terminal access
- git
- local repository layout
- Xcode command line tools
- Python packages
- Node packages
- desktop browser automation
- arbitrary local file paths

## 10. Each Skill Must Be Testable In AMA Terms

Every proposed skill must include a validation note or checklist showing:

- load path: `load_skill`
- optional execution path: `run_js` or `run_intent`
- expected output shape
- mobile permission or approval behavior
- artifact behavior, if any

## 11. Repository Root Is A Catalog, Not A Plugin

The repository may expose `ama-skill-repository.json` at the root so AMA can install all declared category packs from a GitHub URL. That file is a catalog/index only.

Do not replace category plugin manifests with one repository-wide `ama-skill-plugin.json`. Users must still be able to install or remove each coherent category pack.
