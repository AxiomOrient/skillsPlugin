---
name: pptx
description: Mobile-safe PPTX guidance for AMA. Installs presentation editing references, but slide mutation, thumbnail generation, Office XML scripts, and LibreOffice validation are unavailable on iOS until replaced by Swift host intents.
license: MIT License
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/pptx
---

# PPTX Presentation Guidance

Use this skill to plan or review scientific presentation work on mobile.

## Mobile Boundaries

- Do not run PPTXGenJS, Node, Python, Office XML mutation scripts, thumbnail scripts, or LibreOffice.
- Do not promise slide rendering or full-fidelity editing on iOS.
- Use text-first outlines or Markdown/Mermaid where possible.
- For full slide creation or mutation, require a future AMA Swift presentation host intent.

## References

- `editing.md`
- `pptxgenjs.md`
