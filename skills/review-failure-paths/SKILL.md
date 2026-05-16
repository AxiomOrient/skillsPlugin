---
name: review-failure-paths
description: "[review] 정해진 범위의 실패 상황만 리뷰합니다. 예외 처리, fallback, cleanup, 부분 실패, 재시도 흐름이 안전한지 확인할 때 사용합니다."
---

# Review Failure Paths

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
Find missing, inconsistent, or unsafe failure-handling paths in a bounded target.

This skill is **review-only**. It stays on unhappy-path behavior only.

## Use This When
- the team needs to inspect only failure paths and cleanup behavior
- the team needs to verify exception, fallback, timeout, or recovery handling
- the team needs a bounded review focused on unhappy-path behavior

## Do Not Use This When
- the team needs a broad review across all concerns
- the team needs to implement the fix immediately without first checking error-path coverage
- the target has no relevant failure or cleanup paths

## Non-Match Handling

If the request is a broad general review, direct implementation, or has no bounded failure surface, stop immediately.

- For broad multi-concern review:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: review-quality-check
- For direct code mutation:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-bounded-change or the relevant execute lane

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- bounded target scope
- optional failure focus such as exceptions, fallbacks, or recovery
- optional known failure modes

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Status: pass | risk | inconclusive`
- `Findings: ...`
- `Evidence: ...`
- `Next check: ...`

## Mental Model
검토할 때는 실제 위험이 있는지부터 봅니다.
- Walk the unhappy path on purpose.
- Review cleanup and recovery, not style or normal-path polish.
- Mark unproven failure ideas as inconclusive instead of as bugs.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A short confirmed failure-path finding is more valuable than a long list of hypothetical robustness ideas.

## Workflow
1. Read the target scope and any named failure modes.
2. Inspect exception, fallback, cleanup, and recovery paths.
3. Separate proven error-path findings from missing guards and recovery gaps.
4. Mark unsupported suspicions as inconclusive.
5. Return one bounded failure-path status.

## Stop Conditions
- the target scope is too vague to inspect
- the relevant failure or cleanup paths cannot be found
- the review would require invented failure behavior

## Boundaries
This skill does **not**:
- rewrite the pass into a general quality review
- patch code
- inflate hypothetical robustness ideas into confirmed defects
