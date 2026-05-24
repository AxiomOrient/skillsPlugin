# Scientific Compute Remote AMA QA

Date: 2026-05-24

## Scope

This document records the seventh AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-compute-remote`

Converted skills:

- 84 `REMOTE` route skills from the feasibility table, including `bids`, `pacsomatic`, `rdkit`, `scanpy`, `pydicom`, `pymc`, `qiskit`, `transformers`, `torch-geometric`, `statsmodels`, `sympy`, and related Python/scientific library, neurodata, and pipeline skills.

The conversion target is iOS AMA. This category is a mobile-safe remote compute preflight layer, not a local Python/GPU/simulation runtime.

## Mobile Capability

Runtime-backed native intent:

- `scientific.remote_job_preflight`

The Swift intent evaluates:

- whether a task requires non-iOS scientific compute
- requested runtime class such as Python, MATLAB, R, Docker, GPU, notebook, large-file, Swift-native, or docs-only
- whether a bounded task can be converted to an AMA Swift host intent
- whether a trusted remote compute provider is configured
- whether artifacts would be uploaded
- whether upload was explicitly approved
- whether sensitive data needs review
- an explicit conversion plan, including MATLAB Coder build-time conversion guidance when the requested runtime is MATLAB
- `local_scripts_executed=false`

Reference parity:

```text
skills=84
mobile_non_skill_files=418
excluded_script_or_executable_files=0
```

Excluded behavior:

- no local Python, shell, R, MATLAB, Docker, notebooks, GPU, package-manager, model-training, simulation, or large-file execution on iOS
- no artifact upload without explicit user approval
- no remote compute claim unless `scientific.remote_job_preflight` returns `ready_for_remote_job`

Reference documents may contain inert code examples. They are installed as documentation only; executable source files and `scripts/` folders are not shipped in the AMA plugin.

## Product Tests

AMA package test:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter scientificRemoteJob
```

Result:

- Passed 1 Swift Testing test.
- Verified missing remote provider blocks an `rdkit` job.
- Verified blocked Python jobs return `execution_route=blocked_remote_compute` and `conversion.strategy=remote_compute`.
- Verified approved provider/upload marks a `scanpy` job ready.
- Verified sensitive data returns `needs_sensitive_data_review`.
- Verified a bounded MATLAB-compatible matrix task returns `ready_for_ios_native_intent`, `execution_route=ios_native`, `conversion.strategy=swift_host_intent`, and `build_time_conversion_available=true`.

AMASample local AMA package test:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificRemoteJob
```

Result:

- Passed 1 Swift Testing test after syncing `/Users/axient/repoAgent/AMA`.

2026-05-24 upstream drift update:

- Compared current upstream commit `66d1ad4` with local AMA plugin skills.
- Found two missing upstream skills: `bids` and `pacsomatic`.
- Added both to `plugins/scientific-compute-remote` as reference-only, remote-preflight skills.
- Excluded upstream executable files:
  - `bids/scripts/update_schema.py`
  - `pacsomatic/scripts/run_pacsomatic.py`
  - `pacsomatic/tests/test_run_pacsomatic.py`

AMASample iOS simulator test:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificComputeRemoteDerivedData
```

Result:

- Passed 25 Swift Testing tests.
- Added and verified `ama-skills-host-scientific-compute-remote`.
- The scenario verifies provider blocking, remote conversion planning, an approved remote job readiness path, and a MATLAB-to-Swift native conversion route.
- xcresult: `/tmp/AMASampleScientificComputeRemoteDerivedData/Logs/Test/Test-AMASampleService-2026.05.16_21-25-16-+0900.xcresult`

## Real Use Test

A temporary Swift package at `/tmp/ama-compute-remote-live` installed the real plugin from:

```text
/Users/axient/repoAgent/skillsPlugin/plugins/scientific-compute-remote
```

Observed result:

```text
compute_installation_id=io.axiomorient.ama.scientific.compute.remote
compute_skill_count=84
compute_selected_available=84
rdkit_loaded_ok=true
scanpy_loaded_ok=true
bids_loaded_ok=true
pacsomatic_loaded_ok=true
rdkit_status=blocked_requires_remote_provider
scanpy_status=ready_for_remote_job
matlab_native_status=ready_for_ios_native_intent
matlab_native_route=ios_native
matlab_native_intent=scientific.numeric_eval
local_scripts_executed=false
```

This proves the category plugin installs as one unit, all converted skills remain selectable/available on mobile, representative skills load through `load_skill`, and the instructions lead to the native `run_intent` preflight path.

Updated install proof for the current 84-skill pack:

```text
cd /tmp/ama-compute-remote-audit
swift run
```

Observed result:

```text
compute_installation_id=io.axiomorient.ama.scientific.compute.remote
compute_skill_count=84
compute_selected_available=84
bids_loaded_ok=true
pacsomatic_loaded_ok=true
local_scripts_executed=false
```

## Desktop Comparison

Desktop/source behavior:

- Upstream skills commonly describe direct Python package, CLI, notebook, GPU, simulation, model training, or local scientific data workflows.
- Some upstream skills include scripts or executable helper files.

AMA mobile behavior:

- The same non-script references are installed for explanation, parameter planning, and artifact expectations.
- iOS does not execute local scientific runtimes.
- The mobile-native equivalent is either a Swift host-intent conversion route for bounded operations or remote-job preflight for nonlocal work. The preflight reports provider readiness, upload approval, sensitive-data review, conversion strategy, requested runtime, and explicit no-local-script execution.

Quality judgment:

- Equivalent or better for mobile safety, bounded native substitution, and pre-execution routing.
- Not equivalent for actual computation until AMA has a trusted remote compute provider and job/artifact transport.
- This pack is product-safe as a planning/preflight layer, not as a compute engine.

## Static Checks

Script scan:

```text
find plugins/scientific-compute-remote -type f \
  \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -name '*.m' -o -name '*.r' -o -perm -111 \) -print
```

Result:

- Empty output.

Manifest validation:

```text
python3 -m json.tool plugins/scientific-compute-remote/ama-skill-plugin.json
```

Result:

- Passed.

## Release Confidence

Confidence for this category: medium.

Reason:

- Plugin install, all-skill availability, representative skill load, host intent execution, AMASample iOS simulator scenario, and script exclusion are verified.
- Confidence is not high because actual compute execution, remote provider integration, job queueing, artifact upload/download, and sensitive-data governance are intentionally out of scope for this mobile preflight slice.
