---
name: clinical-decision-support
description: Mobile-safe clinical research decision-support documentation guidance for cohort analyses, evidence synthesis, biomarker-stratified reports, and decision-algorithm drafts. Uses installed references and templates only; does not execute scripts or provide individual medical advice.
license: MIT License
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/clinical-decision-support
---

# Clinical Decision Support Documentation

Use this skill to structure group-level clinical research documentation: cohort analyses, evidence summaries, biomarker-stratified findings, guideline drafts, and decision-algorithm narratives.

## Mobile Safety Boundaries

- Do not diagnose, prescribe, triage, or recommend patient-specific care.
- Do not claim regulatory, clinical, or statistical validation from AMA output alone.
- Require de-identified or synthetic data unless the user explicitly confirms the environment is approved for protected health information.
- Treat all output as a draft for review by qualified clinical, statistical, regulatory, or medical affairs professionals.
- Do not run local Python, shell, LaTeX, image-generation, or validation scripts on iOS.

## Workflow

1. Classify the document:
   - cohort analysis
   - evidence synthesis
   - biomarker-stratified report
   - treatment recommendation framework for a population
   - clinical decision algorithm
2. Confirm the population, data source, endpoint definitions, evidence scope, and intended reviewer.
3. Build a concise evidence table before drafting conclusions.
4. Separate observations, statistical interpretation, and clinical implications.
5. Include confidence language:
   - evidence quality
   - limitations
   - missing data
   - uncertainty and review requirements
6. Use installed templates only as inert document examples. If the user needs Markdown, chart, or schematic generation, request an AMA-native artifact host intent. PDF publishing is not a local mobile capability.

## Installed References

- `references/patient_cohort_analysis.md`
- `references/outcome_analysis.md`
- `references/biomarker_classification.md`
- `references/evidence_synthesis.md`
- `references/treatment_recommendations.md`
- `references/clinical_decision_algorithms.md`
- `assets/*` templates and examples

## Output Standard

Return a structured draft with:

- purpose and intended audience
- de-identification status
- population and data scope
- evidence summary
- decision logic or algorithm outline
- limitations
- required human review
- next validation steps
