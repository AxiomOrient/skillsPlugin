---
name: clinical-reports
description: Mobile-safe clinical report writing guidance for de-identified case reports, diagnostic summaries, clinical trial reports, SOAP notes, H&P notes, discharge summaries, and compliance review. Uses installed references and templates only; does not run validators or extract data from local systems.
license: MIT License
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/clinical-reports
---

# Clinical Report Writing

Use this skill to draft or review clinical documentation structure using de-identified content and installed report templates.

## Mobile Safety Boundaries

- Do not create final medical records, legal attestations, or regulatory submissions without qualified review.
- Do not infer missing clinical facts. Mark unknowns explicitly.
- Do not process protected health information unless the user confirms a compliant workflow.
- Do not run local de-identification, terminology, validation, or extraction scripts on iOS.
- Do not fabricate consent, adverse-event seriousness, test results, dates, or clinician signatures.

## Workflow

1. Identify report type:
   - case report
   - radiology, pathology, or lab report
   - clinical trial report or SAE summary
   - SOAP note
   - history and physical
   - discharge summary
   - consult note
2. Confirm de-identification and consent status.
3. Select the installed reference/template that matches the report type.
4. Draft only from supplied facts.
5. Add a completeness and risk checklist:
   - identifiers removed
   - dates generalized when needed
   - consent status
   - missing facts
   - review owner
6. Keep the output concise and reviewable on mobile.

## Installed References

- `references/case_report_guidelines.md`
- `references/diagnostic_reports_standards.md`
- `references/clinical_trial_reporting.md`
- `references/patient_documentation.md`
- `references/regulatory_compliance.md`
- `assets/*` report templates and checklists

## Output Standard

Return:

- report type
- de-identification status
- structured draft
- missing facts
- compliance checklist
- required reviewer
