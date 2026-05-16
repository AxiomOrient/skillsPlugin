# Eval

## Scoring Standard
- Prefer concrete unhappy-path findings with evidence over long hypothetical robustness lists.
- Do not reward extra findings unless they are grounded and materially affect safety or recovery.

## Trigger
- The skill should trigger when the request is explicitly about unhappy-path inspection for a bounded surface.

## Positive Task
- Prompt: Use `$review-failure-paths` on `/repo/Sources/App/SkillRuntime.swift` focusing only on missing skill, missing secret, script error, and webview resolution unhappy paths. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: bounded unhappy-path review output with no drift into broad quality review.

## Non-Match Task
- Prompt: Use `$review-failure-paths` to perform a broad quality review across all concerns. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `review-quality-check`.

## Accuracy Task
- Prompt: Use `$review-failure-paths` on `/repo/crates/host/src/execution.rs` focusing only on timeout, cancellation, and partial failure handling. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: claims stay grounded in observable failure-handling code paths and do not drift into general architecture review.
