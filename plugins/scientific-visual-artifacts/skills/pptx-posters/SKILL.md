---
name: pptx-posters
description: Create research poster structure and PowerPoint/PPTX poster guidance from mobile-safe HTML/CSS or Markdown source. Use this skill only when the user explicitly requests PowerPoint/PPTX poster format. On AMA iOS, final publishing export requires an approved native or remote renderer.
---

# AMA Mobile Scientific Artifact Skill

This skill is installed as part of `Scientific Visual Artifacts`. On AMA iOS, do not run local Python, shell, LaTeX, Office automation, plotting scripts, or desktop renderers.

## Required Mobile Flow

1. Clarify the artifact kind, source data, target audience, and requested output.
2. Read the reference files below for structure, quality criteria, and formatting guidance.
3. Before promising creation or mutation, call `run_intent` with intent `scientific.artifact_workflow_preflight`.
4. Treat `needs_remote_renderer`, `needs_sensitive_data_review`, or `needs_artifact_creation_approval` as blockers for local iOS execution.
5. Only proceed with native AMA artifact tooling when the host provides a Swift renderer/editor or an approved remote renderer.

Recommended parameters:

```json
{
  "skill": "pptx-posters",
  "artifactKind": "poster|slides|schematic|image|citation|visualization",
  "requestedAction": "plain-language artifact task",
  "hasNativeRenderer": false,
  "requiresRemoteRenderer": false,
  "userApprovedArtifactCreation": false,
  "containsSensitiveData": false
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- Artifact creation or mutation requires explicit approval.
- Remote rendering and sensitive input handling require separate product support.

## Reference Files Installed

- `assets/poster_html_template.html`
- `assets/poster_quality_checklist.md`
- `references/poster_content_guide.md`
- `references/poster_design_principles.md`
- `references/poster_layout_design.md`
