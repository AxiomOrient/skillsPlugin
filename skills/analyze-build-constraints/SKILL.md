---
name: analyze-build-constraints
description: "[analyze] 제품, 기능, 앱, CLI, 라이브러리, 스킬, 플러그인을 만들기 전에 1-page north star, 고객 job, 분리 가능한 core tech/IP, 사용자에게 보이는 defining constraint, feature creep 위험, 검증 증거로 빌드/보류/축소/폐기 여부를 판정합니다. 사용자가 '만들어도 되나', '빌드 전 검토', 'one pager', '원페이지', '핵심 제약', '제품 정체성', 'feature creep 방지', '이 아이디어를 구현해도 되는지'를 요청할 때 사용합니다."
---

# Analyze Build Constraints

빌드 전에 아이디어를 하드 게이트로 걸러 하나의 증거 기반 결정을 냅니다. 결과물로 반드시 한 페이지짜리 Markdown 문서를 저장합니다.

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

## Scope Boundary

Use this skill for pre-build product judgment, not implementation.

- Use for new products, features, tools, apps, libraries, skills, plugins, workflows, or content products before committing to build.
- Use when the user wants a concise one-page build/no-build decision artifact.
- Use when feature creep, product identity, reusable IP, or a defining product constraint is the central concern.
- If an existing repository's actual identity is unknown, first use `analyze-product-identity` or inspect the minimum evidence needed before judging.
- If the future direction itself is still broad and no build candidate exists, use `analyze-product-direction`.
- If the build direction is already accepted and only implementation scope is needed, use `plan-implementation-scope`.
- If the user asks for code changes, stop after the decision unless they explicitly ask for a separate implementation pass.

## Evidence Rules

Accuracy is more important than confidence.

- Separate `[FACT]`, `[INFERENCE]`, `[JUDGMENT]`, and `[UNKNOWN]` in working notes and the saved one-pager when ambiguity matters.
- Do not invent a market, user, competitor, technical moat, or validation result.
- Ground claims in user-provided context, repository evidence, existing docs/specs/tests, prototypes, analytics, interviews, or cited external sources.
- If external facts materially affect the decision, verify them with current sources and include source links in the saved one-pager.
- Prefer primary sources for company/product/API claims and academic or credible industry sources for general product claims.
- Treat missing evidence as `unknown`; do not turn unknowns into optimistic assumptions.
- If the idea cannot pass a gate because evidence is missing, choose `리서치 먼저` or `범위 축소 먼저`, not `빌드`.
- Do not use the original "3 constraints" idea as dogma. Use it as a gate, then test it against evidence.

## Mental Model

Judge the idea through constraints that reduce search space without hiding truth.

- User job first: a build must serve a real user progress, not just express a solution idea.
- One-page clarity first: if the idea cannot fit one honest page, it is either too unclear or too broad.
- Leverage first: the work should create reusable core tech, method, data, or interface that survives product pivots.
- Visible identity first: one defining constraint should shape the user's experience and reduce product scope.
- Feature creep resistance first: a good product rejects attractive features that do not serve the north star.
- Proof before build: the next action should be the cheapest evidence that can change the decision.

## Gates

Evaluate every gate as `pass`, `risk`, or `unknown`.

### 1. One-Page North Star

The idea must fit one lean page without hiding the hard parts.

Check:
- user or consumer
- job or problem
- promised before-to-after change
- primary surface
- non-goals
- success proof
- main risk

Fail or mark risk when the one-pager needs filler, multiple unrelated audiences, several product identities, or vague value claims.

### 2. Customer Job

The idea must answer why a real user would choose this over doing nothing or using an existing alternative.

Check:
- specific situation
- current workaround or competing alternative
- outcome the user wants
- why this is meaningfully faster, easier, cheaper, safer, clearer, or more reliable

Mark `unknown` when the user/job comes only from speculation.

### 3. Core Tech / IP Separability

The product should create or refine something reusable that is not identical to the product wrapper.

Valid core assets include:
- library, engine, algorithm, model, schema, parser, protocol, dataset, benchmark, adapter, design system, operational method, evaluation rubric, or repeatable workflow

Check:
- can it survive if the product pivots?
- can it support a second product, integration, or internal workflow?
- does it align with the user's or organization's long-term direction?
- does it have a clear boundary or interface?

If no separable core asset exists, choose `core tech 먼저 추출` or `빌드하지 않음` unless the user explicitly accepts a one-off product.

### 4. Defining Constraint

One constraint must be visible to the user and must shape the product's identity.

Good constraints:
- reduce possible features
- make the product feel distinct
- guide UI, copy, API, workflow, pricing, packaging, or interaction design
- are easy to explain in one sentence

Weak constraints:
- internal-only implementation preferences
- generic values like "simple", "fast", or "AI-powered"
- constraints that users never see
- constraints that create confusion rather than focus

### 5. Feature Creep Resistance

Reject features that do not support the one-page north star, customer job, core tech, or defining constraint.

Check:
- top 3 excluded features
- why each is excluded now
- whether each belongs in "later", "advanced", "separate product", or "never"

If the idea cannot reject plausible features, mark this gate `risk`.

### 6. Proof Target

Name the smallest evidence that can change the decision.

Examples:
- one user interview pattern
- clickable prototype test
- smoke landing page
- benchmark
- repository spike
- API feasibility check
- manual workflow trial
- concierge test

Do not recommend implementation when the cheapest next proof is clearly research, prototype, or narrowing.

## Decision Rules

Choose exactly one decision.

- `빌드`: all gates pass or risks are named and acceptable; the next proof can happen inside a small implementation slice.
- `리서치 먼저`: user/job, alternative, market, feasibility, or proof target is unknown.
- `범위 축소 먼저`: value exists but the one-pager has multiple audiences, surfaces, or product identities.
- `core tech 먼저 추출`: product wrapper is weak but reusable core asset is promising.
- `빌드하지 않음`: the idea fails core value, separability, defining constraint, or feature creep resistance with no cheap proof likely to reverse it.

Prefer a conservative non-build decision when evidence is weak.

## Markdown One-Pager Output

Always save a Markdown one-pager.

- If the user gives a path, write there.
- Otherwise write `build-constraints-one-pager.md` in the current workspace or target repository root.
- If that file already exists and the user did not ask to overwrite it, write `build-constraints-one-pager-YYYYMMDD-HHMM.md`.
- If the target itself is a skill folder, write generated one-pagers outside the skill package unless the user explicitly asks to store the report inside that folder.
- Keep it to about one printed page: normally 400-800 words.
- Use [assets/one-page-template.md](assets/one-page-template.md) as the shape.
- Include source links when external sources were used.
- Save a one-pager for identified ideas even when the decision is `리서치 먼저`, `범위 축소 먼저`, `core tech 먼저 추출`, or `빌드하지 않음`.
- In the final response, link the saved file and state the decision.

## Workflow

1. Fix the target idea and output path.
2. Gather the smallest sufficient evidence. Inspect local repo/docs/tests when the target already exists.
3. Verify external facts when they materially affect the decision.
4. Draft or evaluate the one-page north star.
5. Score the six gates as `pass`, `risk`, or `unknown`.
6. Apply the decision rules conservatively.
7. Write the one-page Markdown file.
8. Answer with the decision, saved path, and the single proof that matters next.

## Stop Conditions

Stop without writing the one-pager only when:

- the target idea cannot be identified
- the one-page output path cannot be written

For all other evidence gaps, write the one-pager with `Decision: 리서치 먼저` or the appropriate conservative non-build decision, and mark the affected gates as `unknown`.

Do not fill evidence gaps with polished strategy language.
