---
name: open-notebook
description: Mobile-safe Open Notebook connector guidance for self-hosted research notebooks, source ingestion, chat, and API planning. Always use `scientific.lab_connector_preflight` before external instance actions.
license: MIT
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# Open Notebook

Use this skill to plan Open Notebook research-notebook operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `open-notebook`. Notebook reads can be read-only. Source ingestion, chat that stores state, notebook creation, and provider credential changes are mutating.

Do not run Docker Compose, local Python scripts, local API clients, or self-hosting setup on iOS.

References:

- `references/configuration.md`
- `references/api_reference.md`
- `references/architecture.md`
- `references/examples.md`
