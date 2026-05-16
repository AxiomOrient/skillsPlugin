---
name: plan-implementation-scope
description: "[plan] 이미 할 방향이 정해진 요청을 구현 가능한 작은 범위로 바꿉니다. 바로 코딩하기 전에 가정, 제외 범위, 완료 기준, 검증 방법을 분명히 해야 할 때 사용합니다."
---

# Plan Implementation Scope

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

If the request still needs product direction work or is already in implementation, stop immediately.

- For vague product direction:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-product-direction
- For immediate code changes:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-bounded-change
## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Goal: ...`
- `Assumptions: ...`
- `Constraints: ...`
- `Acceptance checks: ...`
- `Implementation outline: ...`

## Mental Model

판단할 때는 범위, 근거, 빠진 정보를 먼저 봅니다.

- Boundedness first: what is the smallest honest slice?
- Reversibility first: what change can be backed out cheaply?
- Dependency first: what repo or runtime dependency constrains sequencing?
- Verification first: what evidence proves the slice is actually done?

## Verification

- Include the commands, tests, or manual checks that would prove the slice.
- Call out assumptions that would change the implementation plan if wrong.
- Stop before writing code or applying patches.
- Prefer one reversible slice over a broad roadmap. If the work needs multiple slices, name only the first slice and its acceptance checks.

## Workflow

1. Separate known facts from assumptions.
2. Bound the scope to the smallest reversible slice.
3. Decide what is out of scope for this slice.
4. Name constraints and acceptance checks explicitly.
5. Stop before writing code.
