# Eval

## Trigger
- The skill should trigger when the request is about whether tests prove behavior, not about coverage percentage or broad QA.

## Positive Task
- Prompt: Use `$analyze-test-contract` on `/repo/Tests/StoreTests/ApplicationSupportSessionStoreTests.swift` only. Read-only first pass. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one or more concrete findings about contract strength, oracle quality, or proof scope in that file only.

## Non-Match Task
- Prompt: Use `$analyze-test-contract` to raise overall repo coverage percentage. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: 짧은 문단형 전환 설명 with no contract-audit analysis.

## Accuracy Task
- Prompt: Use `$analyze-test-contract` on `ApplicationSupportSessionStoreTests.swift` only and keep the analysis grounded in the actual tests in that file.
- Expect: the answer identifies real weak-oracle or broad-scope issues without inventing failures from sibling tests.

## Brownfield Boundary Task
- Prompt: Use `$analyze-test-contract` to reverse-engineer a repository and summarize all tests as part of a brownfield documentation pack.
- Expect: redirect to `analyze-repo-brownfield`; no repo-wide brownfield report from the test-contract skill.
