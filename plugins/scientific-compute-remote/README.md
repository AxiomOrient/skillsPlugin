# Scientific Compute Remote

AMA plugin category for scientific-agent-skills entries that require Python/scientific libraries, GPU, simulation, model training, notebooks, or large local file workflows.

- Skill count: 84
- Runtime intent: `scientific.remote_job_preflight`
- Local iOS scripts: not shipped and not executed
- Install/remove unit: this plugin directory

This pack keeps upstream non-script references and rewrites the runtime path for AMA mobile. It is a preflight and planning layer until AMA has a trusted remote compute provider. For bounded Python/MATLAB-like work that has an iOS Swift replacement, the preflight can now return an `ios_native` route with a concrete host intent such as `scientific.numeric_eval`, `scientific.chart_render_svg`, `scientific.chart_render_markdown`, or `scientific.document_to_markdown`.

The preflight response records:

- requested runtime class: Python, MATLAB, R, Docker, GPU, notebook, large-file, Swift-native, docs-only, or unknown
- execution route: iOS native, remote compute, remote compute after approval/review, blocked remote compute, or documentation-only
- conversion plan: Swift host intent substitution, remote job preparation, or MATLAB Coder build-time conversion guidance
- policy invariants: no local Python/MATLAB/shell interpreter and no local script execution on iOS

Latest upstream coverage additions:

- `bids`: BIDS layout, metadata, validation, and conversion planning with remote preflight for PyBIDS, bids-validator, Deno, DICOM conversion, and large dataset inspection.
- `pacsomatic`: nf-core/pacsomatic matched tumor-normal workflow planning with remote preflight for Nextflow, containers, scheduler submission, and BAM/PBI validation.
