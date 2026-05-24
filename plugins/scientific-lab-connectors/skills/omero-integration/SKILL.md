---
name: omero-integration
description: Mobile-safe OMERO connector guidance for microscopy data access, metadata, ROIs, tables, and image-processing plans. Always use `scientific.lab_connector_preflight` before API calls.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# OMERO Integration

Use this skill to plan OMERO microscopy data operations on AMA mobile.

Before any external call, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `omero`. Read-only image/dataset metadata lookup can be read-only. ROI creation, annotation writes, table uploads, and server-side scripts are mutating.

Do not run Python OMERO clients, NumPy image processing, or server scripts on iOS.

References:

- `references/connection.md`
- `references/data_access.md`
- `references/metadata.md`
- `references/rois.md`
- `references/tables.md`
- `references/image_processing.md`
- `references/advanced.md`
- `references/scripts.md`
