---
name: docx
description: Mobile-safe DOCX guidance for AMA. Installs Word-document editing references, but DOCX redline/comment/Office ZIP mutation scripts are unavailable on iOS until replaced by Swift document intents.
license: MIT License
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/docx
---

# DOCX Document Guidance

Use this skill to reason about DOCX editing requirements, review user intent, and route work to supported mobile capabilities.

## Mobile Boundaries

- Do not run Office XML pack/unpack scripts.
- Do not promise tracked changes, comments, or LibreOffice validation on iOS.
- If the document is exported as Markdown, text, CSV, TSV, JSON, XML, or HTML, use `scientific.document_inspect` and `scientific.document_to_markdown` where supported.
- For full DOCX mutation, request a future AMA Swift document host intent.

## Output Standard

Return:

- requested DOCX operation
- whether it is available on mobile
- supported fallback path
- data-loss or formatting risk
- required future host intent if blocked
