---
name: execute-release-notes
description: "[execute] 릴리스에 포함된 실제 변경 근거를 바탕으로 독자가 읽을 노트를 작성합니다. release notes, changelog, upgrade note, migration note, rollback note가 필요할 때 사용합니다."
---

# Execute Release Notes

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
Write release-facing documentation that explains what changed, who is affected, and what action is required.

This skill is **source-changing** when writing docs. It does not judge go/no-go or mutate refs.

## Use This When
- the team needs release notes, changelog entries, upgrade notes, migration notes, compatibility notes, or rollback notes
- the team needs one release-doc writer that can handle both user-facing and operator-facing release docs
- the docs must be grounded in the current release evidence

## Do Not Use This When
- the team needs git branch, tag, or GitHub release mutation
- the team needs rollout go/no-go judgement
- the team needs generic non-release documentation

## Non-Match Handling

If the request is release-risk judgement, publication execution, or generic documentation work, stop immediately.

- For go/no-go or safety judgement:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-release-readiness
- For publication execution:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: release-publish-package
맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- bounded release scope
- release-doc goal
- target audience
- optional release version and release evidence

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Audience: ...`
- `Summary: ...`
- `Impact: ...`
- `Action required: ...`
- `Notes: ...`

## Mental Model
작업할 때는 범위를 좁게 잡고 확인 방법을 먼저 정합니다.
- Document only the verified release slice.
- Separate user-visible change from operator action and internal cleanup.
- Do not invent migration or rollback steps.
- Tie important release claims to concrete evidence such as changed files, diff hunks, release tickets, test output, or migration scripts.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- Good release notes help the right reader decide impact and required action; longer changelogs or exhaustive internal detail are not better by default.

## Workflow
1. Read the release scope, audience, and supporting release evidence.
2. Separate change summary, compatibility impact, and required user or operator action.
3. Mark unsupported migration, compatibility, or rollback claims as unknown instead of filling them in.
4. Draft the requested release-facing docs.
5. Call out any doc gaps that block accurate claims.
6. Write the docs without widening into generic product documentation.

## Stop Conditions
- the release evidence is too weak to support the requested claims
- the audience or doc goal is missing
- the docs would require invented migration or rollback guidance

## Boundaries
This skill does **not**:
- judge release go or no-go
- mutate branches, tags, or release hosts
- rewrite unrelated non-release docs
