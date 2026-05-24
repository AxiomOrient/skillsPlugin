# Scientific Agent Skills Per-Skill AMA Map

Date: 2026-05-24

## Purpose

This map ties each upstream `K-Dense-AI/scientific-agent-skills` skill to the AMA mobile plugin surface. It is generated from the current upstream checkout, the converted plugin manifests, and the skill-by-skill feasibility table in `scientific-agent-skills-ama-plan.md`.

## Source Snapshot

- Upstream commit: `66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9`
- Upstream skill count: 139
- AMA scientific plugin count: 11
- AMA manifest skill count: 142
- Intentional upstream exclusion: `pdf`, replaced by Markdown-first document import and conversion.

## Runtime Rules

- `DOC`: Documentation-only mobile guidance; no local executable tools.
- `REST`: Swift URLSession or approved web API preflight/lookup intent.
- `ARTIFACT`: Swift artifact/document/chart intent, Markdown/SVG path, or renderer preflight.
- `CONNECTOR`: Connector preflight with credentials, approval, and audit boundary.
- `REMOTE`: Installed as remote-compute preflight; Python/GPU/large-file execution is not local on iOS.
- `DEFER`: Installed as unavailable/deferred desktop capability unless native substitute exists.
- `REMOVED`: Not installed by product decision; replacement route documented.

## Per-Skill Map

