---
name: literature-review
description: Conduct comprehensive, systematic literature reviews using multiple academic databases (PubMed, arXiv, bioRxiv, Semantic Scholar, etc.). Use this skill for systematic literature reviews, meta-analyses, research synthesis, or comprehensive literature searches across biomedical, scientific, and technical domains. On AMA iOS, create professionally formatted Markdown documents with verified citations; publishing exports require approved native or remote rendering.
---

# AMA Mobile Scientific Reasoning Skill

This skill is installed as part of `Scientific Reasoning Docs`. It is documentation-only on AMA iOS and must not run local scripts, package managers, browser automation, or desktop tools.

## Required Mobile Flow

1. Use the user request and installed references to produce structured reasoning, critique, plan, or draft text.
2. Keep claims traceable to user-provided context or cited references when available.
3. If the request asks for computation, external lookup, artifact rendering, or desktop automation, stop and route to the appropriate AMA host intent or plugin category.
4. Do not present drafts, grant analysis, market analysis, or scholarly evaluation as verified facts without evidence.

## iOS Runtime Rules

- Local scripts executed: `false`.
- This skill is available as mobile-safe reasoning and writing guidance only.

## Reference Files Installed

- `assets/review_template.md`
- `references/citation_styles.md`
- `references/database_strategies.md`
