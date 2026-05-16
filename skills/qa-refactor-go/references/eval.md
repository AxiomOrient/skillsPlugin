# Eval

## Scoring Standard
- Prefer behavior-preservation proof plus clarity/maintainability judgment over diff size or file count.
- Do not reward long reports unless they sharpen the pass/fail/inconclusive verdict.

## Trigger
- The skill should trigger only when a concrete completed Go refactor slice is available to verify.

## Positive Task
- Prompt: Use `$qa-refactor-go` on a completed Go refactor slice in `/repo/cli_governance.go`: extracting one pure request-building helper from `runTrial`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the skill verifies or marks inconclusive against the claimed completed slice and names the smallest missing proof only when verification is inconclusive.

## Non-Match Task
- Prompt: Use `$qa-refactor-go` with no concrete refactor candidate, only a general wish to improve Go code. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-refactor-target`.

## Accuracy Task
- Prompt: Use `$qa-refactor-go` on `/repo` and keep the answer grounded in the actual file and proof commands relevant to the named refactor slice.
- Expect: the answer distinguishes observable behavior proof from unobservable refactor structure.
