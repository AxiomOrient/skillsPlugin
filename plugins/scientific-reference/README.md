# Scientific Reference

AMA-native scientific reference skill pack converted from the K-Dense scientific agent skills catalog.

This pack is intentionally documentation-only on iOS:

- no Python, shell, PowerShell, batch, Node, MATLAB, or desktop daemon files
- no local script execution
- original reference documents are included where they are plain documentation
- original script-backed figure-generation instructions are replaced with mobile-safe artifact requests

## Skills

- `scientific-brainstorming`: structure early-stage research ideation and gap discovery.
- `scientific-critical-thinking`: evaluate evidence quality, design validity, bias, and statistical risk.
- `peer-review`: produce formal manuscript or grant reviews using structured criteria.
- `scientific-writing`: draft and revise scientific prose using IMRAD, reporting guidelines, and citation discipline.
- `what-if-oracle`: explore uncertainty with multi-branch scenario analysis.

## Mobile Boundary

These skills can be installed and loaded as AMA plugin skills. They do not provide local executable scripts. When a user needs a figure, document, or citation artifact, the skill must route to an AMA-native host intent or ask for an explicit artifact capability rather than describing desktop commands.

Source: `K-Dense-AI/scientific-agent-skills`, MIT license. See `LICENSE.md`.
