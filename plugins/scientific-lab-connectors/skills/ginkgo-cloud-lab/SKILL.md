---
name: ginkgo-cloud-lab
description: Mobile-safe Ginkgo Cloud Lab guidance for protocol selection, input preparation, pricing, and ordering review. Always use `scientific.lab_connector_preflight` before cloud-lab actions.
license: Unknown
metadata:
  skill-author: K-Dense Inc.
  ama-conversion: AxiomOrient
  mobile-runtime: swift-host-intent-preflight
---

# Ginkgo Cloud Lab

Use this skill to plan Ginkgo Cloud Lab protocol selection and input preparation on AMA mobile.

Before any external call or order-related action, call `run_intent` with `scientific.lab_connector_preflight`.

Set `connector` to `ginkgo-cloud-lab`. Any order, quote, sample submission, or custom protocol request is mutating and requires approval. Set `requiresHardware` true for cloud-lab execution.

References:

- `references/cell-free-protein-expression-validation.md`
- `references/cell-free-protein-expression-optimization.md`
- `references/fluorescent-pixel-art-generation.md`
