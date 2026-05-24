---
name: dnanexus-integration
description: Mobile-safe DNAnexus connector guidance for genomics cloud data, workflow, app, and job planning. Always use `scientific.lab_connector_preflight` before platform actions.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# DNAnexus Integration

Use this skill to plan DNAnexus cloud genomics operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `dnanexus`. Upload, download, workflow run, job execution, app build, project mutation, and permission changes are mutating or remote execution.

Do not run dxpy, dx CLI, Docker, or local pipeline scripts on iOS.

References:

- `references/configuration.md`
- `references/data-operations.md`
- `references/job-execution.md`
- `references/app-development.md`
- `references/python-sdk.md`
