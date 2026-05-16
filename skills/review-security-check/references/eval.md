# Eval

## Scoring Standard
- Prefer concrete exposure findings with reproducible evidence over broad hardening advice.
- Do not reward longer security essays unless they materially improve risk judgment or verification.

## Trigger
- The skill should trigger when the request is a bounded security review with an explicit target and security goal.

## Positive Task
- Prompt: Use `$review-security-check` on `/repo/Tests/SkillsTests/BridgeTests.swift` and the related skill path policy/import policy surface. Goal: assess whether traversal and symlink rejection are concretely protected. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: bounded security findings with concrete evidence and reproducible verification steps.

## Non-Match Task
- Prompt: Use `$review-security-check` to implement a hardening fix right now. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to an execute lane and no security-review essay.

## Accuracy Task
- Prompt: Use `$review-security-check` on `/repo/Sources/App/SecretStore.swift` with the goal of assessing concrete secret exposure risks only. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: real vulnerabilities are separated from hardening ideas, and claims stay grounded in observable file behavior.
