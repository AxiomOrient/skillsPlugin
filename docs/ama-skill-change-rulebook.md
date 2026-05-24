# AMA Skill Change And Conversion Rulebook

Date: 2026-05-24

## Final Review

The current structure is the best current direction for AMA because it separates AMA core behavior, GitHub repository cataloging, category plugin install units, and individual mobile skills.

Evidence:

- AMA core keeps Goal, Evolution, skill loading, plugin install state, source tracking, and mobile execution classification inside the app package.
- `skillsPlugin` uses `ama-skill-repository.json` as the GitHub install catalog and `plugins/<category>/ama-skill-plugin.json` as the install/uninstall unit.
- AMA `load_skill` exposes installed supporting files through bounded `supportingFiles` context, so converted packs can keep useful `references/`, `eval/`, and text assets without depending on local script execution.
- The repository catalog declares 15 category plugins and 150 skills.
- The scientific subset remains MECE: 11 scientific plugins and 142 skills.
- Plugin packages ship Markdown and static references, not Python, shell, PowerShell, batch, Node, R, MATLAB, Swift helpers, PDFs, or desktop executable scripts.
- Runtime-backed skills route through `run_intent` to Swift host capabilities or explicit remote/deferred preflight.

This is better than copying Codex or Claude skills directly because AMA runs on iOS. The skill should describe the mobile user job and the allowed tool route; deterministic execution belongs in Swift host intents, and large external runtimes belong behind explicit remote preflight.

Current verification evidence:

- `swift test --filter 'RemoteSkill|Plugin'` in `/Users/axient/repoAgent/AMA`: 17 selected skill/plugin tests passed.
- `swift test --filter 'importRemoteSkill'` in `/Users/axient/repoAgent/AMA`: 2 direct remote import tests passed.
- `swift run AMAScientificAllPluginSmoke` in `tools/ama_scientific_all_plugin_smoke`: 15 plugins, 150 skills, 11 scientific plugins, and 142 scientific skills installed and loaded.
- `swift run AMAScientificAllPluginSmoke --live-github` in `tools/ama_scientific_all_plugin_smoke`: GitHub root URL installed 15 plugins and 150 skills, then removed 15 plugins and left 0 installed plugins for that source.
- `xcodebuild test -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace -scheme AMASampleService -destination 'platform=iOS Simulator,name=iPad (A16)' -only-testing AMASampleServiceTests`: 25 iOS simulator service tests passed.
- Documentation inventory for `README.md` and `docs/` resolves all indexed links.

The structure should not be changed again unless a new requirement breaks one of these facts. Prefer adding a new category plugin or a new Swift host intent over changing the repository catalog contract.

## Decision Rules

Use these rules before changing any skill:

1. Keep AMA product capabilities in AMA core, not in plugin packs.
2. Keep repository install cataloging in `ama-skill-repository.json`, not in a repository-wide `ama-skill-plugin.json`.
3. Keep install/delete granularity at `plugins/<category>/ama-skill-plugin.json`.
4. Use categories that describe mobile user value or capability, not desktop agent process names.
5. Convert the user outcome, not the original desktop implementation.
6. Preserve useful Markdown references, examples, templates, eval notes, and static assets.
7. Remove executable helper files unless the runtime is an approved WebKit JavaScript path.
8. Replace scripts and external programs with Swift `run_intent`, remote preflight, deferred desktop status, or instruction-only guidance.
9. Mark mobile-unavailable behavior explicitly; never imply that iOS can run Python, shell, MATLAB, Node, Docker, or desktop automation locally.
10. Every changed pack must pass install, load, manifest, no-executable, and route verification.

## Change Workflow

1. Classify the source skill:
   - instruction-only
   - Swift host intent
   - remote preflight
   - deferred desktop
   - WebKit JavaScript
2. Assign exactly one category plugin.
3. Rewrite the skill name and description around the mobile user job.
4. Move `SKILL.md` and useful Markdown references under `plugins/<category>/skills/<skill-name>/`.
5. Delete unsupported executables, scripts, PDFs, local path assumptions, desktop agent configs, and CLI-only instructions.
6. Add or update `plugins/<category>/ama-skill-plugin.json`.
7. If the pack is public, add or update the category entry in `ama-skill-repository.json`.
8. If a skill calls `run_intent`, confirm the Swift host intent exists, is registered, and has a tested payload.
9. Run validation and smoke tests.
10. Update docs only after code and catalog behavior are verified.

