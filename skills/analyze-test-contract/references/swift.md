# Swift Notes

Use this only when the request is clearly about Swift or Swift Testing.

## Surface Hints

- Prefer `import Testing` idioms already used by the repo.
- Use `#require` when the rest of the test depends on a non-optional setup artifact.
- Use `#expect` for direct behavior assertions; avoid burying important checks in helper functions.

## Rewrite Hints

- Prefer parameterized `@Test(arguments:)` when one behavior contract repeats over examples.
- Split broad tests that currently mix ranking, snippet, persistence, and query-grounding contracts.
- For public compatibility checks, avoid `@testable import` unless the contract is explicitly internal.
- For actor, cancellation, or timeout surfaces, prove ownership and visible behavior rather than implementation timing.
- For boundary or repository-layout tests, compare the test contract with the backing script or manifest before changing assertions.
- If a SwiftPM repo already has authoritative scripts such as boundary checks or `verify-all.sh`, treat those as the proof contract and audit whether the test is duplicating proof or intentionally pinning the rule closer to source.

## Verification

- Start with focused `swift test --filter ...`
- Widen to `swift test` when shared package infrastructure or public contracts are involved.
- Use repository scripts first when the test is asserting repository structure rather than Swift behavior.
