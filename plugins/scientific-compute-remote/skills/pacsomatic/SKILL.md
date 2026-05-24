---
name: pacsomatic
description: Mobile-safe nf-core/pacsomatic planning and remote execution preflight for matched tumor-normal BAM workflows. Use for collecting inputs, checking launch readiness, and preparing remote job requirements.
---

# pacsomatic On AMA Mobile

This skill is installed as part of `scientific-compute-remote`. On AMA iOS, do not run Nextflow, Python helper scripts, scheduler CLIs, containers, shell commands, local BAM/PBI checks, or HPC submission tools.

## Required Mobile Flow

1. Collect required run inputs: tumor BAM, normal BAM, patient ID, tumor sample ID, normal sample ID, output location, and exactly one reference mode (`fasta` or `genome`).
2. Use the installed references to explain the expected samplesheet, params YAML, launch script, scheduler profile, and triage artifacts.
3. Before promising validation, dry-run, execution, or scheduler submission, call `run_intent` with intent `scientific.remote_job_preflight`.
4. If the preflight status is not ready, explain the blocker and stop before claiming any pacsomatic run artifact was generated.
5. If an approved remote compute provider is available, hand off only the structured run request; do not construct or execute local shell commands on iOS.

Recommended remote preflight parameters:

```json
{
  "skill": "pacsomatic",
  "runtime": "nextflow-hpc-container",
  "task": "nf-core/pacsomatic matched tumor-normal dry-run or execution",
  "requiresUpload": true,
  "estimatedInputSizeMB": 0,
  "hasUserApproval": false,
  "containsSensitiveData": true
}
```

## Local iOS Capabilities

- Build an input collection checklist.
- Explain sample sheet columns: `patient`, `sample`, `status`, `bam`, and `pbi`.
- Draft a remote job request and triage checklist for `.nextflow.log`, `pipeline_info`, and failing task logs.
- Explain why local iOS execution is unavailable and what remote/HPC evidence is needed.

## Not Local On iOS

- `scripts/run_pacsomatic.py`.
- `nextflow run nf-core/pacsomatic`.
- Slurm/LSF/PBS/SGE submission.
- Container runtime, filesystem validation of BAM/PBI files, or pipeline execution.

## Reference Files Installed

- `references/agent-playbook.md`
- `references/config-and-output.md`
- `references/pacsomatic_guide.md`
- `references/config.yaml`
- `references/LICENSE`
