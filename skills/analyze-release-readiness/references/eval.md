# Eval

## Trigger
- The skill should trigger when the task is to judge one bounded release slice using rollout, rollback, and gate evidence.

## Positive Task
- Prompt: Use `$analyze-release-readiness` on the bounded repository boundary fix slice where removing checked-in `App.xcodeproj` made `check-boundaries.sh` and `check-skills-boundaries.sh` pass again. Rollout plan: internal maintainer cleanup only. Rollback path: restore the removed checked-in Xcode project if needed. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: a bounded readiness verdict with reason, rollback readiness, and residual risk.

## Non-Match Task
- Prompt: Use `$analyze-release-readiness` to publish the release now. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `release-publish-package`.

## Accuracy Task
- Prompt: Use `$analyze-release-readiness` on the bounded repository boundary fix and keep the answer grounded only in the named boundary-script evidence and rollback path.
- Expect: no invented user-facing compatibility or rollout claims.
