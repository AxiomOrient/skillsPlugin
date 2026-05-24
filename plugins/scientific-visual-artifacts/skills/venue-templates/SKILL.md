---
name: venue-templates
description: Access comprehensive LaTeX templates, formatting requirements, and submission guidelines for major scientific publication venues (Nature, Science, PLOS, IEEE, ACM), academic conferences (NeurIPS, ICML, CVPR, CHI), research posters, and grant proposals (NSF, NIH, DOE, DARPA). This skill should be used when preparing manuscripts for journal submission, conference papers, research posters, or grant proposals and need venue-specific formatting requirements and templates.
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
  "skill": "venue-templates",
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

- `assets/examples/cell_summary_example.md`
- `assets/examples/medical_structured_abstract.md`
- `assets/examples/nature_abstract_examples.md`
- `assets/examples/neurips_introduction_example.md`
- `assets/grants/nih_specific_aims.tex`
- `assets/grants/nsf_proposal_template.tex`
- `assets/journals/nature_article.tex`
- `assets/journals/neurips_article.tex`
- `assets/journals/plos_one.tex`
- `assets/posters/beamerposter_academic.tex`
- `references/cell_press_style.md`
- `references/conferences_formatting.md`
- `references/cs_conference_style.md`
- `references/grants_requirements.md`
- `references/journals_formatting.md`
- `references/medical_journal_styles.md`
- `references/ml_conference_style.md`
- `references/nature_science_style.md`
- `references/posters_guidelines.md`
- `references/reviewer_expectations.md`
- `references/venue_writing_styles.md`
