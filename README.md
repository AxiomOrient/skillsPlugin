# AMA Skills Plugin Guide

This repository is the authoring guide for AMA mobile skill plugins. It does not contain production skills yet.

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
- [Rulebook](docs/rulebook.md)
- [Plugin pack structure](docs/plugin-pack-structure.md)
- [Skill authoring guide](docs/skill-authoring-guide.md)
- [Conversion guide](docs/conversion-guide.md)
- [Swift capability guide](docs/swift-capability-guide.md)
- [Validation checklist](docs/validation-checklist.md)
- [Templates](docs/templates.md)

## Current State

There are no installable production skills in this repository right now. The next valid change is to add category-owned AMA plugin packs under `plugins/<category>/`, each with its own `ama-skill-plugin.json` and mobile-specific skills.

The install unit must be the plugin category, not the entire repository.
