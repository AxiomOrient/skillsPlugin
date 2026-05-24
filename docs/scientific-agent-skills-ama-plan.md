# Scientific Agent Skills AMA Implementation Plan

## Decision

[FACT] `K-Dense-AI/scientific-agent-skills` is an Agent Skills repository, not an AMA plugin repository. It has no `ama-skill-plugin.json` manifests and no AMA Swift host-intent registrations.

[INFERENCE] AMA can use a meaningful subset, but not by copying the repository as executable skills. The product path is to curate AMA plugin packs and convert execution-heavy behavior into Swift host intents or a trusted remote-compute bridge.

## Source And Inventory

- [FACT] Source: https://github.com/K-Dense-AI/scientific-agent-skills at local shallow clone commit `66d1ad4` from 2026-05-21.
- [FACT] The current cloned tree has 139 `scientific-skills/*/SKILL.md` files. Compared with the earlier audit, upstream added `bids` and `pacsomatic`; both are now converted into the AMA `scientific-compute-remote` plugin as mobile preflight skills.
- [FACT] Coverage audit: `docs/scientific-agent-skills-coverage-audit.md`. The only direct upstream-name gap is `pdf`, which is an intentional product exclusion and is replaced by Markdown-first document import.
- [FACT] Brownfield inventory command: `python3 /Users/axient/.codex/skills/analyze-repo-brownfield/scripts/repo_inventory.py /tmp/scientific-agent-skills`.
- [FACT] Current upstream tree scan found 139 skill directories, 1339 files under `scientific-skills`, 65 `scripts/` directories, and 262 script-like or executable files.
- [FACT] Checked-in security summary severity by skill: CRITICAL=19, HIGH=11, LOW=94, MEDIUM=7, NOT_SCANNED=1, SAFE=5.

## AMA Compatibility Rules Applied

- [FACT] AMA mobile skills should not execute Python, shell, MATLAB, Docker, arbitrary local CLI tools, or desktop daemons on iOS.
- [FACT] AMA-compatible execution should be `instruction-only`, WebKit when purely browser-safe, or `run_intent` backed by Swift host capabilities.
- [INFERENCE] Original `SKILL.md` and `references/` can be installed as documentation only after frontmatter normalization, but any original `scripts/` must be marked unavailable or replaced.
- [INFERENCE] A repository-wide install/uninstall unit is too broad for mobile. Use category packs so users can install and remove related skills together.

## Route Legend

| Route | Meaning | AMA implementation path |
|---|---|---|
| `DOC` | Reasoning, writing, review, planning, or policy guidance | Convert to mobile wording, strip desktop tool calls, keep references, no executable promise. |
| `REST` | Public or authenticated web API lookup | Add Swift `URLSession` host intents, schemas, rate-limit handling, and typed results. |
| `ARTIFACT` | File, document, image, chart, citation, slide, or template artifact work | Add Swift artifact intents using Markdown, SVG, ZIP/XML, UniformTypeIdentifiers, Vision, Charts, or approved image generation APIs. |
| `CONNECTOR` | SaaS, lab platform, ELN/LIMS, hardware/cloud-lab integration | Add connector-specific Swift intents, secret handling, approvals, and audit records. |
| `REMOTE` | Python scientific package, GPU, simulation, model training, or large local scientific file workflow | Keep as docs until AMA has a trusted remote Python/job runner; never run locally on iOS. |
| `DEFER` | Desktop daemon, invasive local capture, or desktop-only runtime | Do not ship in first AMA product slice. |

## Recommended AMA Plugin Packs

| Pack | First skills | Runtime | Acceptance check |
|---|---|---|---|
| `scientific-literature` | `paper-lookup`, `research-lookup`, `citation-management`, `literature-review` | Swift REST + DOC | Install pack, load each skill, query arXiv/Crossref/OpenAlex, return typed citations without shell. |
| `scientific-reference` | `scientific-brainstorming`, `scientific-critical-thinking`, `peer-review`, `scientific-writing`, `what-if-oracle` | DOC | Install pack, `load_skill` returns mobile-safe instructions, no script execution available. |
| `scientific-documents` | `markdown-mermaid-writing`, `markitdown`, `docx`, `pptx`, `xlsx` | Swift artifact intents + DOC | iOS test imports Markdown/text-like artifacts, extracts/creates Markdown, and routes binary document work to Markdown export or future native editors. |
| `scientific-data-lookup` | `database-lookup`, `depmap`, `hugging-science`, `usfiscaldata`, `imaging-data-commons` | Swift REST | Query public endpoints with rate limits and API-key optional paths. |
| `scientific-lab-connectors` | `benchling-integration`, `labarchive-integration`, `protocolsio-integration`, `omero-integration` | Connector intents | Secrets stay in AMA secret store; mutating calls require approval. |
| `scientific-compute-remote` | Python/package/pipeline/data skills such as `bids`, `pacsomatic`, `rdkit`, `scanpy`, `pymc`, `qiskit`, `timesfm-forecasting` | Remote job bridge | User approves upload/job; iOS receives result artifacts; no arbitrary local code execution. |

