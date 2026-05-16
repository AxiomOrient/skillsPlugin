# Essential UX Auto-Research

Use this reference only when a UX refactor request is broad, ambiguous, or not yet tied to a specific user path and proof method.

## Goal

Find one safe UX refactor step with a complete evidence chain:

```text
user need or confirmed friction -> current product surface owner -> verification proof
```

## Three Passes

1. Plan
   - Ask 3-6 sub-questions:
     - Who is the primary user?
     - What is the first success path?
     - Which screen or workflow blocks that path?
     - What clutter or confusion is directly visible?
     - What must remain available for trust, compliance, or power users?
     - Which existing helpers, routes, controls, states, tests, fixtures, or documented workflows must be preserved?
     - How can the change be verified?

2. Retrieve
   - Inspect only evidence that can change the step:
     - screenshots or rendered UI
     - entrypoints/routes/views/components
     - README/product docs/onboarding docs
     - tests or storybook/examples
     - analytics or user report if provided
     - design tokens or component conventions
     - callers and references for any helper, route, control, state, fixture, or test that might be moved or removed

3. Synthesize
   - Choose one implementable step.
   - Separate core, supporting, secondary, advanced, risk, and waste.
   - Name what moves out of the primary path and where it goes.
   - Name what remains unchanged and what existing helpers or contracts must be reused.
   - Name the proof command or manual scenario.

## Accuracy Gates

Do not implement unless all gates pass:

1. User/value gate: evidence identifies a user path or confirmed friction.
2. Ownership gate: evidence identifies the screen/component/code/doc owner.
3. Proof gate: evidence identifies a command, screenshot, browser scenario, test, or review check that exercises the changed UX.
4. Truth gate: simplification does not hide required risk, failure, policy, price, permission, or data authority.
5. Preservation gate: no function, helper, route, control, state, fixture, test, or documented workflow is removed unless caller/search evidence and verification prove it is safe.

If a gate fails, return `blocked` or `근거 부족`.

## Output

```text
Evidence chain:
- user need/friction:
- current owner:
- proof:
- truth constraint:
- preservation constraint:

Recommended step:
- ...

Goal:
- ...

Non-goals:
- ...

Done condition:
- ...

Failure condition:
- ...

Verification:
- ...

Preserve:
- ...

Move to advanced/detail:
- ...

Remove:
- none | item + proof

Confidence:
- high | medium | low - evidence reason

Backlog or blocker:
- ...

Stop reason:
- ...
```
