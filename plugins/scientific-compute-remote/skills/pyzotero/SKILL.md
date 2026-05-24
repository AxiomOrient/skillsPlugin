---
name: pyzotero
description: Interact with Zotero reference management libraries through a remote or connector-backed Zotero Web API workflow. Use this skill for bibliographic references, citation exports, library search, and attachment metadata planning. On AMA iOS, route binary attachments through approved connector or remote preflight.
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
  "skill": "pyzotero",
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

- `references/authentication.md`
- `references/cli.md`
- `references/collections.md`
- `references/error-handling.md`
- `references/exports.md`
- `references/files-attachments.md`
- `references/full-text.md`
- `references/pagination.md`
- `references/read-api.md`
- `references/saved-searches.md`
- `references/search-params.md`
- `references/tags.md`
- `references/write-api.md`
