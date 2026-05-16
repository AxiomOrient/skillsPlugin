# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, narrowly scoped, maintainable work with explicit proof.
- Do not reward longer final answers, larger diffs, more files, or extra abstractions unless they materially improve correctness, judgment, or durability.

## Trigger
- The skill should trigger only when a concrete Go refactor target is already chosen.

## Positive Task
- Prompt: Use `$execute-refactor-go` on `/repo/cli_governance.go` only to extract one pure request-building helper from `runTrial` without changing behavior. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one bounded Go refactor slice with explicit verification, no target discovery, and no unnecessary new comments.

## Non-Match Task
- Prompt: Use `$execute-refactor-go` to find the best refactor target somewhere in `/repo`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-refactor-target`.

## Accuracy Task
- Prompt: Use `$execute-refactor-go` on `/repo/cli_governance.go` only and keep the slice grounded in the actual command wiring and helper seams in that file.
- Expect: the answer stays grounded in the named file, chooses one Go-specific slice only, and does not invent explanatory comments unless the slice reveals a non-obvious invariant.
