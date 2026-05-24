---
name: markdown-mermaid-writing
description: Mobile-safe scientific Markdown and Mermaid writing guidance. Uses installed references and templates to create text-first scientific reports and diagrams without rendering, CLI tools, or generated image scripts.
license: Apache-2.0
metadata:
  skill-author: Clayton Young / Superior Byte Works, LLC (@borealBytes)
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/markdown-mermaid-writing
---

# Markdown And Mermaid Writing

Use this skill to write scientific documents as Markdown with Mermaid diagrams as text-first source material.

## Mobile Boundaries

- Do not run Mermaid CLI, Node, Python, browser renderers, or image export tools on iOS.
- Do not promise rendered diagrams unless the host app provides a native preview surface.
- Keep Mermaid source text editable and accessible.

## Workflow

1. Select a document template from `templates/`.
2. Read `references/markdown_style_guide.md` for document structure.
3. Pick the correct diagram guide under `references/diagrams/`.
4. Include `accTitle` and `accDescr` in Mermaid diagrams.
5. Return Markdown source, not a generated image.

## References

- `references/markdown_style_guide.md`
- `references/mermaid_style_guide.md`
- `references/diagrams/*`
- `templates/*`
- `assets/examples/example-research-report.md`
