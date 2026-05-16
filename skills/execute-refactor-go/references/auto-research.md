# Auto-Research Prompt

Use this before choosing a Go refactor slice when the chosen target is broad, mixed with runtime behavior, or lacks an obvious proof command.

## Goal

Find the smallest behavior-preserving Go refactor slice for the chosen target.

Success means:

- the package, runtime, or I/O boundary problem is named with file evidence
- the first slice has one purpose and does not add feature or policy behavior
- the proof command exercises the touched package or command path
- the output is short enough to implement without repeating the research

## Research Budget

Start with:

- `go.mod` and relevant package directories
- the named file, package, command, handler, parser, or adapter
- nearby tests for the touched package
- repo-local scripts or docs that define the normal proof command

Search or read again only when:

- package ownership or caller-visible behavior is unclear
- error, context, goroutine, or I/O lifetime affects the slice
- the proof command does not cover the changed path
- an interface, public symbol, or module boundary may affect compatibility

Stop when one safe first slice and proof command are clear, or when the next read would only improve wording.

## Constraints

- Do not edit files during auto-research.
- Do not widen into repo-wide target discovery.
- Do not propose package split, API change, dependency change, and concurrency rewrite in one slice.
- Treat missing evidence as `unknown`.
- Prefer in-place cohesion cleanup when a new package would add import churn or weaker local reasoning without a clearer responsibility boundary.

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
