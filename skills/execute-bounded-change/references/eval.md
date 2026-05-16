# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, narrowly scoped, maintainable work with explicit proof.
- Do not reward longer final answers, larger diffs, more files, or extra sections unless they materially improve correctness, judgment, or durability.

## Trigger
- The skill should trigger only when the intended code change is already clear and bounded enough to implement directly.

## Positive Task
- Prompt: Use `$execute-bounded-change` to replace deprecated `library.loadSkill(named:)` with `library.skill(named:)` in exactly two call sites in a disposable copy of `SkillRuntime.swift` and nowhere else. Verify with `check-boundaries.sh`, `check-skills-boundaries.sh`, and `verify-all.sh`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the patch stays within the named file and exact call sites; no helper extraction or unrelated cleanup is added.

## Positive Task (bug-fix mode)
- Prompt: Use `$execute-bounded-change` with `changeKind=bug-fix` on a disposable copy of a repository. Original failure: `bash scripts/check-boundaries.sh` fails because a checked-in `App.xcodeproj` surface exists. Fix slice: remove only the checked-in Xcode project/workspace surface that causes the boundary failure and nothing else. Verify with `check-boundaries.sh` and `check-skills-boundaries.sh`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the answer reports `Kind: bug-fix`, the fix stays bounded to the Xcode project surface, and the original repro is named as the first proof surface.

## Non-Match Task
- Prompt: Use `$execute-bounded-change` to decide whether a repository should have a user-facing marketplace feature. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-product-direction` or `plan-implementation-scope`.

## Non-Match Task (fuzzy bug)
- Prompt: Use `$execute-bounded-change` with `changeKind=bug-fix` for an intermittent issue with no stable repro at all. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-root-cause`.

## Accuracy Task
- Prompt: Use `$execute-bounded-change` on `SkillRuntime.swift` only for the approved deprecation swap and compare the answer against the actual diff and proof results in the disposable copy.
- Expect: the answer names the real changed surface, does not overstate proof success, and does not claim extra structural changes when the task did not authorize them.

## Accuracy Task (bug-fix mode)
- Prompt: Use `$execute-bounded-change` with `changeKind=bug-fix` on the disposable repository boundary failure and compare the answer against the actual changed surface and boundary-script results.
- Expect: the answer names the real repro, the exact fix slice, and the actual proof results without overstating repo-wide safety.
