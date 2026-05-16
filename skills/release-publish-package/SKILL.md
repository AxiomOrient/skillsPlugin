---
name: release-publish-package
description: "[release] 이미 승인되고 준비된 패키지 릴리스를 실제로 게시합니다. push나 publish 전에 명시적으로 확인하고, 배포와 되돌리기 기준이 준비됐을 때 사용합니다."
---

# Release Publish Package

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
Execute release preparation and publication with explicit cleanup, branch, tag, and publish evidence.

This skill is **source-changing and side-effecting**. It must never publish implicitly.

## Use This When
- a validated release candidate is already approved for publication
- the team needs cleanup, tag, branch, and publish actions executed as one bounded release run
- the team needs the exact publication evidence recorded

## Do Not Use This When
- the team needs release-risk judgement only
- the repository, hygiene, or readiness gates are still unresolved
- the current run cannot tolerate branch, tag, or remote mutation

## Non-Match Handling

If the request is only release-risk analysis or the publication is not yet explicitly approved, stop immediately.

- For readiness judgement:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-release-readiness
- For unapproved publication:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: obtain explicit approval and green gates first
맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- source branch
- target branch
- release bump policy or explicit tag
- required pre-publish checks
- publish target and optional release-note source

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Status: prepared | published | blocked`
- `Gates: ...`
- `Needed: ...`
- `Next: ...`

## Mental Model
작업할 때는 범위를 좁게 잡고 확인 방법을 먼저 정합니다.
- Do not ship until the gates are green and confirmation is explicit.
- Treat every mutation as evidence-backed state change.
- Prepared or blocked is better than pretending publication happened.

## Workflow
1. Confirm that repository, hygiene, and readiness gates are already green.
2. Run required checks before mutating anything.
3. Ask for explicit confirmation before any push, tag, or publish action that has not yet happened.
4. Perform the bounded cleanup and publication steps that were explicitly approved.
5. Record exact commit, tag, push, and publish evidence.

## Stop Conditions
- a required gate is unresolved
- a required check fails
- explicit confirmation for a pending push or publish action is missing
- publication success cannot be proven from the current run

## Boundaries
This skill does **not**:
- replace release-risk analysis
- publish implicitly
- invent success for branch, tag, or release-host actions that were not confirmed
