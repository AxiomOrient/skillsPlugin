# Canonical Documents

이 파일은 추적 가능한 개발 운영 문서 패키지의 문서 세트와 책임을 정한다.

## 1. 최소 제품 문서 세트

| Document | Owns | Must not own |
|---|---|---|
| `README.md` | 패키지 목적, 읽는 순서, 현재 상태 | 세부 요구사항, 별도 source of truth |
| `PRD.md` | 의도, 문제, 사용자, 목표, 비목표, source register, requirement seeds | 구현 분해, 런타임 설계, 테스트 상세 |
| `SPEC.md` | 실행 가능한 요구사항, 계약, 완료 조건, 검증 조건 | 비싼 의사결정의 전체 논리, 테스트 시나리오 상세 |
| `ADR-001.md` | 하나의 비싼 아키텍처/운영 결정 | 여러 결정 묶음, 요구사항 생성 |
| `TESTCODE.md` | 요구사항별 proof design, oracle, evidence target | 새 제품 행동, 요구사항 변경 |

이 기본 구조는 speckit greenfield pack의 권한 분리에서 차용한다:

```text
PRD -> SPEC -> ADR -> TESTCODE
```

하위 문서는 상위 문서의 의도를 다시 쓰지 않는다.

## 2. 운영 문서 세트

자율 에이전트, adapter, QA, 릴리스 제어가 있으면 아래를 추가한다.

| Document | Owns | When to add |
|---|---|---|
| `OPERATING_BOUNDARIES.md` | 사람 승인, 에이전트 자율 작업, 자동화 한계 | 자동화가 사람 결정을 침범할 위험이 있을 때 |
| `RUNTIME_SURFACE.md` 또는 `TDOS_RUNTIME_SURFACE.md` | CLI/API/앱 표면, 입력, 출력, stop rule | 실제 실행 도구를 만들 때 |
| `STATE_MACHINE.md` | 파생 상태, 상태 전이, blocker 규칙 | release/readiness 상태가 필요할 때 |
| `ADAPTER_CONTRACTS.md` 또는 `TOOL_ADAPTER_CONTRACTS.md` | 도구별 입력, 출력, hard rule | 외부 도구나 내부 프로젝트를 adapter로 묶을 때 |
| `ADAPTER_ERROR_CONTRACTS.md` | 실패 분류, gate 상태 매핑, next action | adapter 실패가 릴리스 판단에 영향을 줄 때 |
| `QA_ADAPTER_PROGRAM.md` | QA adapter 범위, 입력, 출력, 분류 규칙 | QA를 수동 체크가 아니라 repeatable evidence로 만들 때 |
| `RUNBOOK.md` | 순서 있는 운영 절차, precondition, stop condition, rollback | 사람이 절차를 따라야 할 때 |
| `ROADMAP.md` | 단계별 출시/구현 순서 | 패키지를 실제 구현으로 옮길 때 |
| `IMPLEMENTATION_PLAN.md` | 작은 구현 slice와 acceptance | 바로 작업할 구현자가 있을 때 |
| `ARCHITECTURE_LOCK.md` | lock 상태, hard no-change rule, change process | 운영 방법을 고정해야 할 때 |

## 3. Split 문서 규칙

`SPEC.md`가 너무 커질 때만 split 문서를 만든다.

차용 기준:

- capability, surface, state, permission, acceptance가 독립적으로 바뀌면 분리한다.
- 독립적으로 바뀌지 않으면 `SPEC.md` 안의 requirement linkage로 충분하다.
- 같은 사실을 `SPEC.md`와 split 문서에 중복 저장하지 않는다.

가능한 split 문서:

- `CAPABILITY_*.md`
- `SURFACE_*.md`
- `STATE_MODEL.md`
- `PERMISSION_MODEL.md`
- `ACCEPTANCE.md`

## 4. Frontmatter 최소형

```yaml
---
doc_id: <stable-doc-id>
project_id: <stable-project-id>
kind: prd | spec | adr | testcode | runbook | runtime-contract | state-contract | adapter-contract | error-contract
status: draft | working | review | accepted | locked | superseded | archived
version: YYYY-MM-DD.vN
owner: <owner-name>
depends_on:
  - <doc-id>
source_refs:
  - SRC-001
---
```

## 5. 문서 선택 기준

작게 시작한다.

- 제품 의도만 필요하면 `PRD`, `SPEC`, `TESTCODE`, `ADR`만 쓴다.
- 에이전트가 실행하면 `OPERATING_BOUNDARIES`, `RUNBOOK`을 추가한다.
- 실제 도구 표면이 있으면 `RUNTIME_SURFACE`, `STATE_MACHINE`을 추가한다.
- 외부 도구를 묶으면 `ADAPTER_CONTRACTS`, `ADAPTER_ERROR_CONTRACTS`를 추가한다.
- QA 증거를 자동화하면 `QA_ADAPTER_PROGRAM`을 추가한다.
- 릴리스 판단이 필요하면 `ARCHITECTURE_LOCK`과 release closure 규칙을 추가한다.
