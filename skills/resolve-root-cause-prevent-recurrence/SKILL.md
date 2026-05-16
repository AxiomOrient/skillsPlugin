---
name: resolve-root-cause-prevent-recurrence
description: "[execute] 재현된 실패, 깨진 게이트, 스테일 아티팩트, 누락된 의존성, 불안정한 테스트, 회귀를 실제 근본 원인까지 추적하고 내구성 있게 수정하며 재발을 막습니다. '근본 원인 찾아줘', '남은 갭 해결해줘', '다시는 이 일이 없도록 해줘', '가드 추가해줘' 같은 요청에 사용합니다."
---

# Resolve Root Cause And Prevent Recurrence

## 최종 답변 우선 규칙

이 문서 아래에 고정 라벨, 표, JSON, 예시가 있어도 사용자에게 보이는 최종 답변은 이 규칙을 먼저 따른다.

- 결론, 판정, 변경사항을 첫 문장에 둔다.
- 기본 답변은 쉬운 한국어 2~4문장으로 끝낸다.
- 세부 근거, 명령, 파일 목록은 결과를 이해하거나 검증하는 데 꼭 필요할 때만 넣는다.
- 필수 출력 형식, JSON 계약, 사용자 요청 형식은 보존한다.
- 내부 정리용 라벨과 템플릿 문구는 그대로 노출하지 않는다.
- 불확실하면 추측하지 말고 확인해야 할 사실만 짧게 말한다.
- 사용자가 묻지 않은 다음 작업 추천은 넣지 않는다.

## 원자성 원칙

- 이 스킬은 이 `SKILL.md`와 같은 폴더의 `references/`, `scripts/`, `assets/`만으로 이해되고 실행되어야 한다.
- sibling skill, 전역 context 파일, 외부 설치 스킬에 의존하지 않는다.
- 한 번에 이 스킬이 맡은 일 하나만 수행한다. 범위를 벗어나면 다른 스킬 이름을 짧게 말하고 중지한다.

## 품질 기준

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.

## Purpose

Turn a concrete failure into a durable fix and a recurrence guard. This skill is source-changing when a safe fix is available; otherwise it must leave an explicit blocker with the exact missing proof.

## Use This Skill When

- a failing command, broken gate, stale artifact, missing runtime, flaky test, or regression already has a concrete signal;
- the user asks to solve remaining gaps and prevent recurrence;
- a failed release, QA, audit, build, or runtime proof needs root-cause repair rather than only reporting pass/fail;
- a skill or process itself failed and needs a reusable prevention workflow.

## Do Not Use This Skill When

- the user only asks for scenario QA after a known change; use `qa-change-scenarios`;
- the user only asks for code review; use `review-quality-check`;
- no failure signal, changed surface, or accepted scenario can be identified after auto-research;
- the only missing input is a credential, permission, or external service the agent cannot supply.

## Auto-Research Gate

If the user gives an exact failing command, file, gate, screenshot, or log, skip this gate and start from that evidence.

If the request is broad, such as "fix the remaining gaps", "find why this broke", or "make sure this never happens again", read `references/auto-research.md` before editing. Reduce the work to one evidence chain:

```text
failure signal -> runtime surface -> suspected boundary -> proof command -> prevention guard
```

If any field remains empty, stop with `blocked` or route to the named skill in Skill Chain. Do not convert vague concern into source changes.

## Skill Chain

- Start with `analyze-root-cause` when the failure path is not yet explained.
- Use `execute-bounded-change` for a small single-surface fix.
- Use `execute-product-completion` when the failure blocks a documented product goal or release path.
- Use `qa-change-scenarios` after the fix changes user-visible behavior or an operating workflow.
- Use `review-quality-check` when the patch needs a checklist review.
- Use `review-project-completion` only when the question is whether the whole scoped project can now be called complete.
- Use `skill-creator` when the prevention process itself must become or update a skill.

## Decision Rules

- Diagnose before editing when the causal chain is unknown.
- Repair policy or contract before repairing corrupted data.
- Keep failed evidence as history only when it is clearly marked failed and excluded from pass gates.
- Treat generated artifact drift as a source-of-truth sync problem, not as freehand text editing.
- Treat missing external runtime as a setup/readiness problem unless the changed code removed the runtime.
- Prefer one narrow regression guard over many broad smoke checks.

## Workflow

1. Reproduce or pin the failure.
   - Capture the exact command, UI action, file, gate, or scenario that fails.
   - Save the smallest useful log excerpt and exit status.
   - If no reproducible signal exists, stop and ask for the missing signal.

2. Separate symptom, trigger, defect, and upstream cause.
   - Symptom: what failed.
   - Trigger: what input or state made it fail now.
   - Local defect: the closest wrong code, contract, fixture, data, dependency, or policy.
   - Upstream cause: why the wrong state was allowed to exist.

3. Choose the smallest durable fix.
   - Prefer fixing the policy or contract that admitted the bad state.
   - Do not hide the failure with warnings, broad fallbacks, stale snapshots, or fake success.
   - Repair existing corrupted data only after the policy can prevent the same corruption.

4. Add a recurrence guard.
   - Add or strengthen the nearest unit, integration, fixture, CLI, snapshot, schema, or audit check.
   - The guard must fail on the original broken state.
   - The guard must be cheap enough to run in the normal verification path.

5. Verify in layers.
   - First run the narrow regression guard.
   - Then run the original failing command.
   - Then run the nearest broader build/test/audit command.
   - If the fix updates generated or evidence data, refresh integrity hashes and verify them.

6. Record residual risk.
   - If an external dependency, credential, fixture, or generated artifact is still missing, name it as a blocker.
   - Include the owner/proof needed to close it.

7. Hand off to scenario QA when behavior changed.
   - Use `qa-change-scenarios` for the changed runtime surface.
   - Include happy, edge, and failure proof only inside the fixed surface.
   - Classify remaining gaps as product failure, environment or harness failure, or coverage gap.

## Guard Selection

Read `references/prevention-guards.md` when choosing the recurrence guard. Load it only after the root cause is known.

## Self-Validation

Read `references/eval.md` when validating or improving this skill. A valid improvement must show at least one concrete scenario where the old instruction was ambiguous, unsafe, or too weak, and the new instruction changes the outcome.

## Output Discipline

Keep the final response short and evidence-backed:

- root cause fixed
- files changed
- recurrence guard added
- commands that passed
- remaining blockers, if any

Do not claim completion when the original failing command, the guard, or an integrity check still fails.
