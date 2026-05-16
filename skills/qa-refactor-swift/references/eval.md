# Eval

## Scoring Standard
- Prefer behavior-preservation proof plus clarity/maintainability judgment over diff size or file count.
- Do not reward long reports unless they sharpen the pass/fail/inconclusive verdict.

## Trigger
- The skill should trigger only when there is a concrete completed Swift refactor slice to verify.

## Positive Task
- Prompt: Use `$qa-refactor-swift` on a completed Swift refactor slice in `/repo`: splitting `CredentialVault.inspectProvider` lane selection into a pure helper while preserving behavior. Do not edit files. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the skill verifies or marks inconclusive against the claimed completed slice, names the checked behavior, and points to the smallest missing proof only if the refactor is not observable.

## Non-Match Task
- Prompt: Use `$qa-refactor-swift` with no concrete refactor candidate, only a general wish to improve Swift code someday. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-refactor-target`.

## Accuracy Task
- Prompt: Use `$qa-refactor-swift` on `/repo` and keep the answer grounded in `CredentialVault.swift` plus contract and readiness tests.
- Expect: the answer distinguishes observable behavior proof from unobservable refactor structure and avoids claiming a passing refactor when the actual extracted helper is not present.
