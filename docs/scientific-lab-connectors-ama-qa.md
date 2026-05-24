# Scientific Lab Connectors AMA QA

Date: 2026-05-16

## Scope

This document records the sixth AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-lab-connectors`

Converted skills:

- `benchling-integration`
- `labarchive-integration`
- `protocolsio-integration`
- `omero-integration`
- `dnanexus-integration`
- `ginkgo-cloud-lab`
- `lamindb`
- `latchbio-integration`
- `open-notebook`
- `opentrons-integration`
- `pylabrobot`

The conversion target is iOS AMA. This category is intentionally a mobile preflight and planning layer, not a desktop SDK runner or hardware controller.

## Mobile Capability

Runtime-backed native intent:

- `scientific.lab_connector_preflight`

The Swift intent evaluates:

- connector support
- credential readiness
- read-only vs mutating operation
- explicit user approval for mutating operations
- hardware, robot, instrument, or cloud-lab execution blocking
- `local_scripts_executed=false`

Reference parity:

```text
benchling-integration source_non_script=3 mobile_non_skill=3
labarchive-integration source_non_script=3 mobile_non_skill=3
protocolsio-integration source_non_script=6 mobile_non_skill=6
omero-integration source_non_script=8 mobile_non_skill=8
dnanexus-integration source_non_script=5 mobile_non_skill=5
ginkgo-cloud-lab source_non_script=3 mobile_non_skill=3
lamindb source_non_script=6 mobile_non_skill=6
latchbio-integration source_non_script=4 mobile_non_skill=4
open-notebook source_non_script=4 mobile_non_skill=4
opentrons-integration source_non_script=1 mobile_non_skill=1
pylabrobot source_non_script=6 mobile_non_skill=6
```

Excluded upstream scripts:

- `labarchive-integration/scripts/*.py`
- `open-notebook/scripts/*.py`
- `opentrons-integration/scripts/*.py`

Excluded behavior:

- no Python, shell, PowerShell, batch, Node, SDK, CLI, robot, notebook server, cloud-lab, or instrument execution on iOS
- no API mutation without explicit user approval
- no hardware or remote lab execution without a future dedicated Swift connector with audit logging and operator confirmation

## Product Tests

AMA package test:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter scientificLabConnector
```

Result:

- Passed 1 Swift Testing test.
- Verified Opentrons hardware/mutating/no-credential request returns `blocked_hardware_or_remote_execution`.
- Verified Benchling read-only/credential-ready request returns `ready_read_only`.

AMASample local AMA package test:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificLabConnector
```

Result:

- Passed 1 Swift Testing test after syncing `/Users/axient/repoAgent/AMA`.

AMASample iOS simulator test:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificLabConnectorsDerivedData
```

Result:

- Passed 25 Swift Testing tests.
- Added and verified `ama-skills-host-scientific-lab-connectors`.
- The scenario runs the lab connector preflight for Opentrons and Benchling and checks hardware blocking, read-only readiness, and no local script execution.
- xcresult: `/tmp/AMASampleScientificLabConnectorsDerivedData/Logs/Test/Test-AMASampleService-2026.05.16_21-15-25-+0900.xcresult`

## Real Use Test

A temporary Swift package at `/tmp/ama-lab-connectors-live` installed the real plugin from:

```text
/Users/axient/repoAgent/skillsPlugin/plugins/scientific-lab-connectors
```

Observed result:

```text
lab_installation_id=io.axiomorient.ama.scientific.lab.connectors
lab_skill_count=11
lab_selected_available=11
opentrons_loaded_ok=true
benchling_loaded_ok=true
opentrons_status=blocked_hardware_or_remote_execution
benchling_status=ready_read_only
local_scripts_executed=false
```

This proves the category plugin installs as one unit, individual skills load through `load_skill`, and the skill instructions lead to the native `run_intent` preflight path.

## Desktop Comparison

Desktop/source behavior:

- Upstream connector skills describe direct SaaS API, SDK, notebook, robot, instrument, or cloud-lab workflows.
- Some upstream skills include Python scripts for desktop or server environments.

AMA mobile behavior:

- The same reference material is available for planning and user-facing explanation.
- The iOS runtime does not execute upstream scripts, SDKs, CLIs, notebook servers, or lab hardware.
- The mobile-native equivalent is the preflight decision: credentials, user approval, mutating action classification, and hardware/cloud-lab blocking.

Quality judgment:

- Equivalent or better for mobile safety, auditability, and pre-action gating.
- Not equivalent for actual external API execution, data sync, robot control, protocol execution, or notebook server operations. Those require dedicated Swift connectors, credential storage, network clients, audit logs, and operator confirmation.
- Release confidence is intentionally lower than document/literature packs because no real SaaS credentials or hardware devices were used in verification.

## Static Checks

Script scan:

```text
find plugins/scientific-lab-connectors -type f \
  \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -perm +111 \) -print
```

Result:

- Empty output.

Manifest validation:

```text
python3 -m json.tool plugins/scientific-lab-connectors/ama-skill-plugin.json
```

Result:

- Passed.

## Release Confidence

Confidence for this category: medium.

Reason:

- Plugin install, skill load, host intent execution, AMASample iOS simulator scenario, and script exclusion are verified.
- Confidence is not high because real SaaS credentials, external API calls, notebook servers, cloud-lab systems, and physical lab hardware are intentionally out of scope for this mobile preflight slice.
