# Test Contract Audit Checklist

Use this checklist after each bounded test-audit pass.

## Contract

- Does the test prove an externally observable behavior?
- Can the intended contract be stated in one sentence?
- Is the test proving one contract rather than several?

## Oracle

- Is the pass/fail oracle strong enough?
- Is the test checking a real result instead of only non-empty output or generic truthiness?
- Does the test include the most useful negative or malformed-input case when the surface needs one?

## Coupling

- Would a harmless refactor break the test even if behavior stayed correct?
- Is the test using internal helpers when it should use a public surface?
- Is hidden business logic, branching, or looping living inside the test?

## Scope And Isolation

- Is the test at the right size: unit, integration, e2e, contract, parity, or concurrency?
- Is setup explicit and hermetic?
- Does the test avoid shared mutable state, timing luck, network dependency, and order dependence?

## Rewrite Choice

- Should this test be split?
- Should this test be parameterized?
- Should this oracle be strengthened?
- Should the code change instead of the test?
- Would property-based or mutation testing add real value here?

## Safety

- Are you preserving a true regression detector instead of weakening it?
- Did you explicitly classify the failure as product bug, test bug, both, or insufficient evidence?
