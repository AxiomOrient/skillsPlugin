---
name: pyhealth
description: Build clinical/healthcare deep-learning pipelines with PyHealth — loading EHR/signal/imaging datasets (MIMIC-III/IV, eICU, OMOP, SleepEDF, ChestXray14, EHRShot), defining tasks (mortality, readmission, length-of-stay, drug recommendation, sleep staging, ICD coding, EEG events), instantiating models (Transformer, RETAIN, GAMENet, SafeDrug, MICRON, StageNet, AdaCare, CNN/RNN/MLP), training with the PyHealth Trainer, computing clinical metrics, and using medical code utilities (ICD/ATC/NDC/RxNorm lookup and cross-mapping). Use this skill whenever the user mentions PyHealth, MIMIC, eICU, OMOP, EHR modeling, clinical prediction, drug recommendation, sleep staging, medical code mapping, ICD/ATC codes, or any healthcare ML pipeline that fits the dataset → task → model → trainer → metrics pattern, even if "PyHealth" isn't named explicitly.
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
  "skill": "pyhealth",
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

- `references/datasets.md`
- `references/examples.md`
- `references/installation.md`
- `references/medcode.md`
- `references/models.md`
- `references/tasks.md`
