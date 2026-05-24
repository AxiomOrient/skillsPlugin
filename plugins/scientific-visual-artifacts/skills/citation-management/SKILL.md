---
name: citation-management
description: Comprehensive citation management for academic research. Search Google Scholar and PubMed for papers, extract accurate metadata, validate citations, and generate properly formatted BibTeX entries. This skill should be used when you need to find papers, verify citation information, convert DOIs to BibTeX, or ensure reference accuracy in scientific writing.
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
  "skill": "citation-management",
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

- `assets/bibtex_template.bib`
- `assets/citation_checklist.md`
- `references/bibtex_formatting.md`
- `references/citation_validation.md`
- `references/google_scholar_search.md`
- `references/metadata_extraction.md`
- `references/pubmed_search.md`
