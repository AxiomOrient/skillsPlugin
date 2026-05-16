---
name: analyze-product-direction
description: "[analyze] 제품, 기능, 문서, 패키지, 도구를 만들지 말지 또는 어느 방향으로 좁힐지 판단합니다. 구현 전에 사용자 가치, 가장 큰 위험, 확인 방법을 정해야 할 때 사용합니다."
---

# Analyze Product Direction

Clarify the problem, challenge assumptions, and force one bounded future direction. The target can be an app, library, CLI, spec package, skill pack, plugin bundle, static site, or operational workflow.

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

## Output Rules

Default to concise Korean unless the user requests another language.

- Start with the decision.
- Keep the default answer to 2-4 plain sentences for simple calls.
- For complex or high-ambiguity choices, use short bullets for:
- `Direction`
- `Why`
- `Main risk`
- `Proof needed`
- `Rejected alternative`
- Do not produce a P0/P1/P2 roadmap. Roadmaps belong to identity repair or implementation planning after a direction is chosen.

## Scope Boundary

- This skill answers: "Which future product, project, or artifact direction should we choose?"
- `analyze-product-identity` answers: "What is this existing project or artifact actually, and where does its current implementation or package surface lose trust?"
- `plan-implementation-scope` answers: "How should we implement an already chosen bounded change?"

Use this skill for future choices such as:

- whether to build, pivot, remove, launch, reposition, or narrow a feature
- choosing between competing product bets, audience positions, package shapes, or primary surfaces
- deciding the smallest direction worth validating before implementation, documentation renewal, or packaging
- choosing whether an artifact should be an app, CLI, library, skill pack, spec pack, website, integration, or archived deliverable

Do not use this skill for:

- current product identity reverse engineering
- implemented value, package-trust, or user-trust diagnosis of an existing repo
- direct code changes, bug fixes, cleanup, or implementation plans

## Non-Match Handling

If the request asks what an existing project actually is, who it currently serves, what value is already implemented, or where users lose trust in the current implementation, stop and route to `analyze-product-identity`.

If the request is already implementation-ready or is only about code mutation, stop and route to the relevant implementation or planning skill.

When not matching, answer briefly:

- why this skill is not the right lane
- which skill or missing condition should come first

## Accuracy Guardrails

- Do not invent a market, audience, or product bet that is not grounded in user input or checked repository evidence.
- Treat "product" as delivered value for a consumer or operator, not as a requirement that the target be a commercial app.
- Stay language- and platform-neutral. Do not assume Go, Rust, Node, web, mobile, CLI, or server architecture unless evidence requires it.
- If the user gives no alternatives, compare at most two conservative alternatives derived from the observed problem.
- If this follows an `analyze-product-identity` pass, use the identity findings as evidence and avoid re-auditing the whole project unless a direction claim depends on missing facts.
- For multi-project requests, keep each project decision separate. Do not transfer users, risks, or priorities from one repository to another.
- For non-app repositories, frame the choice around the artifact's real job: install, validate, teach, specify, distribute, integrate, or operate.
- Prefer "not enough evidence to choose" over a confident direction when the problem, user, or success proof is missing.

## Evidence Rules

- Ground the direction in the user's stated goal and any repo facts actually checked.
- If the direction concerns an existing repository or artifact folder, inspect the smallest relevant source, docs, config, schemas, tests, package metadata, examples, or execution/validation path before judging.
- If no repository, package, execution, or validation evidence is checked, explicitly label the call as based on user-stated assumptions.
- Mark unknowns as assumptions instead of filling gaps with product guesses.
- Stop if the request already names an implementation slice rather than a product direction choice.

## Mental Model

- Problem first: what user or operator problem actually needs to exist?
- Consumer-value first: what durable value would this direction create for the person or system that consumes it?
- Constraint first: what repository, artifact, runtime, packaging, or process constraint narrows the choice?
- Risk first: what is the single biggest way this direction could be wrong?

## Workflow

1. Clarify the user, problem, and desired outcome.
2. Separate facts from assumptions.
3. Compare the smallest credible alternatives.
4. Pick one bounded direction.
5. Name the main risk and the smallest proof needed.
6. Stop before roadmap or implementation planning.
