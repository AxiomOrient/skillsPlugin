# Go Refactor Checklist

Use this checklist after each bounded refactor pass.

## Scope

- Is Goal / Non-goals / Done when / Verification explicit?
- Is external behavior preservation stated?
- Is this one bounded purpose rather than a mixed rewrite?
- Is this slice small enough to verify in one pass?

## Package Shape

- Did the change clarify package responsibility before moving helpers?
- Did it avoid catch-all packages such as `util`, `common`, `helper`, or `model`?
- Does each touched file have one dominant responsibility?
- If a giant file or package stayed, is the reason structural rather than accidental?
- If a file/package was split, did the split reduce coupling more than it added imports, exported names, test setup, or dependency edges?
- Did the pass consider in-place cleanup before adding files or packages?

## Surface Classification

- Did you identify whether the changed surface is mainly pure logic, parser, CLI, state machine, or I/O boundary code?
- Did the chosen slice match that dominant surface instead of applying a generic rewrite pattern?

## Interfaces

- Are interfaces defined on the consumer side where practical?
- Did the change remove a producer-owned interface that only mirrored one implementation?
- Are interfaces small and behavior-specific?
- Are concrete types still returned when they are the real API?

## Errors

- Is the happy path visually straight with early error returns?
- Are boundary crossings wrapped with `%w` when context matters?
- Can callers classify errors with `errors.Is` or `errors.As` where needed?
- Did the change avoid hiding control flow in a custom error abstraction?

## Context

- Is `context.Context` the first parameter on request-scoped or I/O-bound paths?
- Did the change avoid storing `context.Context` in a struct?
- Is context only carrying cancellation, deadlines, or request-scoped values?
- Were explicit parameters used instead of context when the data is real business input?

## Pure Logic And Parsing

- Did the change extract pure parsing, validation, normalization, or calculation only where it makes the boundary clearer?
- If parser code moved, are decode and apply-time effects now easier to distinguish?
- Are malformed-input paths still explicit and testable?

## CLI And State Machines

- If the slice touched a CLI surface, are command parsing, selection, and execution responsibilities easier to identify, whether colocated or split?
- If the slice touched lifecycle logic, are named states or explicit transitions clearer than before?
- Did the change avoid splitting an intentionally centralized transition table for cosmetic reasons?

## I/O Boundaries

- Are filesystem, process, network, clock, or provider edges more explicit after the change?
- Did the refactor move planning or normalization inward while keeping side effects at the edge?
- Did the change avoid introducing a broad boundary abstraction where a narrow concrete dependency was enough?

## Concurrency

- Does every new or touched goroutine have a clear owner and shutdown condition?
- Are channels used for coordination or ownership transfer rather than as vague event buses?
- Are mutexes used where shared mutable state is the real problem?
- Did the refactor make lifecycle and cleanup easier to explain?

## Verification

- Did you run `go test ./...`?
- If the changed surface has multiple variants, did you use table-driven tests with subtests where that makes the contract clearer?
- If concurrency changed, did you run `go test -race ./...`?
- If parsing, protocol, or serialization changed, did you consider fuzz coverage?
- If the CLI surface changed, did you keep at least one command or smoke path green?
- If a lifecycle or state transition surface changed, did you keep transition-level tests green?
- If performance was claimed, did you benchmark before reaching for `pprof`?
- If dependencies or imports changed, did you confirm `go.mod` and `go.sum` stay correct after `go mod tidy`?

## Stop Or Repeat

- Is the next slice still one purpose?
- Did this slice make package/runtime boundaries more obvious, or intentionally preserve useful cohesion?
- Is the remaining work real structure rather than stylistic churn?
- Should the next pass stop because the remaining file or package is intentionally centralized?
