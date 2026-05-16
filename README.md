# AMA Skills Plugin Guide

This repository contains AMA mobile skill plugin guidance and the first Akasha-to-AMA native skill packs.

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

- [AMA project analysis](docs/ama-project-analysis.md)
- [Akasha AMA compatibility](docs/akasha-ama-compatibility.md)
- [Rulebook](docs/rulebook.md)
- [Plugin pack structure](docs/plugin-pack-structure.md)
- [Skill authoring guide](docs/skill-authoring-guide.md)
- [Conversion guide](docs/conversion-guide.md)
- [Swift capability guide](docs/swift-capability-guide.md)
- [Validation checklist](docs/validation-checklist.md)
- [Templates](docs/templates.md)

## Current State

Installable Akasha packs now live under `plugins/<category>/`. Each pack has its own `ama-skill-plugin.json` and can be installed or removed as one category.

The install unit must be the plugin category, not the entire repository.

## Installable Packs

- `plugins/intake-routing`: scope lock, first route lock, request route.
- `plugins/safety-trust`: security checklist, gate judgment.
- `plugins/writing-continuity`: brief-to-draft, summarize.
- `plugins/engineering-control`: patch shape.

These skills do not ship Python, shell, PowerShell, batch, or Node scripts. They call AMA native Swift host intents such as `akasha.scope_lock` through `run_intent`.
