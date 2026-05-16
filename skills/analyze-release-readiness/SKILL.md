---
name: analyze-release-readiness
description: "[analyze] 정해진 릴리스 범위가 지금 배포 가능한지 판단합니다. 호환성, 위험, 테스트 상태, 롤백 준비를 근거로 go/no-go 결정을 내려야 할 때 사용합니다."
---

# Analyze Release Readiness

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
Judge release safety and rollback readiness for one bounded release slice.

This skill is **review-only**. It must not publish or mutate refs.

## Use This When
- the team needs rollout, impact, or rollback judgement before release
- the team needs a release readiness verdict grounded in real release evidence
- the team needs rollout, interface, and monitoring checks before deployment

## Do Not Use This When
- the team needs direct implementation or bug debugging
- the team needs only repository or docs hygiene checks
- the team needs actual branch, tag, or release publication execution

## Non-Match Handling

If the request is direct implementation, release publication, or has no bounded release evidence, stop immediately.

- For branch/tag/release execution:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: release-publish-package
- For direct implementation or debugging:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-bounded-change or `analyze-root-cause`

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- bounded release scope
- real rollout plan
- real rollback path
- optional known gates such as tests, docs, approval, compatibility, or security signals

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Verdict: go | no-go | blocked`
- `Reason: ...`
- `Rollback readiness: ...`
- `Residual risk: ...`

## Mental Model
판단할 때는 범위, 근거, 빠진 정보를 먼저 봅니다.
- Judge one release slice at a time.
- Center the decision on blast radius, gates, and rollback readiness.
- Blocked is safer than optimistic guesswork.

## Workflow
1. Read the bounded release scope, rollout plan, rollback path, and known gates.
2. Estimate the blast radius from the actual release slice.
3. Check whether rollout, rollback, compatibility, and monitoring evidence are strong enough.
4. Separate observed gate evidence from the final decision.
5. Return `go`, `no-go`, or `blocked` with the concrete reason.

## Stop Conditions
- the release slice is too vague to judge
- rollout plan or rollback path is missing
- the decision would require assuming unresolved safety gates are green

## Boundaries
This skill does **not**:
- mutate branches, tags, or release hosts
- replace repository or hygiene gate checks
- bury missing rollback evidence inside optimistic prose
