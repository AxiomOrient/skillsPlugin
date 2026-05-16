# Essential UX Refactor Prompt Chain

Use these prompts as reusable starting points. Keep them outcome-first and trim details that are irrelevant to the target product.

## 1. Identity Diagnosis

```text
[$analyze-product-identity]

Goal:
- Diagnose the current user-facing UI/UX from evidence.

Success criteria:
- Identify the real user, first success path, trust-losing points, and first UX repair target.

Evidence:
- README/docs
- UI/browser/app routes or screens
- CLI or onboarding path if relevant
- tests, examples, screenshots, rendered output

Classify:
- needed by general users
- needed only by operators/power users
- needed for first success
- should move to advanced/detail
- damages trust or clarity

Output:
- real user
- first success path
- current UI problem
- core user screen
- advanced/power-user material
- first improvement target

Stop rules:
- stop when first-screen and first-success problems are evidence-backed
- do not choose a future direction yet
```

## 2. Product Direction

```text
[$analyze-product-direction]

Goal:
- Choose one bounded product direction for the general-user experience.

Options:
- outcome dashboard first
- guided workflow first
- simple mode with expert detail disclosure

Decision criteria:
- first user can reach meaningful success quickly
- product truth and authority model remain intact
- expert capability remains available without dominating the first path
- implementation can be sliced safely

Output:
- Direction
- Why
- Main risk
- Proof needed
- Rejected alternative

Stop rules:
- stop after one direction is chosen
- do not write implementation plan
```

## 3. Work Spec

```text
[$author-work-spec]

Goal:
- Write an implementation-ready UX refactor spec.

Product direction:
- General users see what happened, why it matters, and what to do next before seeing internal details.

Required surfaces:
- first screen or landing surface
- detail view
- evidence/details or advanced view
- problem/blocked/failure state

Acceptance criteria:
- the first screen is not dominated by raw/internal details
- state is described in user language first
- every non-success state has a cause and next action
- advanced details remain available but secondary
- product truth and public contracts are preserved
- existing functions, helpers, routes, controls, tests, fixtures, and power-user paths are preserved unless deletion proof is explicit

Output:
- UX goals
- Non-goals
- User flows
- Screen inventory
- Component behavior
- Preservation ledger: keep / move / hide / remove
- Acceptance criteria
- Verification plan
```

## 4. UX/UI Rule Audit

```text
[$analyze-ux-ui-improvement]

Goal:
- Convert UX laws, heuristics, accessibility, and platform guidance into target-specific rules for this refactor.

Inputs:
- accepted product direction or work spec
- target screen/component
- screenshots or rendered UI when available
- product truth and invariants

Constraints:
- choose task completion, safety, accessibility, and product truth over aesthetic simplification
- reduce presentation complexity before removing functionality
- preserve required expert/power-user access through advanced/detail paths

Output:
- Verdict
- Top task
- Rules used
- Findings ordered by user harm
- Conflicts resolved
- Validation
```

## 5. Implementation Scope

```text
[$plan-implementation-scope]

Goal:
- Split the UX refactor into the smallest reversible implementation slices.

Constraints:
- no product truth changes
- no public contract/schema/permission changes unless explicitly approved
- no new dependencies unless explicitly approved
- preserve power-user access through advanced/detail surfaces
- default to keep or move; remove only when no caller, test, fixture, route, or documented workflow depends on it

Preferred slices:
1. first-screen information hierarchy
2. user-language status and next action
3. detail view simplification
4. advanced disclosure for raw/proof/configuration data
5. empty/loading/blocked/failed states
6. preservation and regression test updates
7. image reference mockup
8. compare UI screenshots
9. scenario QA

Output:
- step goals
- candidate files
- existing helpers/routes/states/tests to preserve
- done criteria
- verification commands
- scope out
```

## 6. UX/UI Implementation

```text
[$execute-ux-ui-improvement]

Goal:
- Implement only the first accepted UX/UI finding or slice.

Scope:
- one screen, state family, or component group
- user-facing hierarchy/copy/layout improvement
- tests or render proof for the changed behavior

Preservation:
- identify existing helpers, components, routes, controls, states, tests, fixtures, and examples before editing
- reuse or extend existing helpers instead of deleting or duplicating them
- if anything is proposed for removal, prove no remaining caller, route, test, fixture, or documented workflow depends on it
- prefer moving expert/debug/proof material to advanced/detail over deleting it

Scope out:
- new product features
- write/run/delete/send/purchase actions not already contracted
- public API/schema/permission changes
- full design-system rewrite
- deletion of unverified behavior, helpers, routes, fixtures, or tests

Verification:
- format/lint/test commands relevant to the repo
- render or screenshot the changed UI when possible

Stop rules:
- stop when the slice is implemented and verified
- do not continue into the next slice without a new evidence chain
```

Use `[$execute-product-completion]` instead only when the accepted slice includes product-completion behavior beyond UX/UI presentation.

## 7. Reference Image Generation

```text
[$imagegen]

Create a reference mockup image for the implemented UX slice.

Use case: ui-mockup
Asset type: visual reference for UI verification
Primary request:
- Show the target product screen after the essential UX refactor.

Required content:
- viewport and platform:
- primary user:
- primary state:
- primary action:
- core outcome:
- supporting explanation:
- advanced/details disclosure:
- empty/error/blocked behavior if relevant:

Constraints:
- no fake product capabilities
- no decorative clutter
- no marketing hero if this is a working product surface
- do not show write/edit/run/delete actions unless already part of the product contract
- keep text short and readable

Output:
- save or identify the generated reference image path for compare-ui-screenshots
```

## 8. Compare UI Screenshots

```text
[$compare-ui-screenshots]

Compare the implemented UI screenshot against the generated reference mockup.

Inputs:
- generated screenshot path:
- reference image path:
- category hint:

Criteria:
- first-screen purpose is clear
- primary state and action match the reference intent
- advanced material does not dominate
- empty/error/blocked states remain truthful
- hierarchy, spacing, typography, and viewport fit are acceptable
- product truth is not hidden

Output:
- strict JSON verdict only
```

## 9. Scenario QA

```text
[$qa-change-scenarios]

Goal:
- Verify the changed UX through real user scenarios.

Scenarios:
1. first-time user understands the current state
2. user finds the primary action
3. user understands success
4. user understands blocked/failed/stale state and next action
5. user can access advanced details without them dominating the first path
6. existing advanced/detail/power-user path still works
7. no existing helper-backed behavior, route, state, or fixture was removed without proof

Evidence:
- rendered UI or browser screenshot
- focused tests
- repo verification command

Output:
- passed scenarios
- failed scenarios
- coverage gaps
- release confidence
```

## 10. Final Quality Review

```text
[$review-quality-check]

Review the UX refactor for real defects.

Focus:
- user confusion
- truth hiding
- accidental deletion of functionality, helpers, routes, fixtures, or tests
- broken state handling
- inaccessible or clipped text
- mobile/viewport problems
- missing tests
- public contract or invariant risk

Output findings first with file/line evidence.
```
