# Scientific Agent Skills Completion Audit

Date: 2026-05-24

## Objective Audited

Convert `https://github.com/K-Dense-AI/scientific-agent-skills` into a form usable by this AMA/iOS project. Analyze each skill for feasibility. For MATLAB or Python-style skills, find conversion or alternative execution methods through research and implement a usable path.

## Current Upstream

- `git ls-remote https://github.com/K-Dense-AI/scientific-agent-skills HEAD`
- Current HEAD: `66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9`
- Local audit clone HEAD: `66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9`
- Upstream skill count: 139

## Requirement Verdict

| Requirement | Status | Evidence |
|---|---|---|
| Use the referenced upstream repository, not a generic skill set. | Proven | `scientific-agent-skills-ama-plan.md` records upstream commit `66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9`; current `git ls-remote` matches. |
| Analyze skills one by one for AMA feasibility. | Proven | `scientific-agent-skills-ama-plan.md` has a 139-row feasibility table with route, script/reference/asset counts, security note, and AMA decision; `scientific-agent-skills-skill-map.md` has 139 per-skill AMA mapping rows. |
| Convert into AMA plugin form usable by this project. | Proven | 11 scientific `ama-skill-plugin.json` packs exist under `plugins/scientific-*`; manifest validation proves 142 manifest entries resolve to existing `SKILL.md` files. |
| Preserve installed references/assets, not only `SKILL.md`. | Proven | Category QA docs record reference/template parity, including `scientific-documents-ama-qa.md`, `scientific-compute-remote-ama-qa.md`, and `scientific-mobile-preflight-ama-qa.md`; installed plugin directories include `references/`, `assets/`, and templates where applicable. |
| Exclude local scripts and external desktop program execution from iOS plugins. | Proven | Static scan of `plugins/scientific-*` for `.py`, `.sh`, `.ps1`, `.bat`, `.js`, `.ts`, `.m`, `.r`, and executable files returns empty; full runtime smoke reports `scientific_executable_or_script_files=0` and `scientific_script_runner_calls=0`. |
| Python/scientific-package skills have a non-iOS-local execution path. | Proven | `scientific-compute-remote` installs 84 compute skills; full runtime smoke reports Python request `scientific_python_route=blocked_remote_compute` and `scientific_python_strategy=remote_compute`; `scientific.remote_job_preflight` explains provider/upload/data review requirements. |
| MATLAB-style work has a mobile alternative where feasible. | Proven | `scientific-deferred-desktop/skills/matlab` routes common numeric/chart operations to Swift host intents; full runtime smoke reports `scientific_matlab_route=ios_native` and `scientific_matlab_native_intent=scientific.numeric_eval`; `ios-local-execution-research.md` documents build-time conversion and native-substitute options. |
| Unsupported desktop-only behavior is visible but not falsely executable on iOS. | Proven | `scientific-deferred-desktop` installs `autoskill` and `matlab` as unavailable/deferred paths; mobile preflight QA records `blocked_desktop_only` behavior. |
| API/search/data lookup skills can execute through Swift or preflighted connectors. | Proven | AMA host intents cover literature, data lookup, and web research; QA docs record Swift `URLSession` and credential/approval preflight paths; public API live tests are recorded in `scientific-data-lookup-ama-qa.md`. |
| Documents use Markdown-first behavior; PDF skill is removed. | Proven | `scientific-agent-skills-coverage-audit.md` records `pdf` as intentional exclusion; `scientific-documents` installs 5 non-PDF skills; full runtime smoke reports `scientific_pdf_installed=false` and `scientific_markdown_document_convertible=true`. |
| The converted set installs and loads as a whole. | Proven | `tools/ama_scientific_all_plugin_smoke` installs all 11 scientific packs and loads all 142 installed skills; result: `scientific_plugin_count=11`, `scientific_loaded_skill_count=142`, `scientific_empty_loaded_skill_count=0`. |
| iOS/AMASample usage is verified, not desktop-only. | Proven | XcodeBuildMCP simulator run on 2026-05-24 passed 25 `AMASampleServiceTests` for `/Users/axient/repoAgent/AMASample/App.xcworkspace`; full plugin smoke uses AMA runtime APIs and no local scripts. |

## Current Coverage Numbers

```text
upstream_head=66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9
upstream_skill_count=139
ama_scientific_plugin_count=11
ama_manifest_skill_count=142
ama_unique_skill_count=142
missing_upstream_skill=pdf
intentional_exclusion_count=1
manifest_missing_skill_md=0
installed_script_or_executable_files=0
```

The four AMA extras are intentional literature aliases:

```text
scientific-citation-management
scientific-literature-review
scientific-paper-lookup
scientific-research-lookup
```

## Runtime Smoke Evidence

Command:

```sh
cd /Users/axient/repoAgent/skillsPlugin/tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Expected current output:

```text
scientific_plugin_count=11
scientific_installed_skill_count=142
scientific_loaded_skill_count=142
scientific_empty_loaded_skill_count=0
scientific_pdf_installed=false
scientific_markdown_document_convertible=true
scientific_csv_markdown_contains_table=true
scientific_executable_or_script_files=0
scientific_script_runner_calls=0
scientific_python_status=blocked_requires_remote_provider
scientific_python_route=blocked_remote_compute
scientific_python_strategy=remote_compute
scientific_matlab_status=ready_for_ios_native_intent
scientific_matlab_route=ios_native
scientific_matlab_native_intent=scientific.numeric_eval
```

## Current Verification Run

Commands rerun on 2026-05-24:

```sh
cd /Users/axient/repoAgent/skillsPlugin/tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Result: passed with the runtime smoke output shown above.

```sh
cd /Users/axient/repoAgent/AMA
swift test --filter 'scientific(Document|RemoteJob|MobilePreflight|LocalExecution|DataLookup|Literature|LabConnector)'
```

Result: passed 9 Swift Testing tests.

```text
XcodeBuildMCP test_sim -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace -scheme AMASampleService -only-testing AMASampleServiceTests
```

Result: passed 25 iOS simulator tests on `iPad (A16)`.

## Residual Scope

No requirement in the stated objective remains unimplemented for the current upstream commit.

Future work only applies if the product decision changes or upstream changes:

- Add native Swift or approved remote support for binary document parsing/publishing.
- Add more Swift-native substitutes for selected Python scientific libraries.
- Re-run the coverage audit when `K-Dense-AI/scientific-agent-skills` changes upstream.
