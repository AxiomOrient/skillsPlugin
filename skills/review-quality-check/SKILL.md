---
name: review-quality-check
description: "[review] 정해진 범위의 품질을 리뷰합니다. 버그 위험, 테스트 약점, 유지보수 문제, 변경 여파를 표준 체크리스트로 확인할 때 사용합니다."
---

# Review Quality Check

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
Check code quality against a fixed checklist without replacing final review judgement.

This skill is **review-only**. It must not patch code.

## Use This When
- the team needs the fixed quality checklist evaluated
- the team needs explicit pass, risk, or unknown output across standard quality dimensions
- the checklist should exist before or alongside a final review

## Do Not Use This When
- the main job is direct code implementation
- the task needs one narrow scan instead of the full checklist
- the team only wants the final integrate or hold verdict

## Non-Match Handling

If the request is implementation work or the bounded review surface is missing, stop immediately.

- 첫 문장에서 바로 이 스킬 대상이 아니라고 말합니다.
- 첫 문장은 아래 뜻이 그대로 드러나야 합니다:
  이 요청은 `review-quality-check`가 아니라 `execute-bounded-change`로 처리해야 합니다.
- 구현 요청이면 리뷰가 아니라 수정 작업이라고 짧게 설명합니다.
- 더 맞는 스킬은 하나만 짧게 말합니다.
- SKILL.md, AGENTS.md, sandbox, write probe 같은 내부 근거는 사용자가 왜 그런지 따로 물을 때만 말합니다.

## Inputs
- bounded review scope such as diff, file, module, folder, or repo
- intended behavior or maintenance goal
- optional supporting tests, benchmarks, or issue context

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Correctness: pass | risk | unknown`
- `Clarity: pass | risk | unknown`
- `Simplicity: pass | risk | unknown`
- `Boundary Respect: pass | risk | unknown`
- `Error Handling: pass | risk | unknown`
- `Security: pass | risk | unknown`
- `Testability: pass | risk | unknown`
- `Performance: pass | risk | unknown`
- `Goal Fit: pass | risk | unknown`
- `Material risks: ...`
- `Next checks: ...`

## Fixed Checklist
- Correctness
- Clarity
- Simplicity
- Boundary Respect
- Error Handling
- Security
- Testability
- Performance
- Goal Fit

## Mental Model
검토할 때는 실제 위험이 있는지부터 봅니다.
- Run the same fixed checklist every time.
- Use pass, risk, or unknown only.
- Mark missing evidence as unknown instead of forcing a verdict.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- Do not inflate the report with low-risk style notes; call out only risks that affect correctness, maintainability, verification, or goal fit.

## Workflow
1. Read the goal, scope, and available evidence.
2. Evaluate each fixed checklist item against observable evidence.
3. Mark each item as pass, risk, or unknown.
4. Call out only material risks separately.
5. List the cheapest next check for every unknown item.

## Stop Conditions
- the scope is too vague to inspect
- the intended goal is missing
- the checklist would depend on invented evidence

## Boundaries
This skill does **not**:
- collapse the checklist into a generic merge verdict
- patch code or rewrite tests
- treat taste-only comments as material risk
