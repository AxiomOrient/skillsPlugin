# Eval

## Trigger
- The skill should trigger when the work is clear enough to plan but should not be implemented yet.

## Positive Task
- Prompt: Use `$plan-implementation-scope` for replacing deprecated `loadSkill` calls in `/repo/Sources/App/SkillRuntime.swift` with `skill(named:)` while preserving behavior. Verification should stay inside the existing repository boundary and test surface. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: bounded goal, assumptions, constraints, acceptance checks, and implementation outline only.

## Non-Match Task
- Prompt: Use `$plan-implementation-scope` to start coding the patch immediately. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `execute-bounded-change`.

## Accuracy Task
- Prompt: Use `$plan-implementation-scope` on the deprecation replacement and keep the plan grounded in the actual bounded file, existing behavior, and the repository verification surface.
- Expect: the plan stays implementation-scoped and does not drift into design or execution.
