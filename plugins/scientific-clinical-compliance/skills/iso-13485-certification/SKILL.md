---
name: iso-13485-certification
description: Mobile-safe ISO 13485:2016 medical-device QMS documentation guidance for gap analysis, quality manual drafting, mandatory-document planning, and audit preparation. Uses installed references and templates only; does not run local analysis scripts or provide legal certification advice.
license: MIT license
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/iso-13485-certification
---

# ISO 13485 Certification Documentation

Use this skill to plan, draft, and review ISO 13485 quality-management documentation for medical-device organizations.

## Mobile Safety Boundaries

- Do not claim certification readiness from AMA output alone.
- Do not provide legal, notified-body, FDA, or EU MDR determinations as final advice.
- Do not run local gap-analyzer scripts on iOS.
- Use supplied document summaries or pasted excerpts; do not assume the contents of unprovided files.
- Mark all conclusions as preliminary until reviewed by qualified quality, regulatory, or audit personnel.

## Workflow

1. Identify the task:
   - requirement explanation
   - gap-analysis planning
   - quality manual drafting
   - mandatory procedure planning
   - audit-readiness checklist
   - template customization guidance
2. Confirm organization scope, device type, regulatory markets, and QMS maturity.
3. Use installed references to map clauses and mandatory documents.
4. For gap analysis, ask the user to provide a document list or excerpts.
5. Return a prioritized action plan with evidence gaps and review owners.
6. For document drafting, use installed templates as structure and leave placeholders for organization-specific facts.

## Installed References

- `references/iso-13485-requirements.md`
- `references/mandatory-documents.md`
- `references/gap-analysis-checklist.md`
- `references/quality-manual-guide.md`
- `assets/templates/*`

## Output Standard

Return:

- task type
- assumed regulatory scope
- clause or document mapping
- current evidence supplied
- gaps and priority
- draft outline or template adaptation
- review and approval checklist
