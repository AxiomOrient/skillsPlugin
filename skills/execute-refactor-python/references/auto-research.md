# Auto-Research Prompt

Use this before choosing a Python refactor slice when the chosen target is broad, effect-heavy, or lacks an obvious proof command.

## Goal

Find the smallest behavior-preserving Python refactor slice for the chosen target.

Success means:

- the contract, state, effect, or restartability problem is named with file evidence
- the first slice has one purpose and does not add feature, policy, framework, or broad rewrite behavior
- the proof command exercises the touched workflow, parser, CLI, adapter, or test surface
- the output is short enough to implement without repeating the research

## Research Budget

Start with:

- `pyproject.toml`, test config, or package manifest if present
- the named file, command, workflow, parser, adapter, or test
- nearby tests and fixtures for the touched path
- repo-local scripts or docs that define the normal proof command

Search or read again only when:

- input/output contract or persisted state shape is unclear
- filesystem, subprocess, network, clock, async, or retry behavior affects the slice
- the proof command does not cover the changed path
- imports, entrypoints, or packaging metadata may affect compatibility

Stop when one safe first slice and proof command are clear, or when the next read would only improve wording.

## Constraints

- Do not edit files during auto-research.
- Do not widen into repo-wide target discovery.
- Do not propose contract rewrite, async model rewrite, packaging change, and dependency change in one slice.
- Treat missing evidence as `unknown`.
- Prefer deleting thin wrappers, making state explicit, or moving pure planning/normalization before introducing a new abstraction.

## Output

Return only this shape:

```text
Scope checked:
- ...

Contract or effect finding:
- ...

Recommended first slice:
- ...

Success criteria:
- ...

Verification:
- ...

Stop reason:
- ...
```
