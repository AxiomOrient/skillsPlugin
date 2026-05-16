---
name: execute-product-completion
description: "[execute] 구현 계획과 현재 코드 상태를 근거로 남은 제품 구현을 끝까지 처리합니다. 문서화된 요구사항, 검증된 실패, 핵심 사용자 경로를 막는 문제만 작은 단계로 구현하고 검증하며, 블로커는 먼저 해결을 시도하고 해결 불가하면 백로그로 남기거나 치명적이면 사용자에게 확인할 때 사용합니다."
---

# Execute Product Completion

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

문서화된 구현 계획과 현재 코드 상태를 비교해 제품을 완성합니다.

이 스킬은 **source-changing**입니다. 코드를 고치고, 필요한 테스트와 문서를 갱신하고, 검증까지 수행합니다.

## 작업 계약

남은 제품 구현을 문서화된 요구사항, 확인된 실패, 핵심 사용자 경로 blocker에만 묶어서 끝냅니다.

성공 기준:
- 각 단계의 목표, 제외 범위, 완료 조건, 실패 조건, 검증 방법이 구현 전에 분명합니다.
- 각 단계는 `요구사항/실패 증거 -> 구현 소유 파일/모듈 -> 검증 명령/수동 proof`로 추적됩니다.
- 한 단계는 하나의 사용자-visible 결과나 blocker만 해결합니다.
- 변경한 표면은 테스트, 빌드, lint, smoke test, 또는 수동 재현 중 가장 가까운 증거로 검증됩니다.
- 남은 작업은 완료 주장을 깨지 않는 backlog 또는 명확한 blocker로 분리됩니다.

도구가 필요한 작업을 시작할 때는 먼저 사용자에게 1~2문장으로 첫 확인 대상을 알립니다. 현재 단계가 검증되었거나, 다음 변경이 새 기능/정책/큰 리팩터링으로 넘어가거나, 증거가 부족해 더 진행하면 추측이 될 때 멈춥니다.

남은 작업이 넓거나 blocker 출처와 검증 표면이 불분명하면 [references/auto-research.md](references/auto-research.md)를 먼저 읽습니다. 이 reference는 구현 범위를 넓히기 위한 것이 아니라, 요구사항/실패/핵심 경로 증거가 있는 첫 구현 단계 하나로 수렴하기 위한 것입니다. 이미 하나의 파일, 하나의 실패, 하나의 검증 명령이 분명하면 오토리서치를 생략하고 바로 bounded step으로 진행합니다.

## 다른 스킬과의 경계

- `execute-bounded-change`: 이미 정해진 작은 코드 변경 하나를 구현할 때 사용합니다.
- `execute-project-stabilization`: 새 기능 없이 프로젝트를 정리하고 안정화할 때 사용합니다.
- `review-project-completion`: 완료 여부를 검토만 할 때 사용합니다.
- `analyze-root-cause`: 재현된 실패의 원인만 찾고 아직 수정하지 않을 때 사용합니다.
- `plan-implementation-scope`: 구현 전에 범위와 수용 기준만 정할 때 사용합니다.

이 스킬은 구현 계획이 있고, 남은 핵심 제품 동작을 실제로 끝내야 할 때만 사용합니다.

## 허용 작업

아래 중 하나에 해당하는 일만 합니다.

- 문서, 계획, 이슈, 테스트, 코드 주석, 명세에 적힌 요구사항
- 실행, 테스트, 빌드, 수동 재현으로 확인된 실패 수정
- 핵심 사용자 경로를 막는 문제 수정
- 현재 단계 구현에 꼭 필요한 최소 리팩터링
- 변경한 동작을 증명하는 최소 테스트나 문서 갱신

## 금지 작업

아래 작업은 하지 않습니다.

- 문서화되지 않은 새 기능
- 미래 대비용 추상화
- 불필요한 리팩터링
- stub, TODO, mock, 임시 우회, fake success
- warning suppression으로 실패를 숨기기
- 테스트 생략
- 검증 없이 완료 선언
- 근거 없는 UX, 시장, 사용자 가정

