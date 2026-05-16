---
name: execute-test-guards
description: "[execute] 변경이나 위험을 테스트로 보호합니다. 실제 사용자 동작이나 버그 재발을 막는 최소 테스트를 추가하거나 기존 테스트를 더 믿을 수 있게 만들 때 사용합니다."
---

# Execute Test Guards

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
Add or strengthen automated tests that protect real behavior.

This skill is source-changing. It writes tests or small harnesses, not broad product code.

## Use This When
- a change needs regression protection
- a known behavior needs stronger automated coverage
- the team needs a small test matrix plus implemented guards

## Do Not Use This When
- the target behavior is still fuzzy
- the main job is feature implementation
- the goal is only to make CI green with low-value tests

## Non-Match Handling

If the request is broad feature implementation, root-cause analysis, or fake coverage work, stop immediately.

- For broad feature work:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-bounded-change
- For root-cause work:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-root-cause
맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- target behaviors
- changed code or changed surface
- existing tests and repository test patterns

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Guard target: ...`
- `Test matrix: ...`
- `Guard change: ...`
- `Verify: ...`
- `Remaining gap: ...`

## Required Code Shape Rules
- Always work `data-first, pure function 으로 작업` for new test helpers or supporting harness logic.
- If the test or harness code starts turning into a giant object, `작업으로 코드가 거대 오브젝트가 되려고 하면 분해부터 하고 작업 이어서 진행`.
- Prefer small data builders and pure assertions over stateful all-in-one fixtures.

## Mental Model
작업할 때는 범위를 좁게 잡고 확인 방법을 먼저 정합니다.
- Guard behavior, not vanity coverage.
- Choose the cheapest test layer that still catches the risk.
- Default to `data-first, pure function 으로 작업` for any helper code added here.
- Name what each test is protecting.
- Prefer public behavior proof over helper internals unless the helper is the public contract.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A small test that would catch the real regression is better than a large matrix that only raises coverage numbers.
- Do not add brittle assertions, oversized fixtures, or harness complexity unless they materially improve the proof.

## Workflow
1. Turn the target behaviors into a small test matrix.
2. Pick the cheapest test layer that still protects the behavior.
3. Confirm each proposed guard would fail for the known risk, or state why it is characterization coverage rather than regression proof.
4. If new test support code is growing into a giant object, split the support pieces first, then continue.
5. Add or update tests with small `data-first, pure function` helpers where helpers are needed.
6. Run the relevant test commands when possible.
7. Surface any remaining coverage gap.

## Stop Conditions
- the target behavior is still too fuzzy
- the repository has no credible place to put the guard
- the task would require broad feature work instead of test protection

## Boundaries
This skill does **not**:
- replace general implementation
- replace root-cause analysis
- pretend weak tests are real protection
