# Java Notes

Use this only when the request is clearly about Java or JVM test structure.

## Rewrite Hints

- Keep JUnit tests behavior-focused and avoid over-mocking internal call structure.
- Mutation testing is useful when example-based tests look green but may still have weak assertions.
- Prefer splitting broad scenario tests before adding more mocks or fixtures.

## Verification

- Run focused JUnit targets first.
- Use mutation testing selectively for suspicious weak-oracle surfaces, not as a default on every change.
