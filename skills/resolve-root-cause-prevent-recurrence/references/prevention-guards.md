# Prevention Guard Reference

Choose the guard closest to the root cause.

## Contract Or Schema Drift

- Add schema validation or manifest audit.
- Fail closed on stale hash, duplicate id, unknown path, invalid kind, or forbidden field.
- Verify with both the producer and consumer command.

## Evidence Or Release Gate Corruption

- Add a policy test that rejects the corrupted state before it enters release evidence.
- Keep failed evidence in history only if it is clearly marked failed and not listed as pass gate evidence.
- Verify with `gate check`, `release audit`, and the integrity command that validates artifact digests.

## Missing Generated Artifact

- Prefer regenerating the artifact from the source of truth.
- Add a sync test that proves generated copies reference the canonical source.
- Do not edit generated output by hand when a generator exists.

## Missing External Runtime

- Add a real wrapper or setup check that delegates to the actual runtime.
- The wrapper must return the runtime's real exit status.
- Audit should distinguish required runtime blockers from optional runtime warnings.

## UI Or Workflow Regression

- Add a scenario test for the user's workflow, not only component state.
- Include success, failure, permission, empty-state, and stale-data scenarios when relevant.
- Verify visible state comes from the same projection used by CLI/runtime.

## Flaky Or Environment-Sensitive Failure

- Remove hidden global state, timing assumptions, random ordering, and stale cache dependence.
- Add deterministic fixture setup and cleanup.
- Keep external service calls behind explicit readiness checks.

## Patch Acceptance Rule

A fix is durable only when:

- the original failure no longer reproduces;
- the new guard fails on the old bad state;
- broader verification still passes;
- any remaining gap is explicitly classified as blocker or non-blocking backlog.
