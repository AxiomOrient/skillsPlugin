---
name: treatment-plans
description: Mobile-safe treatment-plan documentation guidance for clinician-reviewed care-plan structure, SMART goals, interventions, monitoring, and follow-up checklists. Uses installed references and templates only; does not prescribe or generate autonomous patient-specific medical advice.
license: MIT license
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/treatment-plans
---

# Treatment Plan Documentation

Use this skill to structure treatment-plan drafts, care coordination notes, monitoring checklists, and patient-centered goals for review by licensed clinicians.

## Mobile Safety Boundaries

- Do not prescribe medication, change doses, diagnose, triage, or replace clinician judgment.
- Do not present AMA output as a final treatment recommendation.
- Do not fabricate guidelines, contraindications, allergies, lab values, patient preferences, or monitoring thresholds.
- Use only user-provided facts and installed documentation references.
- Do not run local template generators, timeline scripts, validation scripts, or schematic generators on iOS.

## Workflow

1. Confirm the plan purpose:
   - one-page summary
   - standard care-plan draft
   - rehabilitation plan
   - chronic disease management plan
   - mental health plan
   - perioperative or pain-management documentation
2. Ask for de-identified patient context and clinician-provided diagnosis or care objective.
3. Separate:
   - supplied clinical facts
   - goals
   - interventions already chosen by a clinician
   - monitoring and follow-up
   - unknown or unsafe-to-infer items
4. Use SMART goals when appropriate.
5. Add safety review notes and escalation criteria only when supplied by the user or a cited guideline reference.
6. Return a draft for clinician review.

## Installed References

- `references/treatment_plan_standards.md`
- `references/goal_setting_frameworks.md`
- `references/intervention_guidelines.md`
- `references/regulatory_compliance.md`
- `references/specialty_specific_guidelines.md`
- `assets/*` plan templates and quality checklist

## Output Standard

Return:

- document type
- de-identification status
- supplied clinical facts
- goals
- planned interventions, if supplied
- monitoring and follow-up structure
- missing facts
- clinician-review checklist