## Conversion Routes

### Instruction-Only

Use for reasoning, writing, review, summarization, and reference-guided answers.

Rules:

- No `scripts/`.
- No local filesystem, terminal, package manager, or desktop app assumption.
- `load_skill` alone must provide enough instruction to produce a useful answer.

### Swift Host Intent

Use for iOS app state, device APIs, artifact handling, deterministic computation, permissions, connector preflight, and native integrations.

Rules:

- `SKILL.md` tells the model to call `run_intent`.
- The intent name is stable.
- The payload shape is documented in the skill.
- Failure, denial, and unavailable-provider results are user-readable.

### Remote Preflight

Use for API search, Python/R/MATLAB/GPU, large data, external scientific packages, or provider-backed compute.

Rules:

- The skill calls a Swift preflight intent first.
- The preflight checks provider availability, user approval, credentials, cost/data risk, and artifact limits.
- If no provider is configured, the skill reports blocked or deferred status.

### Deferred Desktop

Use when the original behavior is valuable to preserve but cannot run on iOS yet.

Rules:

- Install the skill for visibility.
- Mark or state mobile execution as unavailable.
- Explain the required missing runtime or future Swift/remote adapter.

### WebKit JavaScript

Use only for small browser-safe transformations.

Rules:

- No Node packages.
- No filesystem.
- No network-only hidden dependency unless the host explicitly provides it.
- Output must follow AMA script response contracts.

## Category Rules

Use MECE categories. A plugin category should have one reason to install and one reason to remove.

Allowed examples:

- `intake-routing`
- `safety-trust`
- `writing-continuity`
- `engineering-control`
- `scientific-literature`
- `scientific-documents`
- `scientific-compute-remote`

Avoid:

- `analyze`
- `execute`
- `review`
- `qa`
- `misc`
- `tools`

## Manifest Rules

Each plugin pack must include:

```text
plugins/<category>/ama-skill-plugin.json
plugins/<category>/skills/<skill-name>/SKILL.md
```

The GitHub install catalog must include:

```text
ama-skill-repository.json
```

The catalog must list only real plugin paths and accurate skill counts.

Do not use `.codex-plugin/plugin.json` for AMA-native packs.

## Verification Gates

Run:

```sh
python3 -m json.tool ama-skill-repository.json >/dev/null
```

Run:

```sh
find plugins -type f \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -name '*.swift' -o -name '*.m' -o -name '*.r' -o -name '*.R' -o -name '*.pdf' -o -name '*.PDF' \)
```

Expected output is empty unless an approved WebKit JavaScript exception is documented.

Run:

```sh
cd tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Expected broad signals:

```text
all_plugin_count=15
all_installed_skill_count=150
all_loaded_skill_count=150
scientific_plugin_count=11
scientific_installed_skill_count=142
scientific_loaded_skill_count=142
scientific_executable_or_script_files=0
scientific_script_runner_calls=0
scientific_pdf_installed=false
scientific_python_route=blocked_remote_compute
scientific_matlab_route=ios_native
```

For live GitHub install/uninstall verification after publishing, run:

```sh
cd tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke --live-github
```

Expected live signals:

```text
live_github_installations=15
live_github_plugin_skills=150
live_github_removed=15
live_github_final_plugins=0
```

For AMA package changes, run:

```sh
cd /Users/axient/repoAgent/AMA
swift test --filter 'RemoteSkill|Plugin'
swift test --filter 'importRemoteSkill'
```

For AMASample iOS proof, run:

```sh
xcodebuild test \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -scheme AMASampleService \
  -destination 'platform=iOS Simulator,name=iPad (A16)' \
  -only-testing AMASampleServiceTests
```

## Completion Standard

A skill change is complete only when:

- the category and install unit are clear
- unsupported desktop execution has been removed or explicitly routed
- GitHub root or category URL install works
- installed skills can be loaded through AMA
- uninstall removes the same source cleanly
- docs state the same behavior as code
- iOS simulator verification passes when host behavior changed
