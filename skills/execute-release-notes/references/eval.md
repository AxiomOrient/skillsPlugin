# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, audience-specific release notes with explicit unsupported claims.
- Do not reward longer notes, broader changelogs, or extra sections unless they materially improve reader actionability, judgment, or durability.

## Trigger
- The skill should trigger only when the task is to write release-facing notes from concrete release evidence.

## Positive Task
- Prompt: Use `$execute-release-notes` to draft release-facing notes for the bounded repository change of removing checked-in Xcode project surfaces to restore boundary compliance. Audience: maintainers. Release evidence: boundary scripts pass after removal. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: maintainer-facing notes grounded only in the named boundary evidence.

## Non-Match Task
- Prompt: Use `$execute-release-notes` to decide whether the release is safe to ship. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-release-readiness`.

## Accuracy Task
- Prompt: Use `$execute-release-notes` to write maintainer-facing notes for the bounded repository boundary fix only, grounded in the fact that `check-boundaries.sh` and `check-skills-boundaries.sh` pass after removing `App.xcodeproj`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the answer stays limited to the named evidence and does not invent broader compatibility or migration claims.