## Implemented Mobile Execution Addendum

[FACT] AMA now includes `scientific.web_api_search` as a Swift `URLSession` host intent for the first web/API provider slice.

- `openalex`: approved external lookup returns normalized work results; optional `apiKey` and `email` are redacted in source evidence.
- `crossref`: approved public work metadata search returns normalized DOI/title/journal/author records; optional `email` is redacted in source evidence.
- `pubmed`: approved NCBI ESearch/ESummary search returns normalized PMID/DOI/title/journal/author records; optional `apiKey` and `email` are redacted in source evidence.
- `exa`: approved external lookup requires `apiKey`; missing credentials return `needs_credentials` before any network call.
- `scientific-web-research` skills call `run_intent` for supported providers and do not execute source repository scripts.
- AMASample iOS verification covers approval gating, OpenAlex Swift search, Crossref Swift search, PubMed Swift search, Semantic Scholar Swift search, Exa credentials gating, artifact renderer gating, desktop-only blocking, and no local scripts.

[FACT] AMA now includes `scientific.chart_render_svg` and `scientific.chart_render_markdown` as Swift host intents for constrained line, scatter, and bar chart artifacts.

- `scientific.chart_render_svg` persists an `image/svg+xml` artifact.
- `scientific.chart_render_markdown` persists a `text/markdown` chart document artifact and returns byte-count evidence.
- AMASample iOS verification covers Markdown chart artifact creation in the `ama-skills-host-scientific-local-execution` scenario.

## First Reversible Slice

[INFERENCE] Start with `scientific-literature`, because it is valuable on mobile, avoids Python, and can be verified with deterministic public HTTP APIs.

Scope:

1. Create `plugins/scientific-literature/ama-skill-plugin.json` in `skillsPlugin`.
2. Convert `paper-lookup`, `research-lookup`, and a reduced `citation-management` into AMA skills.
3. Add AMA Swift intents under `AMASkillsHost` for `scientific.paper_search`, `scientific.paper_lookup`, `scientific.doi_to_bibtex`, and `scientific.open_access_lookup`.
4. Register these intents in a `scientificLiteratureSet()` similar to `akashaCoreSet()`.
5. iOS proof test: install the pack from `skillsPlugin`, `load_skill` each converted skill, call `run_intent`, and assert structured JSON results.

Out of scope for first slice:

- Python package execution, GPU jobs, MATLAB/Octave, screenpipe/autoskill, lab hardware control, and document editing.
- Clinical decision automation beyond safe document guidance.
- Bulk importing all 139 upstream skills as one plugin.

## Swift Intent Surface For First Slice

| Intent | Inputs | Output | Notes |
|---|---|---|---|
| `scientific.paper_search` | `query`, `databases`, `limit`, optional `fromYear/toYear` | normalized papers array with title, authors, year, DOI/PMID/arXiv, source URL | PubMed, arXiv, Crossref, OpenAlex first. |
| `scientific.paper_lookup` | `identifier`, `identifierType` | single paper metadata plus source evidence | DOI, PMID, arXiv. |
| `scientific.open_access_lookup` | `doi`, optional `email` | OA status, license, PDF/page URL when available | Unpaywall requires email-like parameter; avoid storing without user consent. |
| `scientific.doi_to_bibtex` | `doi`, `style` | BibTeX string + raw source metadata | Crossref first; never shell out to citation scripts. |

## Skill-By-Skill AMA Feasibility

