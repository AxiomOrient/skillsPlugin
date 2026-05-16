# Test Contract Auto-Research

Use this only when the requested test-contract audit is repo-wide, ambiguous, or likely to crowd the main context. Skip it when the user already named one test file, one failing test, or one proof command.

## Goal

Choose one test-contract audit target with enough evidence to judge whether the test proves the right behavior.

Success means:

- the target is one test file, one test case, or one narrow test helper boundary
- the intended behavior contract is named or marked `unknown`
- the weakness candidate has file and line evidence
- the proof command or missing proof is concrete
- the output is short enough for the main agent to audit without repeating the search

## Research Budget

Start with:

- the user request and any named file, failure, command, or changed behavior
- nearby test files, fixtures, and helper code directly used by the named surface
- package scripts, CI commands, or manifests that show the narrow proof command
- source code only when the test contract cannot be understood from the test itself

Read more only when:

- the intended behavior is unclear
- the test may be proving an implementation detail instead of public behavior
- the same helper is shared by multiple tests and may make one-file proof misleading
- the proof command is missing or does not exercise the chosen test

Stop when one audit target, one contract statement, and one proof surface are clear, or when the missing contract must be clarified by the user.

## Constraints

- Do not edit files during auto-research.
- Do not turn a test-contract audit into feature implementation, broad QA, coverage chasing, or style cleanup.
- Do not inspect generated, vendor, build output, dependency cache, or snapshot bodies unless the named test contract depends on that artifact.
- Treat unclear product behavior as `unknown`; do not invent the contract from test names alone.
- Prefer the smallest visible weak oracle, broad test, flaky dependency, hidden test logic, or implementation-coupled assertion with direct evidence.

## Output

Return only this shape:

```text
Scope checked:
- ...

Audit target:
- file-or-test: ...
- contract: ...
- weakness candidate: ...
- evidence: path:line
- proof: command-or-missing-proof

Recommended first audit:
- ...

Stop reason:
- ...
```

If no honest target is available, return:

```text
Scope checked:
- ...

Audit target:
- none

Recommended first audit:
- none

Stop reason:
- no bounded test contract had enough evidence
```
