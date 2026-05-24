---
name: xlsx
description: Mobile-safe XLSX guidance for AMA. Installs spreadsheet workflow guidance, but recalculation, Office XML mutation, and LibreOffice validation scripts are unavailable on iOS until replaced by Swift spreadsheet intents.
license: MIT License
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: documentation-only
  source-skill: K-Dense-AI/scientific-agent-skills/scientific-skills/xlsx
---

# XLSX Spreadsheet Guidance

Use this skill to scope spreadsheet work and route to supported mobile-safe outputs.

## Mobile Boundaries

- Do not run recalculation scripts, Office XML pack/unpack scripts, Python, or LibreOffice on iOS.
- If the user can provide CSV/TSV export, use `scientific.document_inspect` and `scientific.document_to_markdown`.
- For full XLSX editing, formulas, charts, or workbook validation, require a future AMA Swift spreadsheet host intent.

## Output Standard

Return:

- requested spreadsheet operation
- supported mobile path, if any
- unsupported workbook features
- recommended export format
- required future host intent if blocked
