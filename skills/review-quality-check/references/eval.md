# Eval

## Scoring Standard
- Prefer clear, material risk judgment over output volume or style-only comments.
- Do not reward longer checklist prose unless it improves correctness, maintainability, verification, or goal-fit judgment.

## Trigger
- The skill should trigger when the user wants a bounded quality checklist review rather than implementation or root-cause work.

## Positive Task
- Prompt: Use `$review-quality-check` on `/repo/Sources/App/SkillRuntime.swift` as the bounded review scope, with the goal of replacing deprecated `loadSkill` calls while preserving behavior. Answer in a short, easy Korean paragraph.
- Expect: the answer stays grounded in the file and goal, and explains the main quality risk or lack of risk in plain language.

## Non-Match Task
- Prompt: Use `$review-quality-check` to patch code directly. Answer in a short, easy Korean paragraph.
- Expect: the first sentence clearly says this is not the right skill because the request is implementation work, and it names one execute skill without citing internal files or sandbox details.

## Accuracy Task
- Prompt: Use `$review-quality-check` on `/repo/Sources/App/CredentialVault.swift` with the goal of evaluating whether an inspection lane selection is clear, testable, and behavior-preserving to refactor. Answer in a short, easy Korean paragraph.
- Expect: claims stay grounded in the file and nearby tests; no invented implementation or QA evidence.
