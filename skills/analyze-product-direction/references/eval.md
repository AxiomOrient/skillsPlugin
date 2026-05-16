# Eval

## Trigger
- The skill should trigger when the main job is deciding whether a product or workflow direction should exist before planning or coding.

## Positive Task
- Prompt: Use `$analyze-product-direction` on `/repo`. Question: should this SwiftPM-first repository keep checked-in Xcode project surfaces, or should the current boundary scripts continue rejecting them? Ground the answer in the repository's existing boundary scripts and maintenance workflow only. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one bounded direction, a repo-grounded reason, one main risk, and one next step without drifting into implementation.

## Non-Match Task
- Prompt: Use `$analyze-product-direction` to replace deprecated `loadSkill(named:)` calls in `/repo/Sources/App/SkillRuntime.swift` right now. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `execute-bounded-change` and no direction-analysis prose.

## Accuracy Task
- Prompt: Use `$analyze-product-direction` on the checked-in-project question and keep the answer grounded only in `/repo/scripts/check-boundaries.sh`, `/repo/scripts/check-skills-boundaries.sh`, and the current SwiftPM-first repository shape.
- Expect: no invented product strategy, no compatibility claims beyond the named repo evidence.
