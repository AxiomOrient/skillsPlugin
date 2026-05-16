# Eval

## Trigger
- The skill should trigger when a reproduced failure or failing command exists and the main job is diagnosis.

## Positive Task
- Prompt: Use `$analyze-root-cause`. Repro: copying a SwiftPM repository to a new path and running `swift test` fails with `PCH was compiled with module cache path` mismatch and `missing required module 'SwiftShims'`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the answer identifies stale relocated SwiftPM cache reuse as the causal chain and does not drift into implementation.

## Non-Match Task
- Prompt: Use `$analyze-root-cause` to ship a feature quickly. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: 짧은 문단형 전환 설명; no root-cause essay.

## Accuracy Task
- Prompt: Use `$analyze-root-cause` on the copied-repository module-cache mismatch and keep the answer grounded in repo docs, scripts, and the observed failing path only.
- Expect: claims stay grounded in the observed cache behavior and nearby repo evidence.
