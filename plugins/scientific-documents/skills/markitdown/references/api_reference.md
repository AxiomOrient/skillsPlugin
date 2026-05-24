# AMA Mobile Document-To-Markdown API

This reference describes the AMA iOS host-intent surface used instead of the desktop MarkItDown package.

## `scientific.document_inspect`

Inspect a persisted AMA artifact.

Input:

```json
{
  "artifact": {
    "preferredFilename": "research-summary.md"
  }
}
```

Output includes:

- file name, extension, byte count, and MIME type
- whether Markdown conversion is supported
- mobile runtime evidence showing no local scripts were executed

## `scientific.document_to_markdown`

Convert a supported text-like artifact to Markdown.

Input:

```json
{
  "artifact": {
    "preferredFilename": "gene-scores.csv"
  },
  "maxBytes": 256000,
  "persistMarkdown": true
}
```

Supported source formats:

- `.md`, `.markdown`
- `.txt` or extensionless UTF-8 text
- `.csv`, `.tsv`
- `.json`
- `.xml`
- `.html`, `.htm`

Unsupported source formats:

- binary documents
- scanned documents or OCR-only content
- Office package mutation
- local package installation or shell execution

When `persistMarkdown` is `true`, AMA writes a `text/markdown` artifact and includes the artifact record in the result.
