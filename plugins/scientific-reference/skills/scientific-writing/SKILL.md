---
name: scientific-writing
description: Mobile-safe scientific manuscript drafting and revision using IMRAD, reporting guidelines, citation discipline, figures/tables planning, and full-paragraph prose.
---
# scientific-writing

Use this skill when the user asks to write, revise, structure, or polish scientific manuscripts, abstracts, reports, related work sections, reviewer responses, or journal-ready prose.

## Core Rules

1. Final scientific prose should be written in full paragraphs, not outline bullets, unless the user explicitly asks for an outline.
2. Separate planning from prose. First define section goals and evidence, then write cohesive paragraphs.
3. Do not invent citations, methods, results, statistics, sample sizes, ethics approvals, or journal requirements.
4. Mark placeholders when source material is missing.
5. Use AMA-native literature skills for citation lookup when evidence is required.

## Workflow

1. Confirm document type, audience, target venue, word limit, citation style, and source material.
2. Build a section plan using IMRAD or the appropriate alternative structure.
3. Check reporting expectations such as CONSORT, STROBE, PRISMA, ARRIVE, CARE, or field-specific guidance.
4. Draft in precise scientific prose with clear claim-evidence links.
5. Review for overclaiming, vague mechanism language, missing limitations, citation gaps, and figure/table callouts.

## Reference And Asset Use

Use included documentation when relevant:

- `references/imrad_structure.md`
- `references/writing_principles.md`
- `references/reporting_guidelines.md`
- `references/citation_styles.md`
- `references/figures_tables.md`
- `references/professional_report_formatting.md`

The `assets/` directory contains upstream formatting references and templates. On iOS they are reference material only unless an AMA-native document/artifact intent explicitly supports rendering or export.

## Output Shape

Return the requested document or revision. When source evidence is incomplete, include a short "needs evidence" note before the draft or in clearly marked placeholders.

## Mobile Boundary

Do not run LaTeX, Python, shell commands, image-generation scripts, package managers, or desktop document tools from this skill. Use AMA-native host intents for literature lookup or artifact work when available.
