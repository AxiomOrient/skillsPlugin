---
name: pathml
description: Full-featured computational pathology toolkit. Use for advanced WSI analysis including multiplexed immunofluorescence (CODEX, Vectra), nucleus segmentation, tissue graph construction, and ML model training on pathology data. Supports 160+ slide formats. For simple tile extraction from H&E slides, histolab may be simpler.
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
  "skill": "pathml",
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

- `references/data_management.md`
- `references/graphs.md`
- `references/image_loading.md`
- `references/machine_learning.md`
- `references/multiparametric.md`
- `references/preprocessing.md`
