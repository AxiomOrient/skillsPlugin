---
name: qa-boundary-proof
description: "[qa] 정해진 변경 후 경계 규칙이 지켜졌는지 확인합니다. 레이어, 모듈 의존 방향, 공개 API, 저장소 규칙을 증거로 검증해야 할 때 사용합니다."
---

# QA Boundary Proof

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

## Non-Match Handling

If the request is broad scenario QA or general code review, stop immediately.

- For scenario QA:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: qa-change-scenarios
- For broad verification:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: review-quality-check
## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Verdict: pass | fail | inconclusive`
- `Boundary checked: ...`
- `Evidence: ...`
- `Missing proof: ...` only when the verdict is inconclusive

## Mental Model

검증할 때는 결과와 근거가 맞는지부터 봅니다.

- Rule-source first: which script, manifest, or boundary checker is authoritative?
- Boundary first: what exact layer or surface restriction is being tested?
- Evidence first: which named command output supports the verdict?
- Harness first: if proof is missing, is that a real failure or only an absent checker?
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A single authoritative boundary proof is better than broad unrelated checks that do not test the named rule.

## Verification

- Use only the named boundary, contract, or repository-rule proofs.
- Report pass, fail, or inconclusive from actual evidence, not broad review opinion.
- Stop if the request is scenario QA or general quality review.
- If the authoritative boundary script or rule source is absent, report inconclusive instead of inventing a substitute broad check.

## Workflow

1. Lock the bounded boundary surface.
2. Use named boundary scripts or commands only.
3. Do not widen into general QA unless the boundary contract explicitly requires it.
4. Mark missing harnesses as inconclusive.
5. Quote or summarize the exact command result that supports the verdict.
