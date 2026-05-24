---
name: lamindb
description: Mobile-safe LaminDB connector guidance for biological data catalog, lineage, annotation, ontology, and deployment planning. Always use `scientific.lab_connector_preflight` before external or hosted instance actions.
license: Apache-2.0 license
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# LaminDB

Use this skill to plan LaminDB data management and FAIR biology workflows on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `lamindb`. Query planning can be read-only. Registration, curation writes, schema changes, deployment, and lineage mutation are mutating.

Do not run Python LaminDB code, local notebooks, or cloud setup commands on iOS.

References:

- `references/core-concepts.md`
- `references/data-management.md`
- `references/annotation-validation.md`
- `references/ontologies.md`
- `references/integrations.md`
- `references/setup-deployment.md`
