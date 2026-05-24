---
name: anndata
description: Data structure for annotated matrices in single-cell analysis. Use when working with .h5ad files or integrating with the scverse ecosystem. This is the data format skill—for analysis workflows use scanpy; for probabilistic models use scvi-tools; for population-scale queries use cellxgene-census.
---

# AMA Mobile Remote Compute Skill

This skill is installed as part of `scientific-compute-remote`. The upstream desktop skill depends on Python, scientific packages, GPU/simulation/model runtimes, large local files, or other non-iOS execution. On AMA iOS, do not run local scripts, package managers, notebooks, shell commands, or desktop tools.

## Required Mobile Flow

1. Read the request and identify the intended scientific compute task.
2. Use the reference files below when they help explain inputs, outputs, terminology, or expected artifacts.
3. Before promising execution, call `run_intent` with intent `scientific.remote_job_preflight`.
4. Treat any blocked status as final for local iOS execution. Explain the blocker and the next required setup step.
5. Only describe a remote job as ready when the preflight status is `ready_for_remote_job`.

Recommended `run_intent` parameters:

```json
{
  "skill": "anndata",
  "task": "plain-language user task",
  "requiresRemoteExecution": true,
  "hasRemoteProvider": false,
  "inputArtifactCount": 0,
  "containsSensitiveData": false,
  "userApprovedUpload": false
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- Local Python, shell, MATLAB, Docker, GPU, notebook, or package-manager execution: unavailable on iOS.
- Artifact upload requires explicit user approval.
- PHI, secrets, controlled datasets, and private research data require a data review before remote execution.

## Reference Files Installed

- `references/best_practices.md`
- `references/concatenation.md`
- `references/data_structure.md`
- `references/io_operations.md`
- `references/manipulation.md`
