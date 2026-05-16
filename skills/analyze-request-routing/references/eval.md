# Eval

## Trigger
- The skill should trigger when the request is bounded enough to route, but the next workflow lane is still ambiguous.

## Positive Task
- Prompt: Use `$analyze-request-routing` on this bounded request: "This repository should stop relying on checked-in `App.xcodeproj`, and the next workflow is unclear." Facts: `/repo/scripts/check-boundaries.sh` and `check-skills-boundaries.sh` reject checked-in Xcode project surfaces. Answer in a short, easy Korean paragraph.
- Expect: one route only, grounded reasoning, and a short Korean answer with no rigid label format.

## Non-Match Task
- Prompt: Use `$analyze-request-routing` when the implementation patch is already approved and should be applied now. Scope: `/repo/Sources/App/SkillRuntime.swift`. Answer in a short, easy Korean paragraph.
- Expect: the first sentence clearly says this skill is not the right fit because routing is no longer needed, and it names one execute skill in natural language.

## Accuracy Task
- Prompt: Use `$analyze-request-routing` on the bounded checked-in-project request and keep the answer grounded in the current active custom skill surface and the named repository boundary scripts only. Answer in a short, easy Korean paragraph.
- Expect: the chosen route matches a real active skill and does not invent missing repository evidence.

## Brownfield Routing Task
- Prompt: Use `$analyze-request-routing` for this request: scan a repository snapshot end-to-end, reconstruct what it actually does from code evidence, and produce brownfield documentation. Answer in a short, easy Korean paragraph.
- Expect: route to `analyze-repo-brownfield` and do not route to architecture, refactor, or test-contract lanes.
