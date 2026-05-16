---
name: analyze-root-cause
description: "[analyze] 이미 재현되거나 일부 재현되는 실패를 코드와 실행 결과로 추적합니다. 바로 고치기 전에 왜 실패하는지 원인과 수정 지점을 분명히 해야 할 때 사용합니다."
---

# Analyze Root Cause

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
Find the smallest honest causal chain that explains a reproduced failure.

This skill is read-only by default. It diagnoses the cause; it does not fix it.

## Use This When
- a stable or partial repro already exists
- the team needs the causal chain before writing the fix
- the failure can be traced through concrete code and evidence

## Do Not Use This When
- the failure is still too fuzzy to reproduce
- the main job is to write the patch now
- the task needs broad architecture review instead of bounded debugging

## Non-Match Handling

If there is no credible repro or the request is really about implementation speed rather than diagnosis, stop immediately.

- For non-reproduced or vague issues:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: provide a stable repro or the failing command first
- For direct implementation work:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-bounded-change or the relevant execute lane

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## Inputs
- repro steps or failing command
- relevant code path
- logs, traces, stack traces, or test failures when available

## 내부 정리 기준
- one root-cause explanation in the response
- optional candidate fix direction when the cause is solid

## Mental Model
판단할 때는 범위, 근거, 빠진 정보를 먼저 봅니다.
- Follow the shortest causal chain that fits the evidence.
- Separate symptom, trigger, and root cause.
- Stop at the first honest cause; do not stack guesses.

## Workflow
1. Read the repro and collect the smallest failing path.
2. Trace the failure through the relevant code and state transitions.
3. Separate trigger, local defect, and upstream cause.
4. Name the smallest causal chain that explains the failure.
5. State the cheapest next proof when the cause is still partial.

## Stop Conditions
- there is no credible repro or failing path to trace
- the evidence only supports multiple unresolved causes
- the explanation would require speculative leaps

## Boundaries
This skill does **not**:
- write the patch itself
- rewrite the task into a broad quality review
- claim certainty when the evidence only supports a candidate cause
