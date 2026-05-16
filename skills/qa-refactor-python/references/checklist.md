# Python Refactor Checklist

Use this checklist after each bounded refactor pass.

## Scope

- Is Goal / Non-goals / Done when / Verification explicit?
- Is external behavior preservation stated?
- Is this one bounded purpose rather than a mixed rewrite?
- Is this slice small enough to verify in one pass?

## Contract Shape

- Did the change replace implicit payloads with `TypedDict`, `dataclass`, or `Protocol` where appropriate?
- Does core decision logic avoid `dict[str, Any]` once the boundary is known?
- Are internal state, commands, and results explicit enough to understand without reading adapters?

## Surface Classification

- Did you identify whether the changed surface is mainly pure logic, parser, CLI, workflow orchestration, async lifecycle, or I/O boundary code?
- Did the chosen slice match that dominant surface instead of applying a generic rewrite pattern?
- Did the refactor avoid splitting a cohesive workflow, parser, command, or adapter when locality is the clearer design?

## Pure Core And Effects

- Did the change move planning, normalization, validation, or verification inward?
- Are filesystem, subprocess, network, database, or LLM effects kept in thin adapters or apply-time shells?
- Did the refactor avoid fake purity where the code is inherently effectful?

## State And Workflow

- Is workflow state explicit rather than scattered across globals or mutable fields?
- Are `plan`, `apply`, and `verify` easier to distinguish after the change?
- If workflow code stayed together, is that because failure handling and execution order are easier to follow locally?
- If checkpoints exist, are they serializable and restart-safe?

## Parsers, CLI, And Async

- If parser code moved, are tokenize / parse / validate / apply boundaries clearer?
- If the CLI surface changed, did parsing or command selection get cleaner without changing UX by accident?
- If async or background logic changed, does every task still have visible ownership and cancellation?

## Errors And Logging

- Are failure classes clearer after the refactor?
- Did the change avoid broad catch-and-continue behavior?
- Are retries and timeouts still explicit at the boundary?
- Are logs still structured enough to trace `run_id`, `task_id`, `step`, or equivalent execution fields?

## Verification

- Did you run `python -m pytest`?
- If the changed surface has multiple variants, did you use table-driven tests, subtests, or parametrization where that makes the contract clearer?
- If parser behavior changed, did you cover malformed input?
- If CLI behavior changed, did you keep at least one command or smoke path green?
- If async or background behavior changed, did you keep lifecycle or cancellation tests green?
- If packaging or imports changed, did you confirm `pyproject.toml` and entrypoints still line up?

## Stop Or Repeat

- Is the next slice still one purpose?
- Did this slice make contracts/effect boundaries more obvious, or intentionally preserve useful cohesion?
- Is the remaining work real structure rather than stylistic churn?
- Should the next pass stop because the remaining file or workflow is intentionally centralized?
