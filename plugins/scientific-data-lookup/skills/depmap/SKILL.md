---
name: depmap
description: Mobile-safe DepMap public release file lookup and interpretation planning without local Python analysis or bulk data processing.
---
# depmap

Use this skill when the user asks about DepMap datasets, public release files, gene dependency interpretation, cell-line context, CRISPR/RNAi screens, or how to plan a DepMap lookup.

## Workflow

1. Clarify gene, cell line, lineage, dependency type, release version, and whether the user needs file discovery, interpretation, or raw data processing.
2. For public release file discovery, call `run_intent` with `scientific.depmap_release_files`. Use `query` for file names such as `gene`, `model`, `crispr`, or `README`; use `release` for filters such as `26Q1`.
3. Use `references/dependency_analysis.md` to frame the analysis and required fields.
4. If the user needs actual computation over DepMap matrices, mark that as remote compute or desktop workflow until AMA has a native/remote data-processing intent.
5. Provide an iOS-safe lookup result, analysis plan, and interpretation checklist.

## Output Shape

Return:

- target gene/cell-line question
- required DepMap data tables
- release files returned by `scientific.depmap_release_files` when file discovery is requested
- interpretation checklist
- confounders such as lineage, copy number, expression, screen type, and release version
- what AMA can do now vs. what requires remote compute

## Mobile Boundary

Do not run Python, pandas, notebooks, local CSV matrix processing, or package installs on iOS.
