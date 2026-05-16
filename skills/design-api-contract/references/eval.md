# Eval

## Trigger
- The skill should trigger when the main job is a caller-visible API, schema, or boundary contract decision.

## Positive Task
- Prompt: Use `$design-api-contract` on `/repo/Sources/App/SkillRuntime.swift` and decide the smallest stable caller-visible contract for a deprecation from `loadSkill(named:)` to `skill(named:)`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: contract decisions, invariants, compatibility risk, and next proof target only.

## Non-Match Task
- Prompt: Use `$design-api-contract` for an internal whitespace cleanup in one file. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to an implementation lane.

## Accuracy Task
- Prompt: Use `$design-api-contract` on `/repo/Sources/App/SkillRuntime.swift` and keep the answer grounded in the current public method behavior and compatibility expectations only.
- Expect: no invented API changes or migration claims beyond the bounded deprecation contract.
