---
name: author-traceable-delivery-pack
description: "[author] 토론과 질의응답으로 추적 가능한 개발 운영 문서 패키지를 작성합니다. 제품 의도, 요구사항, 실행 표면, 에이전트 자동화 경계, 어댑터, QA, 릴리스 조건을 하나의 정합적인 문서 계약으로 고정해야 할 때 사용합니다."
---

# Author Traceable Delivery Pack

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

## 목적

토론이나 질의응답을 통해 구현자가 바로 사용할 수 있는 추적 가능한
개발 운영 문서 패키지를 작성하거나 갱신합니다.

이 스킬은 문서 작성 전용입니다. 코드를 구현하지 않습니다.

## 이 스킬을 쓰는 경우

- 새 제품, 앱, 패키지, 도구, 자동화 OS의 문서 패키지를 만들 때
- PRD/SPEC/ADR/TESTCODE만으로는 사람 승인, 에이전트 실행, 어댑터,
  QA, 릴리스 조건이 부족할 때
- 어떤 문서가 source of truth인지 토론으로 정해야 할 때
- TDos 같은 운영 철학과 구현 계약을 갖춘 문서 묶음이 필요할 때
- 기존 메모, 회의 내용, 리서치, 도구 목록을 구현 가능한 문서 계약으로
  정리해야 할 때

## 이 스킬을 쓰면 안 되는 경우

- 코드 구현이 주목적인 경우: `execute-bounded-change` 또는 관련 execute 스킬
- 현재 저장소 정체성 진단이 먼저 필요한 경우: `analyze-product-identity`
- 짧은 구현 범위만 필요한 경우: `plan-implementation-scope`
- 기존 README와 docs를 코드 기준으로만 맞추는 경우: `execute-docs-renewal`

## 핵심 원칙

1. 문서를 예쁘게 쓰지 말고 구현과 검증이 가능한 계약으로 쓴다.
2. 각 사실은 그 사실이 바뀌는 이유를 소유한 문서에 둔다.
3. source of truth owner는 주제별로 하나만 둔다.
4. `PRD -> SPEC -> ADR -> TESTCODE` 권한 분리를 기본으로 삼는다.
5. 운영 자동화가 필요할 때만 runtime, state, adapter, error, release 문서를
   추가한다.
6. 구현된 사실은 코드/테스트/실행 증거로 확인한다.
7. 근거가 없으면 `근거 부족`, 구현해야 하면 `구현 필요`, 이번에 하지 않으면
   `지금 구현은 하지 않는다`라고 쓴다.
8. 에이전트는 증거 수집, 문서 초안, 추적 링크, 검증 실행을 할 수 있지만
   제품 범위, 요구사항, ADR, UI 승인, waiver, 릴리스 go/no-go를 자동 승인하지 않는다.

## 진행 방식

### 1. 먼저 정체성을 고정한다

다음을 짧게 확정한다.

- 이 문서 패키지가 다루는 대상: app, web, server, package, CLI, library,
  automation OS, spec pack, mixed system
- 실제 사용자: product owner, engineer, agent operator, QA operator, release owner 등
- 핵심 가치: 문서 생성, 구현 통제, 에이전트 실행, QA, 릴리스 증거 중 무엇인지
- 최종 산출물: 문서 패키지, runtime 구현 명세, adapter 계약, release 계약 중 무엇인지

### 2. 한 번에 1~3개만 질문한다

질문은 결정을 막는 것만 한다.

우선 질문:

- 무엇이 product/proof source of truth인가?
- 사람이 반드시 승인해야 하는 결정은 무엇인가?
- 에이전트가 자율적으로 해도 되는 작업은 어디까지인가?
- 기존 도구/프로젝트는 무엇을 재사용하고 무엇을 새로 만들어야 하는가?
- QA와 릴리스는 어떤 증거 없이는 닫히면 안 되는가?

### 3. 문서 세트를 결정한다

기본 문서 세트는 `references/canonical-documents.md`를 따른다.

간단한 제품/기능이면 최소 세트만 쓴다.
자율 에이전트 운영, 도구 체인, QA, 릴리스 제어가 있으면 운영 세트를 추가한다.
개별 표면, 상태, 권한, 수용 기준이 독립적으로 바뀌면 split 문서를 추가한다.

### 4. 문서를 작성한다

문서마다 다음을 지킨다.

- frontmatter에 `doc_id`, `project_id`, `kind`, `status`, `version`, `owner`,
  `depends_on`, `source_refs`를 둔다.
- 요구사항은 `When/If/While ..., the system shall ...` 형태의 관찰 가능한 문장으로 쓴다.
- 모든 `REQ-*`는 `RS-*`에 연결한다.
- 모든 `T-*`는 기존 `REQ-*`만 검증한다.
- ADR은 비싼 결정을 하나만 다룬다.
- TESTCODE는 새 행동을 만들지 않고 관찰 방법과 증거만 쓴다.

### 5. 정합성을 검토한다

`references/authoring-checklist.md`의 체크리스트로 확인한다.

반드시 확인할 것:

- 문서별 owner가 겹치지 않는가
- `SRC-* -> RS-* -> REQ-* -> T-* -> evidence`가 끊기지 않는가
- 사람 승인과 에이전트 자율 작업이 분리됐는가
- adapter가 요구사항이나 릴리스 결정을 소유하지 않는가
- 릴리스가 missing evidence, failed gate, invalid waiver를 통과하지 않는가
- `구현 필요`와 `지금 구현은 하지 않는다`가 섞이지 않는가

## 산출물 형태

짧은 작업이면 문서 초안 또는 diff만 낸다.
문서 패키지를 직접 작성하는 요청이면 실제 파일을 만들거나 갱신한다.

최종 답변은 간단히 말한다.

- 만든 문서
- 정본으로 삼은 source of truth
- 구현 필요로 남긴 부분
- 정합성 검토 결과

## 참고 자료

- `references/canonical-documents.md`: 문서 세트와 각 문서의 책임
- `references/authoring-checklist.md`: 질의응답, 작성, 정합성 검토 체크리스트
