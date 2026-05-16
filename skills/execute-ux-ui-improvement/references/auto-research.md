# UX/UI Execution Auto-Research

Use this only before editing when the accepted UX/UI finding, target owner, or proof method is unclear. Skip it when one finding, one owner, and one proof are already clear.

## Goal

Find one safe UI implementation slice with a complete evidence chain:

```text
accepted UX/UI finding -> current UI/code owner -> verification proof
```

Success means:

- the accepted finding or rule is named
- the screen/component owner is named by path/module
- preservation constraints are named before edits
- the verification proof exercises the changed UI, not just compilation

## Research Budget

Start with:

- accepted UX/UI audit finding, work spec, screenshot target, or user request
- current view/component/route/state owner
- local design-system components and nearby patterns
- tests, previews, stories, screenshots, accessibility checks, or browser/app smoke paths

Read more only when:

- the accepted finding is not specific enough to implement
- ownership is unclear
- the change may hide, move, or remove a control/state/route/helper/test/fixture
- the proof command does not exercise the changed UI

Stop when one implementable slice has finding, owner, preservation constraints, and proof, or when missing evidence blocks safe editing.

## Accuracy Gates

Do not recommend implementation unless all gates pass:

1. Finding gate: a UX/UI rule or finding is accepted and specific.
2. Ownership gate: the current code/screen owner is known.
3. Preservation gate: affected controls, states, helpers, routes, tests, fixtures, and advanced paths are listed.
4. Proof gate: build/test/lint/render/screenshot/manual scenario can exercise the changed UI.

If a gate fails, return `blocked` or `근거 부족`.

## Output

Return only this shape:

```text
Evidence chain:
- accepted finding:
- current owner:
- proof:

Preserve:
- ...

Recommended slice:
- ...

Non-goals:
- ...

Verification:
- ...

Blocked or unknown:
- ...

Stop reason:
- ...
```
