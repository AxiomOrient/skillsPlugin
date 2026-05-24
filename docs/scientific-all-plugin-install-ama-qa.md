# Scientific All Plugin Install AMA QA

Date: 2026-05-24

## Scope

This QA verifies that every converted scientific AMA plugin pack can be installed and loaded by the AMA runtime from this repository.

Covered plugin packs:

- `scientific-clinical-compliance`
- `scientific-compute-remote`
- `scientific-data-lookup`
- `scientific-deferred-desktop`
- `scientific-documents`
- `scientific-lab-connectors`
- `scientific-literature`
- `scientific-reasoning-docs`
- `scientific-reference`
- `scientific-visual-artifacts`
- `scientific-web-research`

The smoke executable lives outside `plugins/` so it is not installed as an AMA mobile skill.

## Command

```sh
cd /Users/axient/repoAgent/skillsPlugin/tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

## Result

Observed on 2026-05-24:

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

## Interpretation

- All 11 scientific plugin packs installed through `AMASkillLibrary.installSkillPlugin`.
- All 142 installed skills loaded through `AMASkillRuntime.loadSkill`.
- No installed scientific plugin contains Python, shell, PowerShell, batch, Node, MATLAB, R, or executable helper files.
- The script runner was never invoked.
- The intentionally removed `pdf` skill is not installed.
- Markdown document artifacts are accepted, and a CSV artifact still converts to Markdown through `scientific.document_to_markdown`.
- Python-style compute routes to remote preflight and is blocked without a provider.
- MATLAB-style numeric work routes to the Swift native `scientific.numeric_eval` substitute.

## Product Confidence

This is the broadest install/load proof for the converted scientific skill pack set. It complements narrower API, document, compute, and AMASample iOS simulator tests by proving that the full plugin set can be installed together without skill-name collisions, missing manifests, script execution, or PDF skill reintroduction.
