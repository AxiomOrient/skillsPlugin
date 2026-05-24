---
name: protocolsio-integration
description: Mobile-safe protocols.io connector guidance for protocol discovery, workspaces, discussions, files, and protocol lifecycle actions. Always use `scientific.lab_connector_preflight` before API calls.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# Protocols.io Integration

Use this skill to plan protocols.io API operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `protocolsio`. Protocol search and read-only detail retrieval can be read-only. Creating, editing, publishing, commenting, workspace changes, or file upload are mutating and need explicit approval.

Do not run local API client scripts or package installation on iOS.

References:

- `references/authentication.md`
- `references/protocols_api.md`
- `references/workspaces.md`
- `references/discussions.md`
- `references/file_manager.md`
- `references/additional_features.md`
