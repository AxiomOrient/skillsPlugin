---
name: orchestrate-essential-ux-refactor
description: "[meta] 핵심 사용자 결과 중심 UX 리팩터링을 분석, 계획, 실행, 검증 스킬로 라우팅합니다. 사용자가 핵심 흐름, 일반 사용자용 단순화, progressive disclosure, reduced clutter처럼 제품 표면을 핵심 작업 중심으로 재구성하길 원할 때 사용합니다."
---

# Orchestrate Essential UX Refactor

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

## Non-Match Handling

- If the user asks for a UX/UI audit, rules, heuristics, accessibility review, or improvement opportunities, use `analyze-ux-ui-improvement`.
- If the user has accepted a specific UX/UI finding and wants it implemented, use `execute-ux-ui-improvement`.
- If the user asks only for screenshot comparison, use `compare-ui-screenshots`.
- If the work changes product behavior beyond presentation and state treatment, use `execute-product-completion` for that slice.

## Prompt Contract

Use an outcome-first working prompt:

```text
Goal:
- [user-visible outcome]

Success criteria:
- [what must be true before final answer]

Constraints:
- [product truth, safety, business, accessibility, side-effect limits]

Available evidence:
- [screens, code, docs, analytics, tests, screenshots, user report]

Output:
- [decision, plan, patch summary, or review findings]

Stop rules:
- stop when the core path and next action are evidence-backed
- stop before guessing about users, markets, or hidden requirements
- ask only for the smallest missing input that cannot be retrieved
```

Keep prompts short. Add detail only when it changes behavior. Use absolute rules only for true invariants.
Before finalizing a plan or implementation, run a lightweight validation loop:
requirements satisfied, claims grounded in evidence, requested output shape followed, and no irreversible or contract-changing action taken without approval.

## Route

Choose one lane:

- Current product/user/value unclear -> use identity analysis before UX decisions.
- Future direction unclear -> choose one product direction before design.
- Desired UX clear but implementation scope broad -> write a work spec or implementation scope.
- Target screen known and code available -> implement one user-visible slice and verify it.
- UI already changed -> review against the essential-UX checklist.

Good companion skills:

- `analyze-product-identity`
- `analyze-product-direction`
- `analyze-ux-ui-improvement`
- `author-work-spec`
- `plan-implementation-scope`
- `execute-ux-ui-improvement`
- `execute-product-completion`
- `imagegen`
- `browser-use`
- `compare-ui-screenshots`
- `qa-change-scenarios`
- `review-quality-check`

For the detailed reusable prompt chain, read `references/workflow-prompts.md`.

## Auto-Research Gate

Before implementation, run auto-research when any of these are unclear:

- primary user
- first success path
- current screen owner
- acceptance criteria
- proof method
- whether a requested simplification would hide truth or remove required functionality

Read `references/auto-research.md` when the work is broad, ambiguous, or evidence-poor. Skip it when one requirement, one target surface, and one proof command/scenario are already clear.

Auto-research must produce one evidence chain:

```text
user need or confirmed failure -> current UI/code owner -> verification proof
```

If the chain is incomplete, do not implement. Return `blocked` or `근거 부족`.

## Preservation Gate

Before editing code, build a preservation ledger for the target surface:

- Existing user-facing functions, routes, controls, states, and helper functions.
- Existing tests, fixtures, snapshots, stories, screenshots, or examples that exercise them.
- What must stay visible, what can move to advanced/detail, and what is truly dead.

Default action is `keep` or `move`, not delete. Removing code, helper functions, controls,
routes, endpoints, states, tests, fixtures, or documentation is allowed only when all are true:

- Evidence shows it is unreachable, duplicated by the canonical implementation, or outside the accepted scope.
- A local search proves no remaining caller, route, test, fixture, or documented workflow depends on it.
- The replacement path and verification command are named before the edit.
- The removal does not change public contracts, product truth, permissions, schemas, or power-user access.

If those checks are not complete, preserve the existing function and adapt it, or move the UI
behind progressive disclosure. Do not make a UI look simpler by deleting unverified behavior.

## Core Model

Define these before changing UI:

1. Primary user: one concrete user segment, not "everyone".
2. Core job: what the user came to accomplish.
3. First success path: the shortest path from arrival to meaningful success.
4. Trust object: the thing the user must believe, such as booking, payment, file, result, completion, safety, or evidence.
5. Primary state: the one state the first screen should make obvious.
6. Primary action: the one action that should visually dominate.
7. Secondary actions: useful but not first-path actions.
8. Advanced material: proof, configuration, raw data, expert controls, logs, and internal IDs.

## Essential UX Design Rules

Apply these rules to any product, not only developer tools:

- Show the outcome before showing controls.
- Show meaning before showing metrics.
- Show the next action before showing secondary options.
- Prefer one dominant state, one primary action, and one visible next step per screen.
- Move expert settings, audit data, logs, raw JSON, IDs, diagnostics, configuration, and rarely used controls behind progressive disclosure.
- Preserve power-user access when it is part of the product value.
- Reduce duplicated controls, decorative noise, nested panels, and labels that do not help user progress. Remove only after the Preservation Gate passes.
- Reduce visible choices until the first success path is obvious.
- Make empty, loading, success, warning, blocked, failed, and permission states first-class.
- Every non-success state needs a cause, user meaning, and next action.
- Use plain copy. Replace implementation terms with user meaning.
- Keep visual hierarchy calm: restrained type scale, stable spacing, no card nesting, no decorative clutter.
- Do not create a marketing landing page when the user needs a working product surface.

## Truth Rules

Do not make the product simpler by making it less true.

