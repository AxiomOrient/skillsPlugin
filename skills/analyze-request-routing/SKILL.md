---
name: analyze-request-routing
description: "[analyze] 사용자 요청을 보고 다음에 어떤 작업 방식이 맞는지 분류합니다. 분석할지, 계획할지, 구현할지, 리뷰할지, 검증할지 애매할 때 사용합니다."
---

# Analyze Request Routing

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

이 스킬은 작업자가 아니라 dispatcher입니다. 다음에 실제로 진행할 lane 하나만 고르고, 도메인 작업은 직접 수행하지 않습니다.

## Lane Glossary

이 glossary는 이 스킬 안에서만 쓰는 라우팅 언어입니다.

- `analyze`: 구현 전에 사실, 원인, 위험, 방향을 근거로 판단합니다.
- `plan`: 이미 정한 방향을 작은 구현 범위와 검증 기준으로 고정합니다.
- `design`: API, 스키마, 모듈 경계처럼 외부 사용자가 믿을 계약을 정합니다.
- `author`: 구현자가 바로 사용할 문서나 명세를 작성합니다.
- `execute`: 승인된 좁은 변경을 실제 파일에 적용하고 확인합니다.
- `qa`: 변경 뒤 사용자 시나리오, 경계, 회귀 보호가 통과하는지 증명합니다.
- `review`: 이미 있는 변경이나 범위를 결함, 위험, 테스트 공백 중심으로 판정합니다.
- `meta`: 여러 스킬의 순서, 합의, 라우팅만 다루고 도메인 작업은 직접 하지 않습니다.
- `release`: 배포 가능성, 릴리스 노트, 게시 절차를 다룹니다.
- `clean`: 생성물, 캐시, legacy 파일처럼 제거 가능한 표면을 근거와 복구 경로와 함께 정리합니다.
- `xbmcp`: XcodeBuildMCP 기반 iOS/SwiftPM 빌드, 실행, 테스트 확인을 다룹니다.

## Non-Match Handling

If the request already has an approved next step, stop immediately.

- 첫 문장에서 바로 이 스킬 대상이 아니라고 말합니다.
- 첫 문장은 아래 뜻이 그대로 드러나야 합니다:
  이 요청은 `analyze-request-routing`이 아니라 `execute-bounded-change`로 바로 가야 합니다.
- 이유는 한 문장만 씁니다. 예: 이미 구현 단계가 승인돼서 라우팅이 더는 필요하지 않다.
- 더 맞는 스킬은 하나만 짧게 말합니다.
- 내부 규칙 파일, 샌드박스 상태, 장황한 배경 설명은 사용자가 따로 묻지 않으면 말하지 않습니다.

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Route: ...`
- `Why: ...`
- `Missing info: ...`
- `Next step: ...`

## Mental Model

판단할 때는 범위, 근거, 빠진 정보를 먼저 봅니다.

- Readiness first: is the request concrete enough for any next lane?
- Lane-fit first: which single workflow owns the next honest job?
- Mutation first: is the request still analysis-only, or is it already execution work?
- Evidence first: what missing fact prevents a clean route?

## Evidence Rules

- Use the user's verb, named artifact, and requested output as routing evidence.
- Route whole-repo reverse-engineering, full-tree inventory, or brownfield documentation requests to `analyze-repo-brownfield`.
- Prefer the narrowest next lane that can make progress without inventing missing intent.
- Do not chain multiple skills unless the user asked for a multi-step workflow or one skill cannot own the next honest job.
- If two lanes remain plausible, state the missing fact that would decide between them.
- Do not route to execution when the request still lacks a bounded target.

## Workflow

1. Read the normalized request.
2. Check whether the scope is already bounded enough for the next lane.
3. Choose one route only: `analyze`, `plan`, `design`, `author`, `execute`, `qa`, `review`, `meta`, `release`, `clean`, or `xbmcp`.
4. Name only the minimum handoff input the next lane needs.
5. Use `hold` when the route cannot be chosen honestly.
