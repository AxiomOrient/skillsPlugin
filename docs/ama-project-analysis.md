# AMA Project Analysis

This document summarizes the AMA skill runtime facts that skill authors must respect.

## Product Shape

AMA is a mobile-first agent runtime, not a desktop coding assistant. Skills are user-facing mobile behaviors loaded into the agent through a small skill tool surface and, when necessary, backed by iOS-native Swift capabilities.

## Skill Workspace

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Workspace/AMASkillWorkspace.swift`

AMA separates app support state from user-visible skill packages:

- `supportRootURL`: app support data for state, secrets, legacy imports.
- `userSkillsRootURL`: document-backed user skill packages.
- `stateFileURL`: `config/skills/state.json` under support root.
- `secretsFileURL`: `config/skills/skill-secrets.json` under support root.
- app-scoped default:
  - Application Support: `<Application Support>/<appName>/AMA/Skills`
  - Documents: `<Documents>/AMA/Skills`

Implication: a skill should not assume arbitrary filesystem access. Skill packages are copied into managed AMA skill directories.

## Install Surfaces

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Library/AMASkillLibrary+Plugins.swift`

AMA supports plugin install with these manifest locations:

- `ama-skill-plugin.json`
- `.ama-plugin/plugin.json`
- `.codex-plugin/plugin.json`

For AMA-specific packs, use `ama-skill-plugin.json`.

Plugin install behavior:

- Manifest validates `id`, `name`, `version`, and `description`.
- If `skills` is empty, AMA discovers immediate `skills/*/SKILL.md`.
- Each plugin skill is copied into the user skills root.
- Installed plugin skills use a directory name derived from plugin id and skill name.
- `uninstallSkillPlugin(id:)` removes all skill directories for that plugin and clears selection overrides.

Implication: category packs must be separate plugins. A single repository-wide plugin prevents category install/uninstall.

## Runtime Tool Surface

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Support/AMASkillsBridges.swift`

AMA exposes three skill tools:

- `load_skill`: read-only. Loads selected `SKILL.md` instructions.
- `run_js`: read-only. Runs an HTML/JS-backed skill script through the configured script runner.
- `run_intent`: approval-required. Executes native host intent surfaces.

Implication: skills should be written as short routing instructions for these tools. They should not describe desktop shell commands or unregistered tools.

## Script Execution

Evidence:

- `/Users/axient/repoAgent/AMA/Sources/AMASkillsWebKit/Runner/AMAWebKitSkillRunner.swift`
- `/Users/axient/repoAgent/AMA/Sources/AMASkills/Runtime/AMASkillExecution.swift`
- `/Users/axient/repoAgent/AMA/Sources/AMASkills/Runtime/AMASkillRuntime+RunJS.swift`

On platforms with WebKit, AMA can run HTML/JS-backed skills in a hidden `WKWebView`. The script must expose:

```js
window.ai_edge_gallery_get_result = async (inputJSON, secret) => {
  return JSON.stringify({ result: "..." });
};
```

The result can decode into `AMASkillScriptResponse` with:

- `result`
- `error`
- `webview`
- `image`
- `availableGenres`
- `artifacts`

Web imports that contain scripts, executable file extensions, or `run_js`/`run_intent` instructions are marked `unavailableOnMobile` unless AMA can trust the execution surface.

Implication: simple instruction-only skills should not mention `run_js`. Script-backed skills need deliberate WebKit-compatible packaging and mobile QA.

## Native Host Capabilities

Evidence:

- `/Users/axient/repoAgent/AMA/Sources/AMASkillsHost/Contracts/AMASkillHostIntents.swift`
- `/Users/axient/repoAgent/AMA/Sources/AMASkillsHost/Standard/AMASkillStandardDeviceHostIntents.swift`
- `/Users/axient/repoAgent/AMA/Sources/AMASkillsHostToolAdapter/Bridge/AMASkillHostToolAdapter.swift`

Host capabilities are Swift descriptors registered by the host app. Current standard areas include:

- artifacts: preview, share, export
- external URL opening
- Google Drive upload connector
- haptics
- screen brightness, status bar, idle timer
- torch
- clipboard
- system volume controls

Direct host intent execution requires a `ToolExecutionContext`; context-free execution is rejected.

Implication: if a skill needs a real device action, file export, connector upload, or app state mutation, implement the action in Swift and expose it as a host intent. The skill should only route to `run_intent`.

## Artifact Handling

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Runtime/AMASkillRuntimeArtifacts.swift`

Skill output artifacts are persisted through `ArtifactWriteRequest`; they are not arbitrary writes to local folders. Artifacts can be:

- image outputs
- attachment files
- primary files
- webview HTML artifacts

Implication: skills should ask the runtime to produce artifacts, then use host artifact intents for preview/share/export.

## Path And URL Rules

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Policies/AMASkillPathPolicies.swift`

AMA rejects:

- path traversal
- absolute package paths
- `~` paths
- workspace escapes
- insecure remote skill URLs except localhost development
- unsupported webview URL schemes

Allowed remote skill URLs are `https` or localhost `http`.

Implication: skill packages must use relative paths only and should not depend on external local paths.

## Frontmatter Contract

Evidence: `/Users/axient/repoAgent/AMA/Sources/AMASkills/Support/AMASkillMarkdownParser.swift`

`SKILL.md` requires frontmatter:

```yaml
---
name: skill-name
description: One clear mobile user-facing purpose.
metadata:
  require-secret: false
  require-secret-description:
  homepage:
---
```

Implication: the description is part of the prompt routing surface. It must describe when a mobile agent should select the skill.
