# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, narrowly scoped tests that would catch the named risk.
- Do not reward larger matrices, more fixtures, or extra assertions unless they materially improve regression protection, judgment, or durability.

## Trigger
- The skill should trigger only when a known behavior or risk needs a concrete regression guard.

## Positive Task
- Prompt: Use `$execute-test-guards` to strengthen the weakest visible oracle in `/repo/Tests/StoreTests/ApplicationSupportSessionStoreTests.swift` only, without touching unrelated tests. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the recommendation stays inside the named test file and names one specific guard improvement.

## Non-Match Task
- Prompt: Use `$execute-test-guards` to implement a broad new feature from scratch. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `execute-bounded-change`.

## Accuracy Task
- Prompt: Use `$execute-test-guards` on `/repo/Tests/StoreTests/ApplicationSupportSessionStoreTests.swift` only and keep the recommendation grounded in the actual weak-oracle risk in that file. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the answer names a real weak oracle in the file and does not invent unrelated test debt.
