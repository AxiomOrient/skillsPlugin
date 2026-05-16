# Auto-Research Prompt

Use this only when a completed Rust refactor is broad enough that the proof surface is unclear.

## Goal

Find the narrowest honest way to verify whether the completed refactor preserved behavior and contract.

Success means:

- the completed slice is identified from changed files or diff evidence
- the touched behavior and public contract are named
- the proof command actually exercises the touched path, or the missing proof is explicit
- the verdict can be pass, fail, or inconclusive without redesigning the refactor

## Research Budget

Start with:

- the changed files or diff
- target crate `Cargo.toml`
- nearby tests for the touched module
- repo-local proof docs or scripts if present

Search or read again only when:

- the changed path is not covered by visible tests
- public API compatibility is unclear
- over-splitting risk depends on module visibility, re-exports, fixtures, or feature gates
- a proof command is present but may not exercise the touched behavior

Stop when the verdict has enough evidence or when the missing proof is the blocker.

## Constraints

- Do not edit files.
- Do not redesign the refactor.
- Do not treat broad green commands as strong evidence if they do not touch the changed path.
- Treat missing proof as `inconclusive`, not pass.

## Output

Return only this shape:

```text
Slice checked:
- ...

Behavior checked:
- ...

Proof command:
- ...

Verdict:
- pass | fail | inconclusive

Evidence:
- path:line - reason

Missing proof:
- ...

Stop reason:
- ...
```
