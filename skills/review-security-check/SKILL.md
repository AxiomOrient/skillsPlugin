---
name: review-security-check
description: "[review] 정해진 범위의 보안 위험을 리뷰합니다. 인증, 권한, 입력 검증, 비밀정보, 데이터 노출처럼 실제 문제가 될 수 있는 위험을 찾을 때 사용합니다."
---

# Review Security Check

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
Surface concrete security issues and exposure risks in a bounded scope.

This skill is **review-only**. It must not patch code or secrets.

## Use This When
- the team needs a pre-commit or pre-release security pass
- the team needs vulnerability, threat-model, or mitigation-verification output
- the team needs security-specific judgement with prioritized findings

## Do Not Use This When
- the team needs broad always-on hardening advice
- the main job is general debugging or performance analysis
- the main job is direct implementation
- the team needs a broad review verdict rather than security-specific output

## Non-Match Handling

If the request is implementation work, broad hardening backlog work, or has no bounded review scope, stop immediately.

- 첫 문장에서 바로 이 스킬 대상이 아니라고 말합니다.
- 직접 코드나 secret을 바꾸는 요청이면 아래 뜻이 그대로 드러나야 합니다:
  이 요청은 `review-security-check`가 아니라 `execute-bounded-change`로 처리해야 합니다.
- 범위 없는 보안 요청이면 먼저 검토할 파일, diff, 모듈, 또는 저장소 범위가 필요하다고 말합니다.
- 내부 규칙 파일, 샌드박스 상태, 장황한 배경 설명은 사용자가 따로 묻지 않으면 말하지 않습니다.

## Inputs
- bounded target scope
- security goal
- optional sensitive surfaces and known evidence

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Status: pass | risk | inconclusive`
- `Findings: ...`
- `Evidence: ...`
- `Reproduce / verify: ...`

## Mental Model
검토할 때는 실제 위험이 있는지부터 봅니다.
- Start from assets, trust boundaries, and exposure surfaces.
- Separate real vulnerabilities from hardening ideas.
- Mark exploitability as unverified when the evidence is thin.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A concrete exposure with reproduction or proof matters more than a long generic hardening checklist.

## Workflow
1. Read the target scope, security goal, and known evidence.
2. Build the threat model for the bounded scope.
3. Inspect for concrete exposure or vulnerability findings.
4. Separate vulnerabilities, mitigation checks, and false-positive exposure decisions.
5. Report the security status with explicit uncertainty when needed.

## Stop Conditions
- the target scope is too vague to model
- the evidence is too weak to distinguish real exposure from guesswork
- the review would require inventing vulnerability claims

## Boundaries
This skill does **not**:
- patch code or secrets
- turn every hardening idea into a blocker
- treat public config as a secret leak without evidence
