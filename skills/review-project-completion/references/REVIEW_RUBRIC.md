# Review Rubric

## Evidence Discipline

- Ground every conclusion in artifacts that were actually read.
- Cite both sides when documents and code conflict.
- Treat missing implementation for an in-scope requirement as `미완성`.
- Treat core functionality with missing or weak tests as `검증 불충분`.
- Separate "demo works once" from "operationally complete".
- Surface hardcoding, manual patch-ups, brittle setup, and operator-only recovery steps.
- Mark ambiguous areas as `근거 부족` instead of guessing.

## Artifact Inventory

Collect and classify evidence from these sources when available:

- project overview
- goal or problem statement
- requirements or PRD
- spec
- design
- plan or task tracking docs
- source code
- test code
- README, deployment, and runbook material
- other attached materials that define scope or runtime behavior

If an expected source is missing, record the missing artifact and the review area affected by the gap.

## Review Dimensions

### A. Goal and Scope Closure

Check:

- whether the original goal is explicit
- whether in-scope and out-of-scope are defined
- whether the current implementation covers the defined in-scope work
- whether the project dropped required scope or accumulated unapproved scope

Evidence to prefer:

- goal docs
- requirement docs
- spec boundaries
- task lists
- implemented feature set

### B. Document Consistency

Check:

- whether PRD, spec, plan, tasks, README, and code agree
- whether terms and entities are named consistently
- whether input, output, state, and error models stay consistent
- which items exist in docs but not code
- which items exist in code but not docs

Always separate:

- `문서에는 있으나 코드에는 없는 항목`
- `코드에는 있으나 문서에는 없는 항목`

### C. Architectural Integrity

Check:

- whether module boundaries are clear
- whether responsibilities are appropriately separated
- whether interfaces and implementations are separated
- whether data flow and control flow remain explainable
- whether technical debt is already breaking the intended structure

Call out:

- cross-layer leakage
- circular coupling
- feature logic hidden in the wrong layer
- configuration or state models that undermine maintainability

### D. Functional Completeness

For each core feature or user flow, record:

- feature name
- requirement evidence
- implementation evidence
- test evidence
- exception or failure-handling evidence
- status: `완료 | 부분 완료 | 미완성 | 불명확 | 검증 불충분`

Evaluate the end-to-end closure of the main user flows, not only isolated functions.

### E. Error and Failure Handling

Check:

- whether an error-handling policy exists
- whether input validation is sufficient
- whether recovery or fallback behavior exists
- whether logging, tracing, or observability exists
- whether timeout, retry, idempotency, and rollback concerns are handled where needed

Call out the exact missing safeguard and the failure mode it leaves exposed.

### F. Test Completeness

Inspect:

- unit tests
- integration tests
- end-to-end tests
- regression tests
- failure-case tests
- boundary-value tests

Do not stop at counting tests.
Judge whether the tests actually cover the project's meaningful risks and core flows.

### G. Operational Completeness

Check:

- whether the project can be installed and started
- whether environment setup is documented
- whether secrets and environment variables are defined
- whether local, staging, and production execution modes are described when relevant
- whether deploy and rollback procedures exist
- whether minimum incident-response docs exist

Operational completeness is not satisfied by a happy-path README alone.

### H. Unresolved Risk, Missing Work, and Blockers

Must surface:

- unimplemented core features
- document-to-code mismatches
- launch-critical operational hazards
- manual dependencies that create fragility
- testing gaps
- performance, security, or data-integrity risks
- structural constraints that will block future extension

Only list an item as a blocker if it genuinely prevents calling the project complete.

## Verdict Semantics

- `완성됨`
  - Use only when in-scope functionality is implemented, coherently documented, sufficiently tested, operationally supportable, and free of unresolved completion-blocking risk.
- `거의 완성됨`
  - Use when the project is materially closed and the remaining gaps are small, bounded, and non-blocking.
- `부분 완성`
  - Use when meaningful in-scope work, verification, or operational closure is still missing.
- `미완성`
  - Use when the scope is not actually delivered, the evidence is seriously incomplete, or blockers prevent calling the project complete.

Never use `완성됨` when a core requirement, core test expectation, or operational blocker remains open.

## Scoring Guidance

Use a 0-5 scale per category:

- `0`: absent, unreadable, or directly contradicted
- `1`: mostly missing; only fragmentary evidence exists
- `2`: partially present but materially incomplete
- `3`: broadly present with notable gaps or unresolved inconsistencies
- `4`: strong and mostly closed; only minor bounded issues remain
- `5`: fully evidenced, internally consistent, and operationally credible

## Requirement Traceability Rules

For each tracked requirement:

- cite the document source that defines it
- cite the code evidence that implements it, or record the absence
- cite the test evidence that verifies it, or record the absence
- assign a status grounded in the actual evidence
- add a note when the requirement is ambiguous, split across multiple sources, or blocked by missing docs

## Prioritization Rules for Missing Items

Order missing items by practical severity:

1. blockers to completion or release
2. unimplemented core scope
3. document-to-code contradictions
4. operational hazards
5. meaningful testing gaps
6. architectural degradation with near-term impact
7. lower-severity cleanup or completeness gaps

## Reporting Rules

- Keep the tone clinical and evidence-based.
- Do not pad the report with praise.
- Do not hide uncertainty.
- Use exact file paths, modules, tests, and document names when possible.
- If the review area is ambiguous, narrow the boundary before continuing.
