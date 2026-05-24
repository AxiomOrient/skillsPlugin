# Mobile-Safe Markdown Source Formats

AMA iOS document conversion is text-first. The host intent converts already-readable artifacts into Markdown without desktop tools or local scripts.

## Markdown

Extensions: `.md`, `.markdown`

The content is returned unchanged and can be persisted as a Markdown artifact.

## Plain Text

Extensions: `.txt` or no extension

The content is returned as Markdown text.

## CSV and TSV

Extensions: `.csv`, `.tsv`

The first row is treated as the table header. Remaining rows become Markdown table rows.

## JSON

Extension: `.json`

Valid JSON is pretty-printed and wrapped in a fenced `json` code block. Invalid but UTF-8-readable JSON-like text is still wrapped as provided.

## XML and HTML

Extensions: `.xml`, `.html`, `.htm`

The source text is wrapped in a fenced code block. AMA does not run browser renderers or sanitize HTML into a rich document view in this slice.

## Binary Documents

Binary document parsing is outside this mobile skill. Convert those inputs to Markdown or another supported UTF-8 text-like format before importing them into AMA.
