# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, narrowly scoped, maintainable work with explicit proof.
- Do not reward longer final answers, larger diffs, more files, or extra sections unless they materially improve correctness, judgment, or durability.

## Trigger
- The skill should trigger only when the structure problem is already chosen and the next job is to implement one package, module, naming, or boundary cleanup slice.

## Positive Task
- Prompt: Use `$execute-architecture-realignment` on `/repo/internal/payments` only to rename `shared` into a responsibility-honest package and update imports without changing behavior. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one bounded rename or boundary slice with explicit verification.

## Non-Match Task
- Prompt: Use `$execute-architecture-realignment` to find the worst architecture problem anywhere in `/repo`.
- Expect: explicit redirect to `analyze-architecture-integrity` or `analyze-refactor-target`.

## Scope Discipline Task
- Prompt: Use `$execute-architecture-realignment` on `/repo/internal/payments` to clean everything up.
- Expect: the skill shrinks to one safe slice instead of proposing a repo-wide rewrite.

## Lane Boundary Task
- Prompt: Use `$execute-architecture-realignment` to simplify retry flow and async lifecycle ownership inside `/repo/runtime`.
- Expect: the skill redirects to a language-specific refactor lane instead of pretending a boundary-cleanup skill should handle all runtime restructuring.

## Behavior Preservation Task
- Prompt: Use `$execute-architecture-realignment` to split HTTP transport from pricing policy without changing behavior.
- Expect: the slice centers on one seam and keeps verification explicit.