| Upstream skill | Route | AMA status | Installed AMA skill path(s) | Runtime/Conversion decision |
|---|---|---|---|---|
| `adaptyv` | `REST` | installed | `scientific-web-research/skills/adaptyv` | Feasible with Swift URLSession host intents and typed response models. |
| `aeon` | `REMOTE` | installed | `scientific-compute-remote/skills/aeon` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `anndata` | `REMOTE` | installed | `scientific-compute-remote/skills/anndata` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `arboreto` | `REMOTE` | installed | `scientific-compute-remote/skills/arboreto` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `astropy` | `REMOTE` | installed | `scientific-compute-remote/skills/astropy` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `autoskill` | `DEFER` | installed | `scientific-deferred-desktop/skills/autoskill` | Not suitable for direct mobile port; keep unavailable unless a separate desktop/daemon bridge is designed. |
| `benchling-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/benchling-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `bgpt-paper-search` | `REST` | installed | `scientific-web-research/skills/bgpt-paper-search` | Feasible with Swift URLSession host intents and typed response models. |
| `bids` | `REMOTE` | installed | `scientific-compute-remote/skills/bids` | BIDS guidance is useful on mobile, but PyBIDS, bids-validator, Deno, DICOM conversion, and large dataset validation require remote preflight or a future native validator. |
| `biopython` | `REMOTE` | installed | `scientific-compute-remote/skills/biopython` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `bioservices` | `REMOTE` | installed | `scientific-compute-remote/skills/bioservices` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `cellxgene-census` | `REMOTE` | installed | `scientific-compute-remote/skills/cellxgene-census` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `cirq` | `REMOTE` | installed | `scientific-compute-remote/skills/cirq` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `citation-management` | `ARTIFACT` | installed | `scientific-literature/skills/scientific-citation-management`<br>`scientific-visual-artifacts/skills/citation-management` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `clinical-decision-support` | `DOC` | installed | `scientific-clinical-compliance/skills/clinical-decision-support` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `clinical-reports` | `DOC` | installed | `scientific-clinical-compliance/skills/clinical-reports` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `cobrapy` | `REMOTE` | installed | `scientific-compute-remote/skills/cobrapy` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `consciousness-council` | `DOC` | installed | `scientific-reasoning-docs/skills/consciousness-council` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `dask` | `REMOTE` | installed | `scientific-compute-remote/skills/dask` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `database-lookup` | `REST` | installed | `scientific-data-lookup/skills/database-lookup` | Feasible with Swift URLSession host intents and typed response models. |
| `datamol` | `REMOTE` | installed | `scientific-compute-remote/skills/datamol` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `deepchem` | `REMOTE` | installed | `scientific-compute-remote/skills/deepchem` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `deeptools` | `REMOTE` | installed | `scientific-compute-remote/skills/deeptools` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `depmap` | `REST` | installed | `scientific-data-lookup/skills/depmap` | Feasible with Swift URLSession host intents and typed response models. |
| `dhdna-profiler` | `REMOTE` | installed | `scientific-compute-remote/skills/dhdna-profiler` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `diffdock` | `REMOTE` | installed | `scientific-compute-remote/skills/diffdock` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `dnanexus-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/dnanexus-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `docx` | `ARTIFACT` | installed | `scientific-documents/skills/docx` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `esm` | `REMOTE` | installed | `scientific-compute-remote/skills/esm` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `etetoolkit` | `REMOTE` | installed | `scientific-compute-remote/skills/etetoolkit` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `exa-search` | `REST` | installed | `scientific-web-research/skills/exa-search` | Feasible with Swift URLSession host intents and typed response models. |
| `exploratory-data-analysis` | `REMOTE` | installed | `scientific-compute-remote/skills/exploratory-data-analysis` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `flowio` | `REMOTE` | installed | `scientific-compute-remote/skills/flowio` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `fluidsim` | `REMOTE` | installed | `scientific-compute-remote/skills/fluidsim` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `generate-image` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/generate-image` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `geniml` | `REMOTE` | installed | `scientific-compute-remote/skills/geniml` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `geomaster` | `REMOTE` | installed | `scientific-compute-remote/skills/geomaster` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `geopandas` | `REMOTE` | installed | `scientific-compute-remote/skills/geopandas` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `get-available-resources` | `REMOTE` | installed | `scientific-compute-remote/skills/get-available-resources` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `gget` | `REMOTE` | installed | `scientific-compute-remote/skills/gget` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `ginkgo-cloud-lab` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/ginkgo-cloud-lab` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `glycoengineering` | `REMOTE` | installed | `scientific-compute-remote/skills/glycoengineering` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `gtars` | `REMOTE` | installed | `scientific-compute-remote/skills/gtars` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `histolab` | `REMOTE` | installed | `scientific-compute-remote/skills/histolab` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `hugging-science` | `REST` | installed | `scientific-data-lookup/skills/hugging-science` | Feasible with Swift URLSession host intents and typed response models. |
| `hypogenic` | `REMOTE` | installed | `scientific-compute-remote/skills/hypogenic` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `hypothesis-generation` | `DOC` | installed | `scientific-reasoning-docs/skills/hypothesis-generation` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `imaging-data-commons` | `REST` | installed | `scientific-web-research/skills/imaging-data-commons` | Feasible with Swift URLSession host intents and typed response models. |
| `infographics` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/infographics` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `iso-13485-certification` | `DOC` | installed | `scientific-clinical-compliance/skills/iso-13485-certification` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `labarchive-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/labarchive-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `lamindb` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/lamindb` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `latchbio-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/latchbio-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `latex-posters` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/latex-posters` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `literature-review` | `DOC` | installed | `scientific-literature/skills/scientific-literature-review`<br>`scientific-reasoning-docs/skills/literature-review` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `markdown-mermaid-writing` | `ARTIFACT` | installed | `scientific-documents/skills/markdown-mermaid-writing` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `market-research-reports` | `DOC` | installed | `scientific-reasoning-docs/skills/market-research-reports` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `markitdown` | `ARTIFACT` | installed | `scientific-documents/skills/markitdown` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `matchms` | `REMOTE` | installed | `scientific-compute-remote/skills/matchms` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `matlab` | `DEFER` | installed | `scientific-deferred-desktop/skills/matlab` | Not suitable for direct mobile port; keep unavailable unless a separate desktop/daemon bridge is designed. |
| `matplotlib` | `REMOTE` | installed | `scientific-compute-remote/skills/matplotlib` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `medchem` | `REMOTE` | installed | `scientific-compute-remote/skills/medchem` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `modal` | `REMOTE` | installed | `scientific-compute-remote/skills/modal` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `molecular-dynamics` | `REMOTE` | installed | `scientific-compute-remote/skills/molecular-dynamics` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `molfeat` | `REMOTE` | installed | `scientific-compute-remote/skills/molfeat` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `networkx` | `REMOTE` | installed | `scientific-compute-remote/skills/networkx` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `neurokit2` | `REMOTE` | installed | `scientific-compute-remote/skills/neurokit2` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `neuropixels-analysis` | `REMOTE` | installed | `scientific-compute-remote/skills/neuropixels-analysis` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `omero-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/omero-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `open-notebook` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/open-notebook` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `opentrons-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/opentrons-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `optimize-for-gpu` | `REMOTE` | installed | `scientific-compute-remote/skills/optimize-for-gpu` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pacsomatic` | `REMOTE` | installed | `scientific-compute-remote/skills/pacsomatic` | Nextflow, containers, scheduler submission, BAM/PBI validation, and HPC execution are remote-only on iOS; convert to preflight and planning guidance. |
| `paper-lookup` | `REST` | installed | `scientific-literature/skills/scientific-paper-lookup`<br>`scientific-web-research/skills/paper-lookup` | Feasible with Swift URLSession host intents and typed response models. |
| `paperzilla` | `REST` | installed | `scientific-web-research/skills/paperzilla` | Feasible with Swift URLSession host intents and typed response models. |
| `parallel-web` | `REMOTE` | installed | `scientific-compute-remote/skills/parallel-web` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pathml` | `REMOTE` | installed | `scientific-compute-remote/skills/pathml` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pdf` | `REMOVED` | intentional-exclusion | not installed | Removed from AMA mobile plugins. Require Markdown or UTF-8 text-like export before import; future binary document support must be native Swift or approved remote service. |
| `peer-review` | `DOC` | installed | `scientific-reference/skills/peer-review` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `pennylane` | `REMOTE` | installed | `scientific-compute-remote/skills/pennylane` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `phylogenetics` | `REMOTE` | installed | `scientific-compute-remote/skills/phylogenetics` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `polars` | `REMOTE` | installed | `scientific-compute-remote/skills/polars` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `polars-bio` | `REMOTE` | installed | `scientific-compute-remote/skills/polars-bio` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pptx` | `ARTIFACT` | installed | `scientific-documents/skills/pptx` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `pptx-posters` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/pptx-posters` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `primekg` | `REST` | installed | `scientific-web-research/skills/primekg` | Feasible with Swift URLSession host intents and typed response models. |
| `protocolsio-integration` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/protocolsio-integration` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `pufferlib` | `REMOTE` | installed | `scientific-compute-remote/skills/pufferlib` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pydeseq2` | `REMOTE` | installed | `scientific-compute-remote/skills/pydeseq2` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pydicom` | `REMOTE` | installed | `scientific-compute-remote/skills/pydicom` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyhealth` | `REMOTE` | installed | `scientific-compute-remote/skills/pyhealth` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pylabrobot` | `CONNECTOR` | installed | `scientific-lab-connectors/skills/pylabrobot` | Possible with explicit SaaS/lab connector, credentials, approval, and audit trail. |
| `pymatgen` | `REMOTE` | installed | `scientific-compute-remote/skills/pymatgen` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pymc` | `REMOTE` | installed | `scientific-compute-remote/skills/pymc` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pymoo` | `REMOTE` | installed | `scientific-compute-remote/skills/pymoo` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyopenms` | `REMOTE` | installed | `scientific-compute-remote/skills/pyopenms` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pysam` | `REMOTE` | installed | `scientific-compute-remote/skills/pysam` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pytdc` | `REMOTE` | installed | `scientific-compute-remote/skills/pytdc` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pytorch-lightning` | `REMOTE` | installed | `scientific-compute-remote/skills/pytorch-lightning` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `pyzotero` | `REMOTE` | installed | `scientific-compute-remote/skills/pyzotero` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `qiskit` | `REMOTE` | installed | `scientific-compute-remote/skills/qiskit` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `qutip` | `REMOTE` | installed | `scientific-compute-remote/skills/qutip` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `rdkit` | `REMOTE` | installed | `scientific-compute-remote/skills/rdkit` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `research-grants` | `DOC` | installed | `scientific-reasoning-docs/skills/research-grants` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `research-lookup` | `REST` | installed | `scientific-literature/skills/scientific-research-lookup`<br>`scientific-web-research/skills/research-lookup` | Feasible with Swift URLSession host intents and typed response models. |
| `rowan` | `REMOTE` | installed | `scientific-compute-remote/skills/rowan` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scanpy` | `REMOTE` | installed | `scientific-compute-remote/skills/scanpy` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scholar-evaluation` | `DOC` | installed | `scientific-reasoning-docs/skills/scholar-evaluation` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-brainstorming` | `DOC` | installed | `scientific-reference/skills/scientific-brainstorming` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-critical-thinking` | `DOC` | installed | `scientific-reference/skills/scientific-critical-thinking` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scientific-schematics` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/scientific-schematics` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-slides` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/scientific-slides` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-visualization` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/scientific-visualization` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `scientific-writing` | `DOC` | installed | `scientific-reference/skills/scientific-writing` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `scikit-bio` | `REMOTE` | installed | `scientific-compute-remote/skills/scikit-bio` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scikit-learn` | `REMOTE` | installed | `scientific-compute-remote/skills/scikit-learn` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scikit-survival` | `REMOTE` | installed | `scientific-compute-remote/skills/scikit-survival` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scvelo` | `REMOTE` | installed | `scientific-compute-remote/skills/scvelo` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `scvi-tools` | `REMOTE` | installed | `scientific-compute-remote/skills/scvi-tools` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `seaborn` | `REMOTE` | installed | `scientific-compute-remote/skills/seaborn` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `shap` | `REMOTE` | installed | `scientific-compute-remote/skills/shap` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `simpy` | `REMOTE` | installed | `scientific-compute-remote/skills/simpy` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `stable-baselines3` | `REMOTE` | installed | `scientific-compute-remote/skills/stable-baselines3` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `statistical-analysis` | `REMOTE` | installed | `scientific-compute-remote/skills/statistical-analysis` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `statsmodels` | `REMOTE` | installed | `scientific-compute-remote/skills/statsmodels` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `sympy` | `REMOTE` | installed | `scientific-compute-remote/skills/sympy` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `tiledbvcf` | `REMOTE` | installed | `scientific-compute-remote/skills/tiledbvcf` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `timesfm-forecasting` | `REMOTE` | installed | `scientific-compute-remote/skills/timesfm-forecasting` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `torch-geometric` | `REMOTE` | installed | `scientific-compute-remote/skills/torch-geometric` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `torchdrug` | `REMOTE` | installed | `scientific-compute-remote/skills/torchdrug` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `transformers` | `REMOTE` | installed | `scientific-compute-remote/skills/transformers` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `treatment-plans` | `DOC` | installed | `scientific-clinical-compliance/skills/treatment-plans` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `umap-learn` | `REMOTE` | installed | `scientific-compute-remote/skills/umap-learn` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `usfiscaldata` | `REST` | installed | `scientific-data-lookup/skills/usfiscaldata` | Feasible with Swift URLSession host intents and typed response models. |
| `vaex` | `REMOTE` | installed | `scientific-compute-remote/skills/vaex` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |
| `venue-templates` | `ARTIFACT` | installed | `scientific-visual-artifacts/skills/venue-templates` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `what-if-oracle` | `DOC` | installed | `scientific-reference/skills/what-if-oracle` | Useful as mobile reasoning/output guidance after removing script/tool assumptions; optional native helpers later. |
| `xlsx` | `ARTIFACT` | installed | `scientific-documents/skills/xlsx` | Feasible with Swift artifact/document/image intents; replace Python/shell scripts. |
| `zarr-python` | `REMOTE` | installed | `scientific-compute-remote/skills/zarr-python` | Computation depends on Python/scientific libraries, GPU, CLI, or large local files; use trusted remote job or native rewrite. |

## Alias Notes

The first literature slice introduced AMA-native alias skills while later packs also preserved the original upstream names. These aliases are expected extras in direct name comparison:

- `paper-lookup` -> `scientific-paper-lookup` at `scientific-literature/skills/scientific-paper-lookup`
- `research-lookup` -> `scientific-research-lookup` at `scientific-literature/skills/scientific-research-lookup`
- `citation-management` -> `scientific-citation-management` at `scientific-literature/skills/scientific-citation-management`
- `literature-review` -> `scientific-literature-review` at `scientific-literature/skills/scientific-literature-review`

## Validation Invariants

- Every upstream skill except `pdf` must have at least one installed AMA skill path.
- `pdf` must remain absent from plugin manifests and skill directories unless the product decision changes.
- Every manifest skill path must resolve to an existing `SKILL.md`.
- Scientific plugin directories must not contain executable Python, shell, PowerShell, batch, Node, MATLAB, R, or executable helper files.
