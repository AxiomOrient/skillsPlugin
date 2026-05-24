# Scientific Documents AMA QA

Date: 2026-05-24

## Scope

This document records the fifth AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-documents`

Converted skills:

- `markitdown`
- `markdown-mermaid-writing`
- `docx`
- `pptx`
- `xlsx`

The conversion target is iOS AMA. This category combines Swift host intents for mobile-safe artifact inspection and Markdown extraction with documentation-only guidance for Office formats that still need native Swift editors. PDF handling was removed from this mobile plugin and replaced with a Markdown-first import contract.

## Mobile Capability

Runtime-backed native intents:

- `scientific.document_inspect`
- `scientific.document_to_markdown`

Supported first-slice conversion formats:

- Markdown and plain text
- CSV and TSV
- JSON
- XML and HTML

Reference and template parity:

```text
docx source_non_script_files=1 mobile_non_skill_files=1
pptx source_non_script_files=3 mobile_non_skill_files=3
xlsx source_non_script_files=1 mobile_non_skill_files=1
markitdown source_non_script_files=3 mobile_non_skill_files=3
markdown-mermaid-writing source_non_script_files=36 mobile_non_skill_files=36
```

Excluded behavior:

- no upstream `scripts/`
- no Python, shell, Node, PowerShell, batch, LibreOffice, PPTXGenJS, MarkItDown CLI, OCR, audio transcription, or desktop automation
- no DOCX/PPTX/XLSX mutation or validation until AMA has native Swift document host intents

## Product Tests

AMA package test:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter scientificDocument
```

Result:

- Passed 1 Swift Testing test.
- Verified `scientific.document_inspect` recognizes CSV artifacts as convertible.
- Verified `scientific.document_to_markdown` converts CSV to a Markdown table and reports `local_scripts_executed=false`.
- Verified Markdown document artifacts are accepted in this mobile plugin.

AMASample local AMA package test:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificDocument
```

Result:

- Passed 1 Swift Testing test after syncing `/Users/axient/repoAgent/AMA`.
- Verified the same CSV-to-Markdown and Markdown document inspection behavior in the AMASample local AMA package.

AMASample iOS simulator test:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificDocumentsDerivedData
```

Result:

- Passed 25 Swift Testing tests on 2026-05-24.
- Added and verified `ama-skills-host-scientific-documents`.
- The scenario creates CSV and Markdown artifacts, runs document inspection, runs Markdown conversion, and verifies the Markdown table output.

## Real Use Test

A temporary Swift package at `/tmp/ama-documents-live` installed the real plugin from:

```text
/Users/axient/repoAgent/skillsPlugin/plugins/scientific-documents
```

Observed result:

```text
documents_installation_id=io.axiomorient.ama.scientific.documents
documents_skill_count=5
documents_skills=docx,markdown-mermaid-writing,markitdown,pptx,xlsx
markitdown_loaded_mentions_intent=true
documents_markdown_contains_table=true
documents_markdown_artifact=results.md
documents_markdown_document_convertible=true
local_scripts_executed=false
```

## Desktop Comparison

Desktop CSV baseline:

```text
| gene | score |
| --- | --- |
| TP53 | 0.91 |
| BRCA1 | 0.82 |
```

Mobile AMA `scientific.document_to_markdown` returned a Markdown string containing the same header and rows for the tested CSV. The output is equivalent for this first-slice CSV conversion case.

Quality judgment:

- Equivalent for mobile-safe CSV/text/JSON/XML/HTML/Markdown surfaces covered by the Swift intent.
- Better suited for iOS because it avoids MarkItDown CLI, Python, LibreOffice, Node, and Office XML helper scripts.
- Not equivalent for binary document parsing, scanned document OCR, audio transcription, ZIP traversal, DOCX redlining/comments, PPTX slide mutation, XLSX recalculation, or full Office validation. Those require Markdown export, future AMA Swift host intents, or approved remote services.

## Static Checks

Script scan:

```text
find plugins/scientific-documents -type f \
  \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -perm +111 \) -print
```

Result:

- Empty output.

Manifest validation:

```text
python3 -m json.tool plugins/scientific-documents/ama-skill-plugin.json
```

Result:

- Passed.

## Release Confidence

Confidence for this category: medium.

Reason:

- Plugin install, skill load, host intent execution, iOS simulator scenario, and CSV desktop comparison are verified.
- Confidence is not high because Office mutation and binary document conversion remain intentionally out of scope.
