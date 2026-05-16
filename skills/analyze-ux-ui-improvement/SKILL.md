---
name: analyze-ux-ui-improvement
description: "[analyze] UX 법칙, 사용성 휴리스틱, 접근성 기준, 플랫폼 가이드, 대상 제품 증거를 근거로 UX/UI 개선 룰을 만들고 화면, 앱, 웹, 도구의 개선 가능성을 분석할 때 사용합니다."
---

# Analyze UX/UI Improvement

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

## Scope

Use for:
- writing target-specific UX/UI improvement rules or design principles
- auditing a repository, screen, prototype, screenshot, or implemented app UI
- deciding whether a visual/UI change is genuinely useful or just decorative
- resolving conflicts between UX laws, aesthetics, platform conventions, accessibility, and product goals

Do not use for:
- pixel-perfect screenshot comparison alone; use `compare-ui-screenshots`
- direct implementation without analysis; hand off to an execute/refactor skill after findings are accepted
- explicit essential-outcome, core-path, or minimal general-user redesign requests; use `orchestrate-essential-ux-refactor`
- generic design inspiration without product/user/task evidence

## Required Reference Loading

Read only what the task needs:

- When the target is broad, ambiguous, or evidence-poor: read `references/auto-research.md` first to choose the audit surface.
- For any audit or rules document: read `references/principles.md`.
- When sources conflict or the user asks for high-quality rationale: read `references/evidence-and-conflicts.md`.
- When producing a project audit: read `references/audit-rubric.md`.
- When the task focuses on forms, checkout, onboarding, or data entry: read `references/forms-and-input.md`.

## Decision Standard

Do not make a "hybrid" compromise that averages conflicting theories. Pick the design that best protects the user's task.

Priority order:
1. Task completion, safety, accessibility, and legal conformance.
2. User mental model and domain language.
3. Platform and industry conventions.
4. Cognitive effort, scanability, and decision load.
5. Efficiency for repeated use.
6. Aesthetic polish and brand expression.

If a lower-priority principle conflicts with a higher-priority one, reject or constrain the lower-priority idea.

## Workflow

1. Identify the primary user, top task, risk level, and target platform.
2. If the target is broad, run the auto-research gate and lock one audit surface before applying UX theory.
3. Inspect the smallest credible evidence: screenshots, views/components, routes, forms, labels, navigation, loading/error states, accessibility affordances, and tests/previews. When scanning a repository for UI surfaces, exclude runtime artifacts such as build output, caches, coverage output, compiled output, dependency installs, editor/tool local state, and archive metadata.
4. Convert broad laws into target-specific rules. Rules must be observable and testable, not slogans.
5. Audit the product against those rules.
6. Prioritize findings by user harm and implementation leverage.
7. Output a concise verdict and a small set of concrete next changes.

## Output Shape

For a project audit:

- `Verdict`: improve / hold / redesign needed
- `Top task`: the task this UI must optimize
- `Rules used`: 5-9 target-specific rules
- `Findings`: ordered by severity, each with evidence, violated rule, and specific change
- `Conflicts resolved`: name the rejected alternative and why
- `Validation`: how to prove the improvement worked

For a rules document:

- `Principles`: durable UX/UI rules
- `Do`: concrete implementation guidance
- `Avoid`: tempting but harmful patterns
- `Evidence`: cite source families, not long quotes
- `Proof`: metrics, user tests, accessibility checks, or screenshot checks

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Prefer primary sources and standards: W3C/WAI, platform HIG, official design systems, NN/g, GOV.UK, Microsoft Inclusive Design, and well-documented empirical UX research.
- Treat Laws of UX as an index of useful lenses, not as a source of absolute rules.
- Never recommend delight, novelty, motion, or density if it harms comprehension, operability, recoverability, or accessibility.
- Make recommendations fit the product type: operational tools should optimize scan, repeat action, low ambiguity, and recovery; marketing pages can spend more on persuasion and emotional hierarchy.
- Do not claim a finding is proven when only a screenshot or static code read was available; name the missing runtime, accessibility, or user-task proof.
