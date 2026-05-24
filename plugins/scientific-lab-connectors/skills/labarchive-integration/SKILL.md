---
name: labarchive-integration
description: Mobile-safe LabArchives ELN connector guidance for notebooks, entries, attachments, reports, and integrations. Always use `scientific.lab_connector_preflight` before API calls.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# LabArchives Integration

Use this skill to plan LabArchives ELN operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `labarchives`. Mark notebook creation, entry updates, attachment upload, backup, export, and reporting actions as `mutating`.

Do not run the upstream Python scripts on iOS. The original desktop setup/config and notebook operation scripts require a future Swift connector or approved remote service.

References:

- `references/authentication_guide.md`
- `references/api_reference.md`
- `references/integrations.md`
