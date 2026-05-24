---
name: latchbio-integration
description: Mobile-safe LatchBio connector guidance for workflow creation, data management, resource configuration, and verified workflow planning. Always use `scientific.lab_connector_preflight` before platform actions.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# LatchBio Integration

Use this skill to plan LatchBio workflow and bioinformatics platform actions on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `latchbio`. Workflow registration, data transfer, task execution, and resource changes are mutating or remote execution.

Do not run Latch SDK, Docker, Nextflow, Snakemake, or local Python workflow code on iOS.

References:

- `references/workflow-creation.md`
- `references/data-management.md`
- `references/resource-configuration.md`
- `references/verified-workflows.md`
