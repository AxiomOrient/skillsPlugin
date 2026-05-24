# Mobile Markdown Conversion Examples

Use these examples as intent payload patterns for AMA iOS. They avoid desktop MarkItDown, Python packages, shell commands, and binary document parsing.

## Inspect a Markdown artifact

```json
{
  "artifact": {
    "preferredFilename": "research-summary.md"
  }
}
```

Call `scientific.document_inspect` first. If `supported_markdown_conversion` is `true`, call `scientific.document_to_markdown`.

## Convert CSV to Markdown

```json
{
  "artifact": {
    "preferredFilename": "gene-scores.csv"
  },
  "persistMarkdown": true
}
```

Expected output is a Markdown table artifact. The source remains CSV, and no local scripts are executed.

## Convert JSON to Fenced Markdown

```json
{
  "artifact": {
    "preferredFilename": "metadata.json"
  },
  "maxBytes": 128000,
  "persistMarkdown": true
}
```

Expected output is a Markdown code fence with pretty-printed JSON when possible.

## Binary Documents

Binary documents are not parsed by this mobile skill. Export them to Markdown, text, CSV, TSV, JSON, XML, or HTML before importing into AMA.
