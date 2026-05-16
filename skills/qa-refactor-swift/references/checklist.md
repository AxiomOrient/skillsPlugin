# Swift Refactor Checklist

Use this checklist after each bounded refactor pass.

## Scope

- Is Goal / Non-goals / Done when / Verification explicit?
- Is external behavior preservation stated?
- Is this one bounded purpose rather than a mixed rewrite?
- Is this slice small enough to verify in one pass?

## Value And Ownership

- Did the change move domain state toward `struct` or `enum` where identity is not required?
- Are bool or string flag soups replaced by clearer state representations where practical?
- Is `class` still justified where it remains?

## Actor And Sendable Boundaries

- Is shared mutable state isolated behind an `actor` where needed?
- Did the change avoid actor-izing code that should stay value-based or pure?
- Are `Sendable` boundaries clearer after the change?
- Did the change avoid papering over design issues with `@unchecked Sendable` or unsafe opt-outs?
- Did the change avoid using `@MainActor` as a generic concurrency escape hatch outside UI or presentation boundaries?

## Surface Classification

- Did you identify whether the changed surface is mainly parser, CLI, state machine, actor-backed store, I/O boundary, or structured concurrency logic?
- Did the chosen slice match that dominant surface instead of applying a generic rewrite pattern?
- Did the refactor avoid splitting a cohesive reducer, actor-backed store, command, parser, or adapter when locality is the clearer design?

## Parsers, CLI, And State Machines

- If parser code moved, are decode, validate, and apply boundaries clearer?
- If the CLI surface changed, did parsing or command selection get cleaner without changing UX by accident?
- If a lifecycle or state machine changed, are states and transitions more explicit than before?

## I/O And Protocol Boundaries

- Are filesystem, process, network, model backend, or persistence edges more explicit after the change?
- Are protocols used at seams rather than everywhere?
- Did the hot path avoid unnecessary existential or wrapper churn?
- If a file, target, or module was split, did the split reduce coupling more than it added access-control changes, target graph churn, fixtures, or navigation cost?

## Verification

- Did you run `swift test`?
- Did you run `swift build`?
- If parser behavior changed, did you cover malformed input?
- If CLI behavior changed, did you keep at least one command or smoke path green?
- If actor or Sendable behavior changed, did you keep isolation-focused tests green?
- If package structure changed, did `Package.swift` still build the intended surfaces?
- If tests failed, did you classify whether the failure was a product regression, a test bug, or both before changing the proof?
- If compatibility behavior is public, is it tested through the public surface instead of internal helpers?

## Stop Or Repeat

- Is the next slice still one purpose?
- Did this slice make value ownership/actor isolation more obvious, or intentionally preserve useful cohesion?
- Is the remaining work real structure rather than stylistic churn?
- Should the next pass stop because the remaining surface is intentionally centralized?
