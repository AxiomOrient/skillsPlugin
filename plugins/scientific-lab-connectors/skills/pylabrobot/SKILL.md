---
name: pylabrobot
description: Mobile-safe PyLabRobot planning guidance for vendor-agnostic lab automation. Always use `scientific.lab_connector_preflight` and block hardware execution on iOS unless a dedicated Swift connector exists.
license: MIT license
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# PyLabRobot

Use this skill to plan vendor-agnostic lab automation workflows on AMA mobile.

Before any equipment-related action, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `pylabrobot`, `requiresHardware` to true for device interaction, and `mutating` to true for any control operation.

Do not run PyLabRobot Python code, visualization servers, simulations, or hardware backends on iOS.

References:

- `references/liquid-handling.md`
- `references/resources.md`
- `references/hardware-backends.md`
- `references/analytical-equipment.md`
- `references/material-handling.md`
- `references/visualization.md`
