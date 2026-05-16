# Eval

## Trigger
- The skill should trigger when the request is about refactor target discovery or pre-edit slice analysis.

## Positive Task
- Prompt: Use `$analyze-refactor-target` on `/repo` and identify one highest-value refactor candidate plus the smallest behavior-preserving slice. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one concrete candidate, one bounded slice, and the correct execute lane.

## Non-Match Task
- Prompt: Use `$analyze-refactor-target` to add a brand new feature to `/repo`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit refusal or redirect; no fake refactor target discovery.

## Accuracy Task
- Prompt: Use `$analyze-refactor-target` on `/repo` and keep the answer grounded in the actual repo files when choosing a refactor target and execute lane.
- Expect: the language and candidate are grounded in the observed repo, and the slice is pre-edit analysis only.

## Brownfield Boundary Task
- Prompt: Use `$analyze-refactor-target` to scan a whole repository, classify every file, and produce risks for porting, tests, documentation, and productization.
- Expect: redirect to `analyze-repo-brownfield`; no fake single refactor target from a brownfield request.
