---
name: design-api-contract
description: "[design] API, 스키마, 모듈 경계에서 외부 사용자가 믿고 쓸 최소 약속을 정합니다. 구현보다 입력, 출력, 오류, 호환성 같은 공개 규칙을 먼저 정해야 할 때 사용합니다."
---

# Design API Contract

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

If the change has no caller-visible contract impact, stop immediately.

- For internal cleanup or implementation-only work:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 먼저 필요한 조건을 한 줄로 말합니다.
## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Contract decisions: ...`
- `Invariants: ...`
- `Compatibility risk: ...`
- `Next proof target: ...`

## Mental Model

판단할 때는 범위, 근거, 빠진 정보를 먼저 봅니다.

- Surface first: what caller-visible boundary is actually changing?
- Invariants first: what must remain true across versions and implementations?
- Compatibility first: what existing caller expectation could break?
- Migration first: what is the cheapest proof that the new contract is still safe?

## Evidence Rules

- Point to the caller-visible API, schema, command, or module boundary being decided.
- Mark internal-only cleanup as out of scope instead of inventing a contract.
- Include the narrowest compatibility proof the implementer must preserve.

## Workflow

1. Identify the caller-visible boundary.
2. Choose the smallest stable contract that satisfies the request.
3. Name invariants and compatibility risk explicitly.
4. Stop before implementation.
