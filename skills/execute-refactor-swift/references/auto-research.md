# Auto-Research Prompt

Use this before choosing a Swift refactor slice when the chosen target is broad, concurrency-sensitive, or lacks an obvious proof command.

## Goal

Find the smallest behavior-preserving Swift refactor slice for the chosen target.

Success means:

- the value, actor isolation, Sendable, lifecycle, parser, or I/O boundary problem is named with file evidence
- the first slice has one purpose and does not add feature, policy, API redesign, or broad concurrency migration behavior
- the proof command exercises the touched target, test target, command path, or app surface
- the output is short enough to implement without repeating the research

## Research Budget

Start with:

- `Package.swift`, `.xcodeproj`, `.xcworkspace`, or target manifest
- the named file, type, actor, reducer, command, parser, or adapter
- nearby tests and target mappings
- repo-local build/test docs or XcodeBuildMCP config if present

Search or read again only when:

- value ownership, reference sharing, actor isolation, or Sendable boundary is unclear
- filesystem, process, network, persistence, UI lifecycle, or model backend behavior affects the slice
- the proof command does not cover the changed target
- public API, module graph, or target membership may affect compatibility

Stop when one safe first slice and proof command are clear, or when the next read would only improve wording.

## Constraints

- Do not edit files during auto-research.
- Do not widen into repo-wide target discovery.
- Do not propose module split, API redesign, unsafe annotation sweep, and concurrency model rewrite in one slice.
- Treat missing evidence as `unknown`.
- Prefer value-state cleanup or in-place cohesion cleanup when splitting would add access-control, target, fixture, or import cost without stronger invariants.

## Output

Return only this shape:

```text
Scope checked:
- ...

Boundary finding:
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
