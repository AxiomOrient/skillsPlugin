---
name: execute-bounded-change
description: "[execute] 이미 할 일이 명확한 작은 코드 변경을 구현합니다. 범위가 정해진 기능 수정, 유지보수 변경, 재현 가능한 버그 수정을 바로 적용할 때 사용합니다."
---

# Execute Bounded Change

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

## What This Skill Does
Implement one approved bounded code change.

This skill is **source-changing**. It writes code, not review verdicts.

## Use This When
- the intended change is already clear enough to implement
- the task needs real code changes rather than analysis alone
- the change can stay within one approved boundary
- a bug fix needs implementation and the original repro is already concrete enough to rerun honestly

## Do Not Use This When
- the request still needs scoping or package work
- the main job is bug reproduction or root-cause isolation
- the main job is review-only judgement

## Non-Match Handling

If the request is product direction, planning, debugging, review-only work, or any other non-implementation job, stop immediately.
For any non-match, the first sentence must say that this is not the `execute-bounded-change` lane, then name the correct lane. Do not inspect product docs, code, or tests to answer the out-of-lane question.
Do not answer the underlying product, planning, debugging, or review question from this skill. The whole response should only redirect the lane in one short paragraph.

- For product or planning work:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-bounded-change` 범위가 아닙니다.
  - 더 맞는 스킬이나 조건: analyze-product-direction or `plan-implementation-scope`
- For debugging:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-bounded-change` 범위가 아닙니다.
  - 더 맞는 스킬이나 조건: analyze-root-cause
- For review-only work:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-bounded-change` 범위가 아닙니다.
  - 더 맞는 스킬이나 조건: review-quality-check or the relevant review lane

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- approved task or bounded change request
- optional `changeKind`:
  - `feature`
  - `maintenance`
  - `bug-fix`
- optional original repro, failing command, or failing scenario when `changeKind=bug-fix`
- optional public-surface repro such as a minimal caller snippet, import example, or failing external build when the change touches exports, umbrella modules, or package-facing APIs
- current code and tests in the target surface
- known constraints and done signals

## 내부 정리 기준
최종 답변에는 아래 뜻만 짧게 담습니다:
- `Kind: feature | maintenance | bug-fix`
- `Changed surface: ...`
- `Patch: ...`
- `Verify: ...`
- `Rollback: ...`

## Required Code Shape Rules
- Always work `data-first, pure function 으로 작업`.
- If the change starts to accumulate into a giant object, `작업으로 코드가 거대 오브젝트가 되려고 하면 분해부터 하고 작업 이어서 진행`.
- Prefer small data transforms and narrowly scoped helpers before adding coordination layers.
- If the change touches a public or re-exported surface, avoid introducing duplicate public names in the same caller-visible namespace unless the task explicitly requires it and the caller proof still passes.

## Mental Model
작업할 때는 범위를 좁게 잡고 확인 방법을 먼저 정합니다.
- Change only the tissue that needs changing.
- Prefer the smallest patch that closes the task honestly.
- Default to `data-first, pure function 으로 작업`.
- Do not smuggle unrelated cleanup into the operation.
- If this is a bug fix, the original repro is the first proof surface, not an optional extra.
- If the patch changes what outside callers import or see, an internal green build is not enough; prove the caller surface directly.
- Do not answer product direction, prioritization, or “should we build it?” questions from this lane.

## Quality Bar
- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A better patch is the smallest readable change that strengthens the right behavior or contract; more files, broader cleanup, extra abstraction, or longer explanation is not better by default.
- Before editing, know which user behavior, invariant, or public contract the change protects and which proof would catch a regression.
- If the obvious implementation would make the system harder to understand, test, or maintain, narrow the change or route to analysis instead of shipping churn.

## Workflow
1. Read the target code, tests, and done signals.
2. Lock the change kind:
   - `feature`
   - `maintenance`
   - `bug-fix`
3. If `changeKind=bug-fix`, lock the original repro or failing path before editing. If the failure is not concrete enough to rerun honestly, stop and redirect to `analyze-root-cause`.
4. Identify the smallest change surface that can satisfy the task.
5. Do not widen the patch beyond the explicitly approved surface unless the task itself explicitly allows that expansion.
6. If the requested patch names exact call sites or files, stay inside that exact surface and do not introduce extra helpers, renames, or cleanup unless they are strictly required for correctness.
7. If the work is pulling the code toward a giant object, stop and say the task needs a prior scoping step instead of silently broadening the patch.
8. Implement the change with a `data-first, pure function 으로 작업` bias wherever the boundary allows it.
9. Update only the directly required supporting code or docs.
10. Verification order:
    - if `changeKind=bug-fix`, rerun the original repro first
    - if the patch changes a public facade, re-export, umbrella target, or package-facing type, run the smallest honest external-caller proof next
    - then run the cheapest relevant checks for the changed surface
    - add or update the narrowest regression guard only when needed
11. State any execution gap explicitly instead of overstating proof.

### Public Surface Proof
- If callers use `import X`, verify with a minimal throwaway caller that imports `X` and references the changed symbol names directly.
- If the surface re-exports multiple modules, check for public name collisions in that combined namespace before declaring success.
- Do not accept “internal call sites compile” as proof for a public-surface change.

## Stop Conditions
- the change goal is still ambiguous
- the task would widen into unrelated work
- a required precondition or dependency is missing
- the patch would rely on invented behavior
- `changeKind=bug-fix` but the original repro is still fuzzy or not rerunnable

## Boundaries
This skill does **not**:
- perform broad planning or package writing
- claim root cause without evidence
- turn implementation into a full review pass
