---
name: scientific-schematics
description: Create publication-quality scientific diagrams using Nano Banana 2 AI with smart iterative refinement. Uses Gemini 3.1 Pro Preview for quality review. Only regenerates if quality is below threshold for your document type. Specialized in neural network architectures, system diagrams, flowcharts, biological pathways, and complex scientific visualizations.
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
  "skill": "scientific-schematics",
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

- `references/QUICK_REFERENCE.md`
- `references/README.md`
- `references/best_practices.md`
