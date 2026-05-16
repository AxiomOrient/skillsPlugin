# Authoring Checklist

이 파일은 질의응답, 작성, 정합성 검토 순서를 정한다.

## 1. 질문 세트

필요한 것만 묻는다. 한 번에 1~3개를 넘기지 않는다.

### Product identity

- 이 패키지가 다루는 대상은 무엇인가?
- 최종 사용자는 누구인가?
- 성공하면 사용자의 상태가 어떻게 달라지는가?

### Source of truth

- 제품 의도와 요구사항의 정본은 무엇인가?
- trace 상태의 정본은 무엇인가?
- 실제 구현 동작의 정본은 무엇인가?
- 릴리스 go/no-go의 정본은 무엇인가?

### Human vs agent

- 사람이 승인해야 하는 결정은 무엇인가?
- 에이전트가 자율적으로 실행해도 되는 작업은 무엇인가?
- 에이전트가 절대 승인하면 안 되는 것은 무엇인가?

### Adapter

- 이미 있는 도구나 프로젝트는 무엇인가?
- 새로 만들지 말고 재사용해야 하는 것은 무엇인가?
- 필요한데 아직 없는 adapter는 무엇인가?
- 없는 adapter 중 지금 구현할 것과 지금 구현하지 않을 것은 무엇인가?

### QA and release

- 어떤 target type을 먼저 검증할 것인가?
- 어떤 증거가 없으면 QA gate가 닫히면 안 되는가?
- 어떤 gate가 실패하면 release가 fail-closed 되어야 하는가?
- waiver는 누가, 언제, 어떤 범위로 승인할 수 있는가?

## 2. 작성 규칙

- `PRD`는 intent와 source register만 둔다.
- `SPEC`는 관찰 가능한 requirement와 acceptance를 둔다.
- `ADR`은 하나의 비싼 결정을 둔다.
- `TESTCODE`는 oracle과 evidence target을 둔다.
- `RUNBOOK`은 precondition, action, expected observation, stop condition,
  rollback, evidence를 둔다.
- `RUNTIME_SURFACE`는 command/API, reads, writes, stop rule을 둔다.
- `STATE_MACHINE`은 상태와 전이만 둔다. 상태는 source of truth가 아니라
  derived read model이어야 한다.
- `ADAPTER_ERROR_CONTRACTS`는 error code, gate status, retryable, next action을 둔다.

## 3. 요구사항 품질

좋은 요구사항 형식:

```text
When <trigger>, the system shall <observable response>.
If <condition>, the system shall <observable response>.
While <state>, the system shall <observable response>.
```

각 `REQ-*`에는 있어야 한다.

- PRD seed
- trigger/condition
- expected response
- failure/rejection
- source refs
- acceptance or verification
- test refs

## 4. TESTCODE 품질

각 `T-*` oracle에는 있어야 한다.

- observable subject
- expected value or relation
- comparison method
- evidence artifact
- rejection condition

금지:

- 요구사항을 반복만 하는 테스트
- 증거 없는 pass
- SPEC에 없는 행동을 만드는 테스트

## 5. 정합성 검사

문서 패키지를 끝내기 전 확인한다.

| Check | Pass condition |
|---|---|
| source register | every `SRC-*` used by docs is registered |
| seed trace | every `REQ-*` maps to `RS-*` |
| test trace | every `T-*` maps to existing `REQ-*` |
| authority | no duplicate truth owner for the same topic |
| human boundary | human-only decisions cannot be auto-approved |
| adapter boundary | adapters emit evidence; they do not own requirements |
| runtime surface | command/API outputs do not become product truth |
| state machine | state is derived and recomputable |
| error contract | failures map to gate status and next action |
| QA | missing coverage is not pass |
| release | missing/failed/blocked/invalidly-waived evidence blocks release |
| implementation status | `구현 필요` and `지금 구현은 하지 않는다` are not confused |

## 6. 최종 판정 문구

최종 답변에는 아래를 짧게 포함한다.

- 문서 패키지 상태: draft, working, accepted, locked 중 하나
- 정본 문서와 보조 문서
- 구현 가능한 범위
- 구현 필요로 남은 범위
- 검증한 정합성 항목
