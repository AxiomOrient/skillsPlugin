---
name: execute-ux-ui-improvement
description: "[execute] 이미 수락된 UX/UI 분석 결과나 개선 룰을 실제 코드와 화면에 적용합니다. 접근성, 반응형 레이아웃, 상태 처리, 내비게이션, 폼, 시각 계층을 동작 보존 범위에서 개선할 때 사용합니다."
---

# Execute UX/UI Improvement

Use this skill after a UX/UI audit, design rule, screenshot target, or concrete improvement request has already selected the change direction.

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

## Preconditions

Before editing:
- Identify the accepted UX/UI rule or finding being implemented.
- Inspect the current component/view/state ownership and nearest local patterns.
- Confirm the primary user task and the platform target.
- Lock the evidence chain: accepted finding -> current UI/code owner -> verification proof.
- If the request is still asking what should improve, route to `analyze-ux-ui-improvement` first.
- If the request asks for an essential-outcome, core-path, or minimal general-user redesign rather than one accepted finding, route to `orchestrate-essential-ux-refactor`.
- If the accepted finding, owner, or proof is unclear, read `references/auto-research.md` before editing. Skip auto-research when one finding, one owner, and one proof are already clear.

## Implementation Rules

1. Preserve behavior unless the accepted finding explicitly changes it.
2. Prefer local design-system components, platform-native controls, and existing state patterns.
3. Improve accessibility while changing UI: labels, focus order, target size, contrast, dynamic type/reflow, reduced motion, keyboard/screen-reader path.
4. Add missing states when the UI implies them: loading, empty, error, success, blocked, completed.
5. Keep layouts responsive: avoid fixed-width text traps, horizontal reading on compact screens, and overflowing button rows.
6. Connect visible controls to real actions or de-emphasize them. Remove only when caller/search evidence proves the control, state, route, fixture, and documented workflow are not required.
7. Avoid decorative complexity that competes with the top task.
8. Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
9. A better UI patch makes the accepted task easier, safer, or more accessible; more visual changes, more components, or longer explanation are not better by default.
10. If the improvement would make behavior, state ownership, or verification less clear, narrow the visual change or route back to analysis.

## Workflow

1. Map each accepted finding to files/components.
2. Build a preservation list for existing controls, states, routes, helpers, tests, fixtures, and screenshots affected by the target surface.
3. Make the smallest coherent UI change.
4. Keep view files small; extract dedicated subviews before bodies become hard to scan.
5. Add or update previews, fixtures, tests, or screenshot artifacts when practical.
6. Run the relevant build/test/lint commands and render/screenshot the changed UI when visual correctness matters.
7. Report changed surfaces, verification, and any remaining product decision.

## SwiftUI-Specific Defaults

- Prefer `@State`, `@Binding`, explicit inputs, and `@Environment` over new view models.
- Use `.sheet(item:)` for mutually exclusive modal state.
- Prefer `NavigationStack`, `TabView`, `ViewThatFits`, `LazyVGrid`, and platform controls over custom routing or hardcoded dimensions.
- Extract repeated or stateful sections into dedicated `View` types.
- Keep button actions as named methods when they do more than direct parent callbacks.

## Output

Keep the final response short:
- what changed
- why it improves the accepted UX/UI rule
- verification run
- remaining risk only if real
