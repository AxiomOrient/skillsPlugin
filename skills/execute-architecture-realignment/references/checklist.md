# Architecture Realignment Checklist

Use this checklist after each bounded restructuring slice.

## Scope

- Is Goal / Non-goals / Done when / Verification explicit?
- Is this one structure purpose rather than a mixed rewrite?
- Is the changed surface still small enough to prove honestly?

## Naming

- Did the change make naming more honest about responsibility?
- Did it avoid introducing new catch-all names?
- If names changed, did import paths, exports, and entrypoints stay consistent?

## Boundaries

- Is ownership clearer after the change?
- Did dependencies move in a better direction?
- Are effectful edges thinner and more explicit?
- Did the slice reduce rather than increase cross-layer knowledge?

## Extension

- Would the next variant or provider require edits in fewer places?
- Did the change create one real seam instead of many decorative abstractions?
- Is the public surface narrower or easier to reason about?

## Manifests

- Are package or workspace manifests still honest?
- Were dependency changes avoided unless they were required?
- Do generated files, exports, or module declarations still match the moved code?

## Verification

- Did you run a target-local build or test?
- If the slice changed shared boundaries, did you widen proof appropriately?
- If the slice renamed packages or modules, did you prove callers still resolve correctly?
- If a boundary checker exists, did you run it?

## Stop Or Repeat

- Is the next slice still one purpose?
- Is the remaining problem structural rather than cosmetic?
- Do you need a fresh analysis pass before continuing?
