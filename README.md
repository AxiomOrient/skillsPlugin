# AMA Skills Plugin Guide

This repository contains AMA mobile skill plugin guidance, Akasha-to-AMA native skill packs, and the scientific AMA plugin packs.

The previous copied Codex/development-process skills were removed because AMA is a mobile agent. AMA skills must be designed around iOS storage, WebKit execution, native host intents, artifact handling, and explicit plugin install/uninstall boundaries.

## What Belongs Here

- AMA-specific skill plugin design rules.
- Category plugin structure for group install/uninstall.
- Conversion guidance from desktop/Codex skills to AMA mobile skills.
- Templates for future AMA skill packs.
- Notes on when a behavior must become Swift code inside AMA instead of a skill instruction.

## What Does Not Belong Here

- Codex process skills copied as-is.
- Desktop automation instructions.
- Shell, Python, Node, XcodeBuildMCP, or repository-maintenance workflows.
- Generic development process categories that do not map to mobile user value.

## Documents

- [Documentation index](docs/README.md)
- [AMA project analysis](docs/ama-project-analysis.md)
- [Akasha AMA compatibility](docs/akasha-ama-compatibility.md)
- [Rulebook](docs/rulebook.md)
- [Plugin pack structure](docs/plugin-pack-structure.md)
- [Skill authoring guide](docs/skill-authoring-guide.md)
- [Conversion guide](docs/conversion-guide.md)
- [Swift capability guide](docs/swift-capability-guide.md)
- [Scientific agent skills AMA plan](docs/scientific-agent-skills-ama-plan.md)
- [Scientific agent skills per-skill AMA map](docs/scientific-agent-skills-skill-map.md)
- [Scientific agent skills coverage audit](docs/scientific-agent-skills-coverage-audit.md)
- [Scientific agent skills completion audit](docs/scientific-agent-skills-completion-audit.md)
- [Scientific all plugin install AMA QA](docs/scientific-all-plugin-install-ama-qa.md)
- [GitHub plugin management](docs/github-plugin-management.md)
- [AMA mobile skill conversion rulebook](docs/ama-mobile-skill-conversion-rulebook.md)
- [AMA skill change and conversion rulebook](docs/ama-skill-change-rulebook.md)
- [Scientific literature AMA QA](docs/scientific-literature-ama-qa.md)
- [Scientific reference AMA QA](docs/scientific-reference-ama-qa.md)
- [Scientific data lookup AMA QA](docs/scientific-data-lookup-ama-qa.md)
- [Scientific clinical compliance AMA QA](docs/scientific-clinical-compliance-ama-qa.md)
- [Scientific documents AMA QA](docs/scientific-documents-ama-qa.md)
- [Scientific lab connectors AMA QA](docs/scientific-lab-connectors-ama-qa.md)
- [Scientific compute remote AMA QA](docs/scientific-compute-remote-ama-qa.md)
- [Scientific mobile preflight AMA QA](docs/scientific-mobile-preflight-ama-qa.md)
- [iOS local execution research](docs/ios-local-execution-research.md)
- [Scientific local execution AMA QA](docs/scientific-local-execution-ama-qa.md)
- [Validation checklist](docs/validation-checklist.md)
- [Templates](docs/templates.md)

## Current State

Installable packs live under `plugins/<category>/`. Each pack has its own `ama-skill-plugin.json` and can be installed or removed as one category.

The category plugin is the install/uninstall unit. The repository root is a catalog source through `ama-skill-repository.json`; installing the root URL installs the listed category plugins, not one giant repository-wide plugin.

## Installable Packs

- `plugins/intake-routing`: scope lock, first route lock, request route.
- `plugins/safety-trust`: security checklist, gate judgment.
- `plugins/writing-continuity`: brief-to-draft, summarize.
- `plugins/engineering-control`: patch shape.
- `plugins/scientific-literature`: paper lookup, research lookup, citation management, literature review.
- `plugins/scientific-reference`: brainstorming, critical thinking, peer review, scientific writing, what-if analysis.
- `plugins/scientific-data-lookup`: database routing, Hugging Face dataset search, U.S. Fiscal Data lookup, DepMap planning.
- `plugins/scientific-clinical-compliance`: clinical documentation, treatment-plan structure, and ISO 13485 QMS guidance.
- `plugins/scientific-documents`: artifact inspection, Markdown extraction from text-like sources, Markdown/Mermaid writing, and Office-format guidance. The upstream `pdf` skill is intentionally removed; binary documents must come through Markdown or another supported text-like export path.
- `plugins/scientific-lab-connectors`: Benchling, LabArchives, protocols.io, OMERO, DNAnexus, Ginkgo, LaminDB, LatchBio, Open Notebook, Opentrons, and PyLabRobot mobile preflight guidance.
- `plugins/scientific-compute-remote`: 84 Python/scientific library, neurodata, GPU, simulation, model, pipeline, and large-file workflow skills routed through remote compute preflight.
- `plugins/scientific-web-research`: API and web research skills routed through credentials, approval, and public lookup preflight.
- `plugins/scientific-visual-artifacts`: visual, poster, slide, image, and schematic workflows routed through artifact renderer preflight.
- `plugins/scientific-reasoning-docs`: document-only reasoning, grant, market research, hypothesis, literature, and scholar evaluation skills.
- `plugins/scientific-deferred-desktop`: desktop-only upstream skills installed as unavailable on mobile.

These skills do not ship Python, shell, PowerShell, batch, Node, R, MATLAB, or other executable desktop scripts. Runtime-backed packs call AMA native Swift host intents such as `akasha.scope_lock`, `scientific.paper_search`, `scientific.lab_connector_preflight`, `scientific.remote_job_preflight`, `scientific.web_api_preflight`, `scientific.artifact_workflow_preflight`, `scientific.numeric_eval`, `scientific.chart_render_svg`, and `scientific.deferred_desktop_preflight` through `run_intent`; documentation-only packs stay as mobile-safe reasoning instructions with reference files.

## Verification

The broad install/load smoke for all scientific packs is:

```sh
cd tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

It installs all 15 plugin packs and loads 150 skills. It also checks the 11 scientific plugin packs, verifies 142 scientific skills load, confirms no scientific plugin ships executable helper files, verifies the removed `pdf` skill stays absent, and proves Python/MATLAB requests route to remote preflight or Swift native substitutes instead of local scripts.

For a live GitHub root install/uninstall proof after publishing:

```sh
cd tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke --live-github
```

## GitHub Install

AMA can install this repository directly from GitHub. In an AMA host app, pass the repository URL to `AMASkillLibrary.installSkillPlugins(fromRemoteRepositoryURL:)`:

```swift
let installed = try await library.installSkillPlugins(
    fromRemoteRepositoryURL: "https://github.com/AxiomOrient/skillsPlugin"
)
```

The repository root is indexed by `ama-skill-repository.json`, so AMA can manage all public category packs as one source without scanning unrelated repository files. Installing the root URL currently installs 15 plugin packs and 150 skills. The scientific subset is 11 plugin packs and 142 skills.

It can also install one category pack at a time, for example:

```text
https://github.com/AxiomOrient/skillsPlugin/tree/main/plugins/scientific-documents
```

When the repository is no longer needed, remove the installed packs with the same source URL:

```swift
let removedPluginIDs = try await library.uninstallSkillPlugins(
    fromRemoteRepositoryURL: "https://github.com/AxiomOrient/skillsPlugin"
)
```

The same rule applies to a category tree URL: install one pack with that URL, then uninstall that pack with the same URL.
