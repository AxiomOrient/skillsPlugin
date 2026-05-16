---
name: goal-refactor-swift
description: "Use when the user wants /goal-guided, iterative Swift refactoring or project cleanup: split real large objects only when it improves ownership, apply simplify-style reuse/quality/efficiency lenses, preserve behavior, verify each slice, and stop before overengineering or stylistic churn."
---

# Goal Refactor Swift

## Purpose

Run a long-lived `/goal` refactor loop for Swift repositories. Improve structure iteratively without changing behavior, over-splitting cohesive files, or adding abstraction for appearances.

## Start

If the user asked for `/goal`, create or update the active goal when the goal tool is available. If an existing completed goal blocks creation or the tool is unavailable, continue from a short written objective instead of stopping.

Read only enough evidence to choose the first honest slice:

- `Package.swift`, Xcode project, or manifest
- repo docs that define architecture or tests
- current `git status --short`
- largest Swift files by line count
- tests covering the touched target

When the scope is broad, read `references/goal-loop-prompt.md` for the loop prompt and candidate schema.

## Slice Contract

Before each edit, state:

- Goal
- Non-goals
- Done when
- Verification

Do not edit until this is clear.

## Candidate Lenses

Use these lenses together, but choose exactly one slice per pass.

### Swift Refactor Lens

- Value first: replace parameter soup or implicit state with small structs/enums when it clarifies ownership.
- Isolation first: keep shared mutable state behind actors only when real sharing exists; do not actor-ize pure values.
- Boundary first: separate parser, reducer, I/O, public facade, and variable-layout surfaces only when the boundary is real.

### Simplify Lens

- Reuse: duplicated conversion, parser, mapper, cache-key, or formatter logic.
- Quality: stale comments, weak wrappers, misleading names/messages, unnecessary visibility.
- Efficiency: avoidable common-path branches, repeated construction where safe, time-of-check/time-of-use patterns.

### Large Object Lens

A file or type is not a problem by size alone. Split only when at least one is true:

- separate public or user-facing surface
- separate state ownership or lifecycle
- separate effect/I/O adapter
- independently testable policy, reducer, or parser
- different change cadence
- repeated navigation hides invariants

Keep code together when locality makes the hot path, parser, reducer, or line-breaking policy easier to audit.

## Execution Loop

1. Inventory candidates with file and line evidence.
2. Choose the highest-leverage low-risk slice with a concrete proof.
3. Prefer deletion, merge, inline, small value extraction, or local helper reuse over new protocols.
4. Apply one focused patch.
5. Run the narrowest honest proof first.
6. Run the broader package proof when the touched surface is shared.
7. Re-evaluate. Continue only if the next slice is real structure, not style churn.

## Verification Defaults

For SwiftPM:

- focused: `swift test --filter RelevantTests`
- full: `swift test`
- build: `swift build`

For sample projects, run the smallest sample smoke test that imports the package.

If sandbox or tooling blocks verification, request approval. If still blocked, report the work as unverified.

## Stop Rules

Stop when:

- the next change would alter behavior, policy, or public API
- the remaining candidates are mostly line-count or style churn
- splitting would add access-control or navigation cost without stronger invariants
- proof is weaker than the refactor risk
- a broader architecture decision is required

## Final Response

Keep it short:

- slices changed
- verification commands and result
- deferred candidates and why
- whether the goal should continue later