기본 방향은 범위를 줄이고, 단순화하고, 기존 동작을 보존하는 것입니다.

## 핵심 원칙

- Reality first: 문서, 코드, 파일 트리, 설정, 스크립트, 실행 결과, 테스트를 먼저 봅니다.
- Small verified steps: 한 단계는 한 목표만 가집니다.
- Correctness first: 논리적으로 필요한 변경만 합니다.
- Traceability first: 요구사항, 구현 위치, 검증 방법이 서로 연결되지 않으면 구현하지 않습니다.
- Single source of truth: 상태, 설정, 스키마, 권한, 식별자, 공개 계약은 한 곳이 주인입니다.
- Boundary first: core logic, state, I/O, persistence, external API, UI, tests를 섞지 않습니다.
- Deterministic design: data-first core, explicit state, idempotent effects를 선호합니다.
- No silent failure: swallowed error, broad catch, silent fallback, shadow path, fake success를 만들지 않습니다.
- Verification gate: 완료는 증거가 있을 때만 말합니다.
- Depth over volume: 많은 파일, 긴 설명, 넓은 diff가 아니라 명확성, 깊이 있는 판단, 건전한 기술 선택, 오래가는 실질 기여를 성공으로 봅니다.
- Durable contribution: 현재 blocker를 닫으면서 다음 유지보수자가 더 쉽게 이해하고 검증할 수 있는 형태를 우선합니다.
- If a requested step would only create visible activity without improving the core path, reduce scope or leave it as backlog.

## 입력

- 구현 계획, 요구사항, 이슈, 완료 기준, 또는 사용자가 지정한 목표
- 현재 저장소 코드와 테스트
- 실행 가능한 빌드, 테스트, lint, format, integration, runtime 명령
- 알려진 실패, 로그, 재현 절차가 있으면 함께 사용합니다.

입력이 부족하면 추측하지 말고 `근거 부족`으로 표시합니다.

## 작업 루프

1. 증거를 먼저 읽습니다.
   - 로컬 지침, 구현 계획, README, 요구사항, manifest, entrypoint, tests, scripts, configs를 확인합니다.
2. 제품 목적, 핵심 사용자 경로, 요구사항, 제약, 완료 조건을 뽑습니다.
3. 현재 상태를 분류합니다.
   - `implemented`
   - `partial`
   - `missing`
   - `broken`
   - `unverifiable`
   - `blocked`
4. 가장 작은 유효 단계를 하나 고릅니다.
5. 단계마다 아래를 먼저 잠급니다.
   - Evidence chain: requirement/failure/core path -> code owner -> proof
   - Goal
   - Non-goals
   - Done condition
   - Failure condition
   - Verification command or proof
6. Evidence chain의 세 칸 중 하나라도 비어 있으면 구현하지 말고 `blocked` 또는 `근거 부족`으로 분류합니다.
7. 그 단계만 구현합니다.
8. 검증합니다.
9. 검증 실패 시 RCA를 짧게 쓰고, 가장 작은 근본 수정 후 다시 검증합니다.
10. 통과한 뒤에만 다음 단계를 고릅니다.
11. 문서화된 요구사항, 검증된 실패, 핵심 경로 blocker가 더 없으면 멈춥니다.

남은 일이 없으면 최종 답변에 `Remaining work: none`을 포함합니다.

## 블로커 처리 규칙

블로커를 만나면 바로 멈추지 말고 먼저 해결책을 찾습니다.

1. 블로커를 분류합니다.
   - dependency missing
   - environment failure
   - failing test or build
   - unclear requirement
   - conflicting requirements
   - missing permission or credential
   - external service unavailable
   - architecture or state invariant conflict
2. 해결책을 찾습니다.
   - 로컬 문서, 설정, 스크립트, 기존 코드, 테스트, 오류 메시지에서 먼저 찾습니다.
   - 현재 정보로 해결 가능하면 수정하고 원래 구현 단계로 돌아갑니다.
   - 수정이 별도 작은 단계라면 먼저 그 단계를 완료하고 검증한 뒤 원래 단계로 복귀합니다.
