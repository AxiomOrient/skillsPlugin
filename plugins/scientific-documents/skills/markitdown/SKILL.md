---
name: markitdown
description: Mobile-safe document-to-Markdown guidance for AMA. Use `run_intent` with `scientific.document_inspect` and `scientific.document_to_markdown` for Markdown and UTF-8 text-like artifacts; desktop MarkItDown, Python, OCR, binary document parsing, audio transcription, and shell workflows are not available on iOS.
license: MIT license
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/markitdown
---

# Mobile Document To Markdown

Use this skill when a user wants to inspect a document artifact or convert a supported mobile-safe artifact into Markdown.

## Mobile Execution

Use `run_intent`:

- `scientific.document_inspect`
- `scientific.document_to_markdown`

Supported first-slice formats:

- Markdown, plain text
- CSV, TSV
- JSON
- XML, HTML

Unsupported in this mobile slice:

- DOCX/PPTX/XLSX editing or full-fidelity conversion
- PDF parsing, OCR, scanned documents, audio transcription, YouTube transcripts, ZIP traversal
- Python MarkItDown package, shell commands, local package installation, LibreOffice, Node, or desktop automation

## Workflow

1. Ask for an existing AMA artifact selector: `relativePath`, `storedFilename`, or `preferredFilename`.
2. Call `scientific.document_inspect` to confirm type, size, and whether Markdown conversion is supported.
3. If supported, call `scientific.document_to_markdown`.
4. Summarize the Markdown result and mention whether a Markdown artifact was persisted.
5. If unsupported, explain the missing native capability and request a Markdown or UTF-8 text-like export path.

## References

- `references/file_formats.md`
- `references/api_reference.md`
- `assets/example_usage.md`
