---
name: review-project-completion
description: "[review] 프로젝트가 정해진 목표를 실제로 만족하는지 검토합니다. 요구사항, 구현, 테스트, 문서가 서로 맞는지 보고 완료/미완료/차단 상태를 판단할 때 사용합니다."
---

# Review Project Completion

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

## Purpose

Produce one evidence-backed completion verdict for one project or one clearly bounded subsystem.

This is a review-only skill.
Do not silently implement missing work unless the user explicitly asks for a separate repair pass.

## Read First

1. [references/REVIEW_RUBRIC.md](references/REVIEW_RUBRIC.md)
2. [assets/review-checklist.md](assets/review-checklist.md)
3. [assets/review-report-template.md](assets/review-report-template.md)

## Use This Skill When

- review whether a project is actually complete within the defined scope
- decide whether a project deserves a completion or release-ready label
- audit scope closure, spec consistency, or document-to-code alignment
- identify blockers that prevent calling the work complete
- produce an evidence-backed completion report instead of a vague summary

## Do Not Use This Skill When

- implement or repair missing functionality
- perform a narrow PR review or bug investigation
- write roadmap or prioritization advice
- assess market fit, adoption, or product strategy
- judge progress without access to project artifacts

## Required Evidence

Read as many of the following as are available:

- project overview
- goal or problem definition
- requirement documents
- spec documents
- design documents
- task or plan documents
- implementation code
- test code
- README, deployment docs, and operating docs
- other attachments that materially define scope or operation

If a required artifact is missing, record the gap explicitly and explain which judgment becomes weaker because of that gap.

## Core Review Rules

- Do not guess.
- State document-to-code conflicts explicitly.
- Classify unimplemented requirements as `미완성`.
- Classify core functionality without meaningful tests as `검증 불충분`.
- Distinguish a working demo from production-complete delivery.
- Surface hardcoding, temporary bypasses, or manual runbooks that block operational completeness.
- Prefer `근거 부족` over invented certainty.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A concise blocker with traceable evidence is more valuable than a long report that blurs requirements, implementation, tests, and risk.

## Workflow

1. Fix the review boundary.
   Review one project or one clearly bounded subsystem. Refuse scope drift.
2. Inventory the evidence.
   List which source artifacts exist, which are missing, and which sources define truth.
3. Build the trace map.
   Map goals, requirements, specs, plans, tasks, code, tests, and operating docs before scoring.
4. Evaluate each review dimension.
   Use the checklist and rubric to assess scope, documentation, architecture, functionality, errors, tests, operations, and unresolved risks.
5. Review core user flows end to end.
   Check whether the main flows are closed across requirement, implementation, failure handling, and verification.
6. Assign the final verdict.
   Use `완성됨`, `거의 완성됨`, `부분 완성`, or `미완성` only when the available evidence supports it.
7. Write the report in the required format.
   Preserve the eight output sections from the template and keep every claim evidence-backed.

## Output Contract

Write the final review using the exact section structure from [assets/review-report-template.md](assets/review-report-template.md).

The report must include:

- one final verdict and one-sentence reason
- a 0-5 score for each required evaluation dimension
- a requirement traceability matrix grounded in documents, code, and tests
- a severity-ordered list of key missing items
- a separated document-to-code mismatch section
- only true blockers in the blocker section
- a minimum completion checklist
- a concise final conclusion grounded in evidence

## Stop Conditions

Stop and say `근거 부족` for the affected area if:

- the review boundary cannot be identified
- required artifacts cannot be found or read
- requirements cannot be mapped to implementation
- tests cannot be tied to the claimed functionality
- the available evidence cannot support a reliable verdict

## Final Rule

Do not hide missing evidence, missing implementation, or unresolved risk behind soft language.
If the project is not complete, say so directly and show why.
