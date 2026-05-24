# Scientific Reference AMA QA

Date: 2026-05-16

## Scope

This document records the second AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-reference`

Converted skills:

- `scientific-brainstorming`
- `scientific-critical-thinking`
- `peer-review`
- `scientific-writing`
- `what-if-oracle`

The conversion target is iOS AMA. This category is documentation-only: it preserves plain reference material and removes executable desktop behavior.

## Mobile Capability

The plugin installs as one category with `ama-skill-plugin.json`. Each skill has a mobile-specific `SKILL.md` and includes upstream plain-document references when applicable.

Included reference and asset material:

- `scientific-brainstorming/references/brainstorming_methods.md`
- `scientific-critical-thinking/references/*`
- `peer-review/references/*`
- `scientific-writing/references/*`
- `scientific-writing/assets/*` as inert formatting references
- `what-if-oracle/references/scenario-templates.md`

Excluded behavior:

- no upstream `scripts/`
- no Python, shell, PowerShell, batch, Node, MATLAB, local CLI, package manager, or desktop automation files
- no local figure-generation commands

## AMA Runtime Improvement

During this slice, AMA plugin installation was corrected to evaluate mobile execution support for plugin skills, not only web-imported skills.

Expected behavior:

- plugin skills with `scripts/`, executable script extensions, `run_js`, or desktop command markers install successfully but are marked `executionSupport == unavailableOnMobile`
- plugin skills that only call AMA native host intents through `run_intent` stay `executionSupport == available`
- documentation-only plugin skills stay `executionSupport == available`

This directly supports the product rule: install reference material, but do not pretend iOS can execute external programs.

## Product Tests

AMA package tests:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter installSkillPlugin
swift test --filter scientificLiterature
```

Result:

- Passed.
- Verified plugin install/uninstall, duplicate rejection, traversal rejection, script-backed plugin execution gating, and native-intent plugin availability.
- Verified scientific literature regression after the plugin execution-support change.

AMASample local AMA package tests:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter installSkillPlugin
swift test --filter scientificLiterature
```

Result:

- Passed after syncing `/Users/axient/repoAgent/AMA` into `/Users/axient/repoAgent/AMASample/LocalPackages/AMA`.

AMASample iOS simulator tests:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificReferenceDerivedData
```

Result:

- Passed 23 tests.
- Added scenario `ama-skills-plugin-mobile-execution-support`.
- The scenario installs a temporary plugin, confirms references are copied, confirms a script-backed skill is marked unavailable on iOS, confirms a native-intent skill remains available, and confirms `load_skill` exposes native intent instructions.

An initial simulator run failed because the new verification scenario used the default Keychain-backed secret store. The scenario was fixed to inject a no-op verification secret store, removing unrelated Keychain dependency from the plugin validation path.

## Real Use Test

A temporary Swift package at `/tmp/ama-reference-live` installed the real plugin from:

```text
/Users/axient/repoAgent/skillsPlugin/plugins/scientific-reference
```

Observed result:

```text
reference_installation_id=io.axiomorient.ama.scientific.reference
reference_skill_count=5
reference_skill=peer-review|support=available|selected=true
reference_skill=scientific-brainstorming|support=available|selected=true
reference_skill=scientific-critical-thinking|support=available|selected=true
reference_skill=scientific-writing|support=available|selected=true
reference_skill=what-if-oracle|support=available|selected=true
critical_loaded_ok=true
critical_contains_bias=true
writing_loaded_ok=true
writing_contains_imrad=true
local_scripts_executed=false
```

This proves the actual plugin pack installs, loads, and exposes the expected research-review and writing concepts through AMA without scripts.

## Desktop Comparison

Desktop source reference:

- `/tmp/scientific-agent-skills/scientific-skills/scientific-brainstorming`
- `/tmp/scientific-agent-skills/scientific-skills/scientific-critical-thinking`
- `/tmp/scientific-agent-skills/scientific-skills/peer-review`
- `/tmp/scientific-agent-skills/scientific-skills/scientific-writing`
- `/tmp/scientific-agent-skills/scientific-skills/what-if-oracle`

Quality judgment:

- Equivalent for the core reasoning and document-quality purposes of this category. The mobile skills retain the same high-level tasks: brainstorming, bias/statistical critique, peer-review structure, IMRAD/reporting guidance, and scenario analysis.
- Better suited for iOS because desktop script commands, `allowed-tools`, and mandatory local image-generation behavior are removed.
- Not equivalent for desktop-only figure generation or automated formatting. Those are intentionally out of scope until an AMA-native artifact host intent supports them.

## Remaining Work

The complete upstream repository still has many unconverted skills. Remaining packs should follow the same pattern:

- `scientific-documents`
- `scientific-data-lookup`
- `scientific-lab-connectors`
- `scientific-compute-remote`
- domain-specific remote compute packs

Each pack must keep references, install as a category, mark unsupported execution honestly, add AMASample iOS verification, and compare mobile output against the desktop or API baseline.
