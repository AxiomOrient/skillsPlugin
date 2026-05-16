# UX/UI Analysis Auto-Research

Use this only when a UX/UI audit or rule-writing request is broad, ambiguous, or not yet tied to a specific user task and surface. Skip it when the user already provides one screen, screenshot, flow, or accepted audit scope.

## Goal

Choose one evidence-backed UX/UI audit surface and the smallest useful evidence set.

Success means:

- the primary user, top task, platform, and risk level are named or marked unknown
- the audit surface is bounded to one screen, flow, component family, or form path
- the evidence can support observable rules and findings
- missing runtime, accessibility, or task evidence is explicit

## Research Budget

Start with:

- user request, product docs, README, route/screen names, screenshots, or rendered UI
- target views/components, navigation, forms, labels, loading/empty/error states
- accessibility hints, tests, previews, stories, examples, or visual artifacts if present

Read more only when:

- the top task or target platform is unclear
- screenshot evidence conflicts with code or docs
- forms, accessibility, irreversible actions, or regulated flows increase risk
- a finding would otherwise be based only on taste

Stop when one audit surface and one validation method are clear, or when the missing evidence blocks a reliable UX judgment.

## Constraints

- Do not edit files.
- Do not recommend implementation before findings are accepted.
- Do not convert aesthetic preference into user harm without evidence.
- Do not use UX laws as absolute rules; resolve conflicts by task completion, safety, accessibility, and product truth.

## Output

Return only this shape:

```text
Audit surface:
- ...

Primary user and task:
- ...

Evidence checked:
- ...

Unknowns:
- ...

Rules to apply:
- ...

Validation method:
- ...

Stop reason:
- ...
```
