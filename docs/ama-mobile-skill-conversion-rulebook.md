# AMA Mobile Skill Conversion Rulebook

Date: 2026-05-24

## Final Review Verdict

The current scientific plugin restructuring is the right direction for AMA.

Evidence:

- `ama-skill-repository.json` declares 11 scientific category plugin packs and 142 total skills.
- Every scientific category pack has its own `ama-skill-plugin.json`.
- Manifest skill counts match actual `skills/*/SKILL.md` directories.
- The plugin tree contains no `.py`, `.sh`, `.ps1`, `.bat`, `.js`, `.ts`, `.swift`, `.m`, `.r`, `.R`, `.pdf`, or `.PDF` files.
- Live GitHub root install/uninstall smoke succeeded for `https://github.com/AxiomOrient/skillsPlugin`: 11 installs, 142 plugin skills, 11 removals, 0 remaining plugins.

The main design choice is sound: root GitHub URL is a catalog install source, while each category plugin remains the real install/uninstall unit. This gives users group install/delete without turning 142 skills into one unmanageable pack.

## Non-Negotiable Rules

1. Convert user value, not desktop implementation.
2. Keep Goal, Evolution, and other AMA core behavior inside AMA, not inside skill packs.
3. Use `plugins/<category>/ama-skill-plugin.json` as the category install unit.
4. Use root `ama-skill-repository.json` only as a GitHub catalog of category plugin paths.
5. Do not ship local helper programs in plugin packages.
6. Do not ship PDF binaries. Scientific document workflows must use Markdown or text-like artifacts unless a future Swift or approved remote document capability is added.
7. Preserve useful `references/`, `assets/`, templates, and eval-like Markdown material when they help mobile reasoning.
8. If a skill cannot execute locally on iOS, install it with an explicit route: `remote-preflight`, `ios-native`, `deferred-desktop`, or `instruction-only`.
9. Every runtime-backed skill must name a registered Swift host intent and expected payload shape.
10. Every changed pack must have a repeatable validation command or smoke proof.

## Conversion Routes

### Instruction-Only

Use when the skill is guidance, reasoning, writing, review, or reference lookup that can operate from chat context and included Markdown references.

Required:

- No `scripts/`.
- No local tool commands.
- No promise of filesystem, Python, Node, shell, MATLAB, or desktop app access.

### Swift Host Intent

Use when the skill needs iOS app state, artifacts, device permissions, network fetch policy, connector preflight, or deterministic native computation.

Required:

- `SKILL.md` tells the model to call `run_intent`.
- The intent exists in AMA host code.
- Tests verify the intent payload and mobile behavior.

### Remote Preflight

Use when the original skill requires Python/R/MATLAB/GPU/large-file processing or a cloud API.

Required:

- No local executable helper files are shipped.
- Skill instructions route to a Swift preflight intent.
- Preflight checks provider availability, user approval, artifact count, and sensitive data risk.
- Without a provider, the result must be blocked or deferred, not silently faked.

### Deferred Desktop

Use when the behavior is valuable to document but cannot reasonably run on iOS yet.

Required:

- The skill is installed so users can see what is unavailable.
- Runtime support is marked unavailable on mobile.
- The skill explains what desktop/runtime capability is missing.

### WebKit JavaScript

Use only for small browser-safe transformations.

Required:

- JavaScript runs inside AMA WebKit constraints.
- No Node packages, shell calls, filesystem assumptions, or native desktop APIs.
- Response matches AMA script result contracts.

## Category Design Rules

Use MECE categories. Each pack must have one coherent user or capability reason to exist.

Current scientific categories:

- `scientific-literature`: literature lookup and citation workflows.
- `scientific-reference`: scientific reasoning and writing guidance.
- `scientific-data-lookup`: public data/API lookup routing.
- `scientific-clinical-compliance`: clinical and QMS guidance with mobile safety guardrails.
- `scientific-documents`: Markdown-first document inspection and conversion guidance.
- `scientific-lab-connectors`: lab connector preflight guidance.
- `scientific-compute-remote`: Python/scientific compute routed to remote preflight.
- `scientific-web-research`: web/API research preflight.
- `scientific-visual-artifacts`: visual artifact workflow preflight.
- `scientific-reasoning-docs`: document-only reasoning packs.
- `scientific-deferred-desktop`: installed but unavailable desktop-only behavior.

Do not use Codex-style process categories such as `analyze`, `execute`, `review`, or `qa` unless the mobile user-facing job truly requires that vocabulary.

## File Conversion Rules

Remove from AMA plugin packages:

- `scripts/` unless approved as WebKit JavaScript.
- `.py`, `.sh`, `.ps1`, `.bat`, `.js`, `.ts`, `.swift`, `.m`, `.r`, `.R`, executable files.
- Desktop agent config files.
- CLI setup instructions as executable requirements.
- Binary PDF files.

Convert instead:

- Script behavior to Swift host intent specs or remote preflight instructions.
- CLI examples to Markdown references marked as non-local execution guidance.
- PDF document assumptions to Markdown-first import/export instructions.
- Desktop-only behavior to `deferred-desktop` route.

## Manifest Rules

Every plugin pack must include:

```text
plugins/<category>/ama-skill-plugin.json
plugins/<category>/skills/<skill-name>/SKILL.md
```

Every public repository install set must include:

```text
ama-skill-repository.json
```

The root catalog must list:

- `id`
- `path`
- `category`
- `skillCount`

The count must match actual `SKILL.md` directories.

## Validation Checklist

Run these before considering a conversion complete:

```sh
python3 -m json.tool ama-skill-repository.json >/dev/null
```

```sh
find plugins -type f \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -name '*.swift' -o -name '*.m' -o -name '*.r' -o -name '*.R' -o -name '*.pdf' -o -name '*.PDF' \)
```

```sh
cd tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Expected broad smoke signals:

```text
scientific_plugin_count=11
scientific_installed_skill_count=142
scientific_loaded_skill_count=142
scientific_executable_or_script_files=0
scientific_script_runner_calls=0
scientific_pdf_installed=false
```

For AMA code changes:

```sh
cd /Users/axient/repoAgent/AMA
swift test --filter 'RemoteSkill|Plugin'
```

For AMASample iOS integration:

```sh
xcodebuild test \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -scheme AMASampleService \
  -destination 'platform=iOS Simulator,name=iPad (A16)' \
  -only-testing AMASampleServiceTests
```

For GitHub publication:

- Confirm `https://raw.githubusercontent.com/AxiomOrient/skillsPlugin/main/ama-skill-repository.json` returns HTTP 200.
- Run a live install/uninstall smoke from `https://github.com/AxiomOrient/skillsPlugin`.

## When To Reject A Conversion

Reject or defer when:

- The skill only automates desktop agent engineering process with no mobile user job.
- Required behavior depends on unapproved local execution.
- The skill cannot truthfully explain its mobile limitations.
- The category would mix unrelated install/delete concerns.
- The conversion removes so much context that the skill becomes empty or misleading.

