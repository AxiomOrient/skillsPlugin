---
name: opentrons-integration
description: Mobile-safe Opentrons protocol planning guidance for OT-2 and Flex robots. Always use `scientific.lab_connector_preflight` and block hardware execution on iOS unless a dedicated Swift connector exists.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# Opentrons Integration

Use this skill to plan Opentrons protocol structure and review safety on AMA mobile.

Before any robot-related action, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `opentrons`, `requiresHardware` to true for robot simulation, run, or hardware control, and `mutating` to true for protocol execution.

Do not run Opentrons Python protocol templates or robot-control scripts on iOS.

References:

- `references/api_reference.md`