| Skill | Route | Scripts | Refs | Assets | Tests | Security | AMA decision |
|---|---:|---:|---:|---:|---:|---|---|
| `adaptyv` | `REST` | 0 | 1 | 0 | 0 | LOW:4 | Feasible with Swift URLSession host intents and typed response models. |
| `aeon` | `REMOTE` | 0 | 11 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `anndata` | `REMOTE` | 0 | 5 | 0 | 0 | SAFE:0 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `arboreto` | `REMOTE` | 1 | 3 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `astropy` | `REMOTE` | 0 | 7 | 0 | 0 | SAFE:0 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `autoskill` | `DEFER` | 23 | 2 | 0 | 13 | CRITICAL:14 | Not suitable for direct mobile port; keep unavailable unless a separate desktop/daemon bridge is designed. |
| `benchling-integration` | `CONNECTOR` | 0 | 3 | 0 | 0 | LOW:5 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `bgpt-paper-search` | `REST` | 0 | 0 | 0 | 0 | LOW:7 | Feasible with Swift URLSession host intents and typed response models. |
| `bids` | `REMOTE` | 1 | 5 | 0 | 0 | not in earlier security summary | BIDS guidance is useful on mobile, but PyBIDS, bids-validator, Deno, DICOM conversion, and large dataset validation require remote preflight or a future native validator. |
| `biopython` | `REMOTE` | 0 | 7 | 0 | 0 | LOW:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `bioservices` | `REMOTE` | 4 | 3 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `cellxgene-census` | `REMOTE` | 0 | 2 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `cirq` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `citation-management` | `ARTIFACT` | 8 | 5 | 2 | 0 | CRITICAL:14 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `clinical-decision-support` | `DOC` | 7 | 7 | 7 | 0 | CRITICAL:10 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `clinical-reports` | `DOC` | 10 | 9 | 12 | 0 | CRITICAL:12 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `cobrapy` | `REMOTE` | 0 | 2 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `consciousness-council` | `DOC` | 0 | 1 | 0 | 0 | LOW:4 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `dask` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `database-lookup` | `REST` | 0 | 78 | 0 | 0 | LOW:4 | Feasible with Swift URLSession host intents and typed response models. |
| `datamol` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `deepchem` | `REMOTE` | 3 | 2 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `deeptools` | `REMOTE` | 2 | 4 | 1 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `depmap` | `REST` | 0 | 1 | 0 | 0 | LOW:4 | Feasible with Swift URLSession host intents and typed response models. |
| `dhdna-profiler` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `diffdock` | `REMOTE` | 3 | 3 | 2 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `dnanexus-integration` | `CONNECTOR` | 0 | 5 | 0 | 0 | LOW:4 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `docx` | `ARTIFACT` | 59 | 0 | 0 | 0 | LOW:4 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `esm` | `REMOTE` | 0 | 4 | 0 | 0 | HIGH:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `etetoolkit` | `REMOTE` | 2 | 3 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `exa-search` | `REST` | 3 | 2 | 0 | 1 | MEDIUM:5 | Feasible with Swift URLSession host intents and typed response models. |
| `exploratory-data-analysis` | `REMOTE` | 1 | 6 | 1 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `flowio` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `fluidsim` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `generate-image` | `ARTIFACT` | 1 | 0 | 0 | 0 | LOW:3 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `geniml` | `REMOTE` | 0 | 5 | 0 | 0 | LOW:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `geomaster` | `REMOTE` | 0 | 14 | 0 | 0 | HIGH:8 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `geopandas` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `get-available-resources` | `REMOTE` | 1 | 0 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `gget` | `REMOTE` | 3 | 3 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `ginkgo-cloud-lab` | `CONNECTOR` | 0 | 3 | 0 | 0 | LOW:4 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `glycoengineering` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `gtars` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `histolab` | `REMOTE` | 0 | 5 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `hugging-science` | `REST` | 1 | 5 | 0 | 0 | LOW:5 | Feasible with Swift URLSession host intents and typed response models. |
| `hypogenic` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `hypothesis-generation` | `DOC` | 2 | 3 | 3 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `imaging-data-commons` | `REST` | 0 | 10 | 0 | 0 | MEDIUM:4 | Feasible with Swift URLSession host intents and typed response models. |
| `infographics` | `ARTIFACT` | 2 | 3 | 0 | 0 | CRITICAL:10 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `iso-13485-certification` | `DOC` | 1 | 4 | 3 | 0 | LOW:3 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `labarchive-integration` | `CONNECTOR` | 3 | 3 | 0 | 0 | MEDIUM:7 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `lamindb` | `CONNECTOR` | 0 | 6 | 0 | 0 | LOW:3 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `latchbio-integration` | `CONNECTOR` | 0 | 4 | 0 | 0 | SAFE:0 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `latex-posters` | `ARTIFACT` | 3 | 5 | 4 | 0 | CRITICAL:9 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `literature-review` | `DOC` | 5 | 2 | 1 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `markdown-mermaid-writing` | `ARTIFACT` | 0 | 26 | 1 | 0 | SAFE:0 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `market-research-reports` | `DOC` | 1 | 3 | 3 | 0 | LOW:5 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `markitdown` | `ARTIFACT` | 5 | 2 | 1 | 0 | CRITICAL:10 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `matchms` | `REMOTE` | 0 | 4 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `matlab` | `DEFER` | 0 | 8 | 0 | 0 | LOW:4 | Not suitable for direct mobile port; keep unavailable unless a separate desktop/daemon bridge is designed. |
| `matplotlib` | `REMOTE` | 2 | 4 | 0 | 0 | SAFE:0 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `medchem` | `REMOTE` | 1 | 2 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `modal` | `REMOTE` | 0 | 12 | 0 | 0 | HIGH:9 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `molecular-dynamics` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `molfeat` | `REMOTE` | 0 | 3 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `networkx` | `REMOTE` | 0 | 5 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `neurokit2` | `REMOTE` | 0 | 12 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `neuropixels-analysis` | `REMOTE` | 7 | 10 | 1 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `omero-integration` | `CONNECTOR` | 0 | 8 | 0 | 0 | LOW:5 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `open-notebook` | `CONNECTOR` | 4 | 4 | 0 | 0 | MEDIUM:20 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `opentrons-integration` | `CONNECTOR` | 3 | 1 | 0 | 0 | LOW:3 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `optimize-for-gpu` | `REMOTE` | 0 | 12 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pacsomatic` | `REMOTE` | 1 | 3 | 0 | 1 | not in earlier security summary | Nextflow, containers, scheduler submission, BAM/PBI validation, and HPC execution are remote-only on iOS; convert to preflight and planning guidance. |
| `paper-lookup` | `REST` | 0 | 10 | 0 | 0 | LOW:5 | Feasible with Swift URLSession host intents and typed response models. |
| `paperzilla` | `REST` | 0 | 0 | 0 | 0 | LOW:3 | Feasible with Swift URLSession host intents and typed response models. |
| `parallel-web` | `REMOTE` | 0 | 4 | 0 | 0 | LOW:6 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pathml` | `REMOTE` | 0 | 6 | 0 | 0 | HIGH:7 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pdf` | `REMOVED` | 8 | 0 | 0 | 0 | LOW:4 | Removed from AMA mobile plugin; require Markdown export before import or a future approved native document intent. |
| `peer-review` | `DOC` | 2 | 2 | 0 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `pennylane` | `REMOTE` | 0 | 7 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `phylogenetics` | `REMOTE` | 1 | 1 | 0 | 0 | MEDIUM:8 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `polars` | `REMOTE` | 0 | 6 | 0 | 0 | HIGH:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `polars-bio` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pptx` | `ARTIFACT` | 55 | 0 | 0 | 0 | LOW:4 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `pptx-posters` | `ARTIFACT` | 2 | 3 | 2 | 0 | CRITICAL:9 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `primekg` | `REST` | 1 | 0 | 0 | 0 | LOW:4 | Feasible with Swift URLSession host intents and typed response models. |
| `protocolsio-integration` | `CONNECTOR` | 0 | 6 | 0 | 0 | MEDIUM:6 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `pufferlib` | `REMOTE` | 2 | 5 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pydeseq2` | `REMOTE` | 1 | 2 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pydicom` | `REMOTE` | 3 | 2 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyhealth` | `REMOTE` | 1 | 6 | 1 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pylabrobot` | `CONNECTOR` | 0 | 6 | 0 | 0 | LOW:3 | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `pymatgen` | `REMOTE` | 3 | 5 | 0 | 0 | MEDIUM:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pymc` | `REMOTE` | 4 | 3 | 2 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pymoo` | `REMOTE` | 5 | 5 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyopenms` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pysam` | `REMOTE` | 0 | 4 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pytdc` | `REMOTE` | 3 | 3 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pytorch-lightning` | `REMOTE` | 3 | 7 | 0 | 0 | HIGH:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyzotero` | `REMOTE` | 0 | 13 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `qiskit` | `REMOTE` | 0 | 8 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `qutip` | `REMOTE` | 0 | 5 | 0 | 0 | HIGH:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `rdkit` | `REMOTE` | 3 | 3 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `research-grants` | `DOC` | 2 | 8 | 3 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `research-lookup` | `REST` | 6 | 0 | 0 | 0 | NOT_SCANNED | Feasible with Swift URLSession host intents and typed response models. |
| `rowan` | `REMOTE` | 0 | 0 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scanpy` | `REMOTE` | 2 | 3 | 1 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scholar-evaluation` | `DOC` | 3 | 1 | 0 | 0 | CRITICAL:10 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-brainstorming` | `DOC` | 0 | 1 | 0 | 0 | LOW:2 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-critical-thinking` | `DOC` | 2 | 6 | 0 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-schematics` | `ARTIFACT` | 3 | 3 | 0 | 0 | CRITICAL:9 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-slides` | `ARTIFACT` | 7 | 6 | 5 | 0 | CRITICAL:14 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-visualization` | `ARTIFACT` | 3 | 4 | 4 | 0 | LOW:1 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-writing` | `DOC` | 3 | 6 | 3 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scikit-bio` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scikit-learn` | `REMOTE` | 2 | 6 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scikit-survival` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scvelo` | `REMOTE` | 1 | 1 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scvi-tools` | `REMOTE` | 0 | 8 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `seaborn` | `REMOTE` | 0 | 3 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `shap` | `REMOTE` | 0 | 4 | 0 | 0 | LOW:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `simpy` | `REMOTE` | 2 | 5 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `stable-baselines3` | `REMOTE` | 3 | 4 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `statistical-analysis` | `REMOTE` | 1 | 5 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `statsmodels` | `REMOTE` | 0 | 5 | 0 | 0 | LOW:1 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `sympy` | `REMOTE` | 0 | 5 | 0 | 0 | HIGH:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `tiledbvcf` | `REMOTE` | 0 | 0 | 0 | 0 | LOW:2 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `timesfm-forecasting` | `REMOTE` | 10 | 3 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `torch-geometric` | `REMOTE` | 0 | 6 | 0 | 0 | HIGH:7 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `torchdrug` | `REMOTE` | 0 | 8 | 0 | 0 | HIGH:3 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `transformers` | `REMOTE` | 0 | 5 | 0 | 0 | HIGH:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `treatment-plans` | `DOC` | 6 | 6 | 10 | 0 | CRITICAL:9 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `umap-learn` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:4 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `usfiscaldata` | `REST` | 0 | 8 | 0 | 0 | LOW:2 | Feasible with Swift URLSession host intents and typed response models. |
| `vaex` | `REMOTE` | 0 | 6 | 0 | 0 | LOW:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `venue-templates` | `ARTIFACT` | 5 | 11 | 10 | 0 | CRITICAL:9 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `what-if-oracle` | `DOC` | 0 | 1 | 0 | 0 | LOW:4 | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `xlsx` | `ARTIFACT` | 52 | 0 | 0 | 0 | LOW:4 | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `zarr-python` | `REMOTE` | 0 | 1 | 0 | 0 | LOW:5 | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |

