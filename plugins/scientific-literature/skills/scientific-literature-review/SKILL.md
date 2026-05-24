---
name: scientific-literature-review
description: Structure a source-grounded literature review from AMA scholarly lookup results while marking evidence, gaps, and non-exhaustive coverage.
---
# scientific-literature-review

Use this skill when the user asks for a literature review, related work summary, evidence map, or research background section.

## Workflow

1. Use `scientific-paper-lookup` first unless the user already supplied paper records.
2. Group returned papers by theme, method, population/domain, and recency.
3. Separate confirmed metadata from agent synthesis.
4. Name missing databases, sparse results, or failed lookups.
5. End with citation candidates and open evidence gaps.

## Output shape

Return:

- scope and query used
- databases queried
- key papers grouped by theme
- what the evidence supports
- what remains uncertain
- citation candidates with DOI/PMID/arXiv id when available

Do not claim that the search is exhaustive unless the user supplied a complete source set and the evidence proves it.

## Mobile boundary

This is a documentation-and-synthesis skill. It may call `scientific.paper_search` through `run_intent`, but it must not execute scripts, shell commands, desktop search CLIs, or external package managers.