3. 해결책이 없지만 치명적이지 않으면 백로그에 남기고 다음 구현 단계로 넘어갑니다.
   - 백로그 항목에는 blocker, evidence, attempted fixes, why deferred, required owner or proof를 적습니다.
4. 치명적이면 사용자에게 묻습니다.
   - 더 이상 핵심 사용자 경로 구현을 진행할 수 없을 때
   - 요구사항 충돌로 선택이 필요할 때
   - 필요한 비밀정보, 권한, 외부 시스템 접근이 없을 때
   - 안전하게 우회할 수 없는 데이터 손실, 보안, 호환성 위험이 있을 때

치명적 블로커를 임시 우회하거나 fake success로 넘기지 않습니다.

## 단계 기록 형식

작업 중 내부 기록은 이 형식을 따릅니다. 최종 답변에는 필요한 만큼만 요약합니다.

```text
Step:
Evidence chain:
Goal:
Non-goals:
Mental model:
Files inspected:
Files changed:
Implementation summary:
Verification result:
Problems found:
Root cause:
Fixes applied:
Blockers:
Backlog:
Status: Pass / Needs fixes / Blocked
```

## 검증 규칙

- 저장소가 제공하는 명령을 우선합니다.
- 변경 표면에 가장 가까운 검증부터 실행합니다.
- 그 다음 필요한 경우 더 넓은 build/test/lint/static/integration/runtime 검증을 실행합니다.
- public API, package export, CLI, UI, file format, schema가 바뀌면 외부 사용자 관점의 최소 증명을 추가합니다.
- 넓은 green command는 touched behavior를 실행하지 않으면 약한 증거입니다. 이 경우 더 좁은 missing proof를 이름으로 남깁니다.
- 수동 검증은 실행 절차, 관찰할 성공 신호, 실패 신호가 명확할 때만 proof로 씁니다.
- 검증을 실행할 수 없으면 이유와 대체 증거를 분명히 씁니다.
- 검증 실패는 완료가 아닙니다. RCA, 수정, 재검증이 필요합니다.

## 참고 문서

- `references/auto-research.md`: 남은 제품 구현 범위가 넓거나 검증 표면이 불분명할 때만 읽습니다.

## 설계 규칙

- data-first, pure function core를 우선합니다.
- state가 행동을 지배하면 state, transition, invariant를 명시합니다.
- I/O, persistence, external API, UI, test helper는 core policy와 섞지 않습니다.
- cache, index, view model, generated file, duplicated model은 파생 데이터로 취급합니다.
- retry와 fallback은 관찰 가능하고 정당할 때만 둡니다.
- random ID, timestamp, order-dependent behavior는 꼭 필요할 때만 사용합니다.

## 완료 조건

완료는 아래가 모두 참일 때만 말합니다.

- 계획이나 문서의 요구사항이 코드/테스트/문서와 연결됩니다.
- 완료한 각 단계의 evidence chain이 남아 있습니다.
- 핵심 사용자 경로 blocker가 없습니다.
- 확인된 실패는 수정됐거나 치명적이지 않은 backlog로 분리됐습니다.
- 변경한 표면의 검증이 통과했습니다.
- 남은 `근거 부족` 항목이 완료 주장을 깨지 않습니다.

## 최종 답변 형식

최종 답변은 한국어로 짧게 씁니다. 고정 라벨을 그대로 쓰지 말고, 결론을 먼저 말한 뒤 바뀐 내용, 실행한 검증, 남은 제한이나 backlog만 필요한 만큼 포함합니다.

완료를 주장할 때는 왜 완료인지 의견이 아니라 증거로 말합니다. 검증을 실행하지 못했으면 완료처럼 말하지 말고, 실행하지 못한 이유와 다음으로 가장 정직한 확인 방법을 적습니다.