- Do not hide uncertainty as success.
- Do not hide risk, missing evidence, failed verification, billing impact, permission limits, or irreversible effects.
- Do not remove required controls just to make the screen look clean.
- Do not add fake state, fake progress, fake confidence, or silent fallback.
- Do not change public contracts, permissions, data authority, schemas, dependencies, payments, security semantics, or irreversible workflows without an explicit decision artifact.
- Do not add write/run/delete/send/purchase actions unless the product contract already permits them.
- Do not delete helper functions, shared utilities, tests, fixtures, routes, or state handlers as a cosmetic shortcut.
- Do not replace a canonical helper with an inline duplicate. Reuse or extend the existing helper.

## Workflow

1. Diagnose identity.
   - Use `analyze-product-identity` when the current user-facing value, first success path, or trust loss is unclear.

2. Choose direction.
   - Use `analyze-product-direction` when there are competing futures such as dashboard-first, guided workflow-first, or expert mode plus simple mode.

3. Derive UX/UI rules.
   - Use `analyze-ux-ui-improvement` when the work needs UX laws, heuristics, accessibility, platform guidance, or conflict resolution.
   - Convert broad UX principles into observable project rules before implementation.

4. Author the work spec.
   - Use `author-work-spec` to fix UX goals, non-goals, user flows, screen inventory, behavior, acceptance criteria, and verification.
   - Include the preservation ledger: keep, move, hide, remove, and proof required for any removal.

5. Plan implementation scope.
   - Use `plan-implementation-scope` to split work into small release-safe slices.
   - Prefer slices that change presentation, hierarchy, copy, and disclosure before changing behavior.

6. Implement one slice.
   - Use `execute-ux-ui-improvement` when applying accepted UX/UI findings to layout, accessibility, responsive behavior, state treatment, navigation, forms, or visual hierarchy.
   - Use `execute-product-completion` when the slice also needs product completion work beyond visual/UI treatment.
   - Keep behavior and data contracts stable unless explicitly approved.
   - Reuse existing helpers and local patterns. If a helper seems obsolete, prove it with search and tests before removal.
   - Add/update tests when behavior, rendering, copy contract, state handling, or navigation changes.

7. Generate a reference concept image only when visual comparison needs a target.
   - Use `imagegen` to create a clean reference mockup of the intended screen or feature when no approved reference image already exists.
   - The image is a visual target for review, not a substitute for the implemented UI.
   - Save the reference image if it will be used by `compare-ui-screenshots`.
   - Skip this step when the user supplied an approved reference, when the change is non-visual, or when a text/work-spec proof is sufficient.

8. Compare UI screenshots.
   - Render or screenshot the implemented UI.
   - Compare the implemented screenshot against the reference concept image with `compare-ui-screenshots`.
   - If the verdict fails, revise the UI or revise the reference only when the reference conflicts with product truth.

9. Run scenario QA.
   - Use `qa-change-scenarios` to prove first-time, success, blocked, failed, and advanced-detail flows.

10. Review quality.
   - Use `review-quality-check` for final defect and maintainability review.

## Surface Inspection

When inspecting the surface:

   - Identify first screen, navigation, core flow, detail views, settings, advanced areas, error states, and irreversible actions.
   - Use screenshots or browser inspection when visual precision matters.

Classify visible elements:

   - `core`: required for first success.
   - `supporting`: helps trust or comprehension.
   - `secondary`: useful after the first path is clear.
   - `advanced`: expert/debug/audit/config/proof.
   - `risk`: misleading, unsafe, overwhelming, or trust-damaging.
   - `waste`: decorative, duplicated, or unrelated to progress.

Build the information pyramid:

   - Top: outcome, state, next action.
   - Middle: why this is true and what changed.
   - Bottom: proof, details, history, configuration, raw data.

## Output For Planning

Return:

- Core user
- Core job
- First success path
- Current clutter/risk
- Keep / Move / Hide / Remove
- Preservation ledger and deletion proof required
- Proposed screen model
- Acceptance criteria
- Verification plan
- Human call-out risk

## Output For Implementation

Before edits, state:

- Goal
- Non-goals
- Files to change
- Existing helpers/routes/states/tests to preserve or reuse
- Any proposed deletion and its proof, or `none`
- Product truths/invariants to preserve
- Verification proof

After edits, report:

- Changed files
- User-visible change
- What became simpler
- What remained available in advanced/detail paths
- Existing functionality/helpers preserved, moved, or removed with proof
- Invariants checked
- Verification result
- Remaining risks

## Image Reference Rules

Use `imagegen` only for visual reference mockups, hero/product imagery, or bitmap assets. Do not replace repo-native UI implementation with a generated image unless the product genuinely needs a bitmap asset.

When generating a UX reference mockup:

- Base the prompt on the work spec, not on vague taste.
- Include the target viewport, screen type, primary user, primary state, primary action, and advanced disclosure behavior.
- Avoid decorative filler, marketing-style hero sections, fake data, and fake functionality.
- Preserve product truth: if the real product is read-only, the mockup must not show write actions.
- After generation, compare the real implemented screenshot to this reference using `compare-ui-screenshots`.

## Review Checklist

The refactor is not done if any are true:

- A new user cannot tell what the product is for.
- The first screen does not reveal the current state.
- The primary action is visually unclear.
- Too many choices appear before the first success path.
- Internal terms appear where user meaning should appear.
- Empty/error/blocked states lack next actions.
- Expert details dominate the main path.
- Accessibility, text fit, or mobile layout fails.
- The simplification hides a real limitation or risk.
- The change weakens product truth, tests, or public contracts.
- Existing behavior, helper functions, routes, fixtures, or power-user access were removed without explicit evidence and verification.
