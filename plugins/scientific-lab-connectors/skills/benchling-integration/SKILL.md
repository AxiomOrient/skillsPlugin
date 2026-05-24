---
name: benchling-integration
description: Mobile-safe Benchling connector guidance for registry, inventory, ELN, workflow, and warehouse operations. Always use `scientific.lab_connector_preflight` before external API calls.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# Benchling Integration

Use this skill to plan Benchling R&D platform operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `benchling`. Set `mutating` to true for create/update/delete/sync/workflow actions. Set `hasCredentials` only when the AMA secret store already has a user-approved Benchling credential.

Do not run Python SDK commands, package installation, local scripts, or warehouse jobs on iOS.

References:

- `references/authentication.md`
- `references/api_endpoints.md`
- `references/sdk_reference.md`