## Risks

- [FACT] The source repo explicitly warns that skills can instruct agents to run arbitrary code, install packages, make network requests, and modify files.
- [FACT] The checked-in `SECURITY.md` reports critical/high findings on multiple writing, clinical, document, and model/tool skills.
- [INFERENCE] Direct installation without AMA conversion would create a misleading mobile UX: skills would appear installed, but many would fail because iOS cannot run their Python/shell/desktop dependencies.
- [INFERENCE] Clinical and treatment-plan skills need extra product policy: they can draft or structure information, but must not present autonomous diagnosis or treatment recommendations as medical advice.
- [UNKNOWN] Per-skill licenses may differ from the repository MIT license; each converted plugin must preserve and expose source skill license metadata before distribution.

## Validation Plan

For every converted pack:

1. Static package check: no `.py`, `.sh`, `.ps1`, `.bat`, Node, or executable desktop helper files inside AMA plugin skills unless they are inert reference text.
2. Manifest check: each pack has `ama-skill-plugin.json`, every skill has `name` and `description`, and category install/remove works as a unit.
3. Runtime check: iOS simulator installs the pack, loads the skill, and either returns documentation-only instructions or calls a registered Swift intent.
4. Failure check: missing API keys, rate limits, invalid identifiers, no-network state, and mutating connector calls return structured errors without shell fallback.
5. Security check: any skill derived from source rows with `CRITICAL` or `HIGH` security severity requires a manual rewrite and dedicated review before shipping.

## Product Decision

[INFERENCE] Proceed, but only as curated AMA-native packs. The first product-quality implementation should be `scientific-literature`; the full 139-skill source repository should remain an upstream catalog, not an installable AMA pack.
