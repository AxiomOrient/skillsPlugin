---
name: bids
description: Mobile-safe Brain Imaging Data Structure guidance for organizing, checking, and planning BIDS datasets on AMA iOS. Use for BIDS dataset layout, metadata sidecars, derivatives, conversion planning, and remote validation preflight.
---

# BIDS On AMA Mobile

This skill is installed as part of `scientific-compute-remote`. On AMA iOS, do not run PyBIDS, bids-validator, Deno, DICOM converters, Python, shell commands, package managers, or local dataset crawlers.

## Required Mobile Flow

1. Identify whether the user needs BIDS structure guidance, metadata drafting, validation, conversion, or derivative planning.
2. For guidance-only requests, use the installed references and answer with BIDS-compliant paths, sidecar fields, and next checks.
3. For validation, DICOM-to-BIDS conversion, PyBIDS querying, OpenNeuro/DANDI preparation, or large local dataset inspection, call `run_intent` with intent `scientific.remote_job_preflight`.
4. If the preflight status is not ready, explain the blocker and stop before claiming validation or conversion happened.
5. Never claim that a BIDS dataset was validated on iOS unless a native AMA validator or approved remote job result is available.

Recommended remote preflight parameters:

```json
{
  "skill": "bids",
  "runtime": "python-deno-dicom",
  "task": "BIDS validation, PyBIDS query, DICOM-to-BIDS conversion, or large dataset inspection",
  "requiresUpload": true,
  "estimatedInputSizeMB": 0,
  "hasUserApproval": false,
  "containsSensitiveData": true
}
```

## Local iOS Capabilities

- Explain BIDS entity order, modality folders, sidecar metadata, derivatives layout, and `.bidsignore` planning.
- Draft `dataset_description.json`, `participants.tsv` column descriptions, and modality-specific metadata checklists as text.
- Prepare a remote validation or conversion checklist.

## Not Local On iOS

- PyBIDS indexing or querying.
- `bids-validator`, Deno, HeuDiConv, dcm2bids, BIDScoin, pydicom, nibabel, or DICOM conversion.
- Reading large local neuroimaging file trees directly from installed skill code.
- Uploading or inspecting PHI without explicit user approval and redaction policy.

## Reference Files Installed

- `references/bids_specification.md`
- `references/bids_schema.json`
- `references/beps.yml`
- `references/conversion_tools.md`
- `references/metadata_fields.md`
