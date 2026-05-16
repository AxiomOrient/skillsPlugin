# Eval

## Trigger
- The skill should trigger when the main job is a bounded, behavior-preserving simplification pass rather than feature work, debugging, or architecture redesign.

## Positive Tasks
- Prompt: Use `$simplify` on `/repo/src/backends/user_defaults_backend.swift` to reduce small duplication, weak comments, and repeated codec construction without changing behavior.
- Expect: one bounded slice chosen from reuse, quality, or efficiency; concrete verification; deferred items called out instead of batching.

- Prompt: Use `$simplify` on `/repo/runtime/cache.py` to remove a check-then-delete TOCTOU pattern and simplify one empty except block.
- Expect: direct operation plus honest error handling, not an architecture rewrite.

- Prompt: Use `$simplify` on `/repo/adapter/json_loader.go` to centralize repeated compatibility decode conversion and remove stale "bug fix" comments.
- Expect: language-agnostic handling of decoder reuse and compatibility conversion.

## Boundary Guard
- Prompt: Use `$simplify` on `/repo` and clean up everything duplicated.
- Expect: the skill narrows to one bounded scope or asks for a bounded scope; it must not attempt repo-wide sweep implementation in one pass.

- Prompt: Use `$simplify` with subagents on `/repo` to find reuse, quality, and efficiency simplifications.
- Expect: the skill creates one shared scope manifest, uses read-only reviewer agents for candidate discovery only, dedupes their findings, chooses one slice in the main flow, and defers the rest.

- Prompt: Use `$simplify` on a large SwiftPM package and find the smallest proofable simplification.
- Expect: the skill maps changed files through `Package.swift` target/testTarget entries before choosing proof, excludes vendor/resources/generated outputs by default, and does not rewrite JSON codec usage when key strategy or byte output might change.

## Non-Match Tasks
- Prompt: Use `$simplify` to redesign the module layout of `/repo/runtime`.
- Expect: redirect to `analyze-architecture-integrity` or `execute-architecture-realignment`.

- Prompt: Use `$simplify` to figure out why `/repo/src/server.py` is failing in production.
- Expect: redirect to `analyze-root-cause`.

## Current Repo Validation
- Prompt: Use `$simplify` on `SwiftVault` and find the smallest worthwhile simplification candidate after the recent refactors.
- Expect: the skill should consider at least reuse, quality, and efficiency separately; good candidates include repeated codec construction, repeated compat conversion, log/behavior mismatch, and TOCTOU patterns. It should choose one slice only.
