---
name: execute-refactor-go
description: "[execute] 이미 선택된 Go 리팩터링 범위를 구현합니다. 동작은 유지하면서 이름, 구조, 중복, 책임 분리를 작게 정리할 때 사용합니다."
---

# Execute Refactor Go

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

## 작업 계약

Refactor the chosen Go target in the smallest behavior-preserving slice.

Success means:
- the goal, non-goals, done condition, and verification are clear before editing
- the change has one purpose and does not mix feature or policy work
- behavior is preserved by the narrowest honest test, build, or smoke proof available
- any deferred slice is named only when it is needed to explain why the current slice stopped

Before tool-heavy work, send a one- or two-sentence user-visible update naming the first evidence you will inspect. Stop when the current slice is verified, when the next change would mix purposes, or when proof is too weak to justify more edits.

If the chosen target is broad, mixed with runtime behavior, or lacks an obvious proof command, read [references/auto-research.md](references/auto-research.md) before selecting the first slice. Use it to narrow research, not to discover a new repo-wide target.

Refactor Go code toward clearer package ownership, simpler control flow, and safer runtime boundaries. Preserve behavior first, then remove structural complexity in the smallest slice that can be verified.
Do not equate refactoring with splitting. A cohesive file or package can be the best design when it keeps one behavior, state table, parser, or command surface easy to audit.

Think in three compact lenses and repeat until the next slice is obvious:

- Package first: what responsibility boundary is wrong or too wide?
- Control flow first: where do errors, context, and concurrency become hard to reason about?
- Slice first: what is the smallest change that clarifies one thing without mixing purposes?

Before choosing a slice, classify the changed surface into one or two dominant shapes:

- pure logic or normalization
- parser or decoder
- CLI command or operator surface
- state machine or lifecycle transition surface
- explicit I/O boundary such as filesystem, process, network, clock, or provider adapter

When the user gives only a scenario, snippet, or design direction, reason from the stated facts and make assumptions explicit. Do not block on local repository discovery unless the user asked for repository-specific validation or repo-specific edits.
When rejecting a non-idiomatic design direction, explain the Go-specific reason first. Do not pivot to workspace mismatch unless repository validation is part of the request.
Assume the refactor target is already chosen. If target discovery is still needed, redirect instead of doing discovery work here.

## Non-Match Handling

If the request does not match this skill, stop immediately.
For any non-match, briefly say this is not the `execute-refactor-go` lane, then name the better lane. Do not inspect the repository or choose a Go target.
If the prompt says "find the best refactor target" or asks where to refactor, answer only that this is target discovery for `analyze-refactor-target`; never name a file, package, module, risk, or proposed slice.

- For ordinary bug fixes, feature additions, performance-only work, or non-Go tasks, answer in two parts only:
  - why this skill is not the right tool
  - what normal path should be used instead
- For requests that still need target discovery:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-refactor-go` 범위가 아닙니다.
  - 더 맞는 스킬이나 조건: analyze-refactor-target
- Do not inspect the local repository.
- Do not mention workspace contents unless the user explicitly asked for repository-specific validation.
- Do not force the request into Goal / Non-goals / Done when / Verification.

## 내부 정리 기준

최종 답변은 짧고 쉬운 한국어 문단으로 씁니다.

- Internal work record, not a final-answer template:
  - `Goal: ...`
  - `Slice: ...`
  - `Verify: ...`
  - `Next: ...`
- 필드 나열 대신 짧은 문단으로 자연스럽게 정리합니다.
- Omit `Next` if there is no immediate next slice.
- `Verify` must name the command that ran or the concrete reason verification was blocked.
- Do not add background explanation unless the user asks.
- 맞지 않는 요청이면 이유를 짧게 설명하고 더 맞는 스킬 이름만 덧붙입니다.

## Success Criteria First

Before editing, lock these four items:

- Goal
- Non-goals
- Done when
- Verification

Example:

```md
Goal: move HTTP request parsing out of the service package.
Non-goals: API changes, database behavior changes, new logging fields
Done when:
- external behavior is unchanged
- package responsibilities are clearer
- tests still pass
Verification:
- go test ./...
```

If these are not explicit, do not call the refactor done.
Do not turn this skill into repo-wide candidate discovery.

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A better refactor makes one real behavior, boundary, or invariant easier to read and verify; more split files, more abstractions, or larger diffs are not proof of improvement.
- Prefer the least clever code shape that preserves idiomatic Go and makes failure, cleanup, and ownership easier to audit.
- If the next change would only improve appearances or metrics, stop instead of creating churn.

## Workflow

1. Read the package graph, changed surface, and runtime boundaries before touching helpers.
2. Write Goal, Non-goals, Done when, and Verification.
3. Identify one real unit of change:
   - package split only when the responsibility boundary is real
   - in-place cohesion cleanup
   - producer-side interface removal
   - pure logic extraction
   - parser isolation
   - CLI command boundary cleanup
   - state transition cleanup
   - error flow cleanup
   - context lifetime cleanup
   - I/O boundary cleanup
   - concurrency ownership cleanup
4. Add or confirm the smallest useful regression check.
5. Pick one bounded slice and implement it unless a stop condition is hit.
6. Run verification for the changed surface.
7. Re-evaluate and choose the next smallest slice only after the previous slice is green.

Do not batch multiple refactor purposes into one change.
Do not mix feature work into the slice.
If the request is an ordinary bug fix, pure feature addition, pure performance tuning, or a non-Go task, say this skill is not the right tool and redirect to the normal implementation path instead of forcing a refactor plan.
This applies even when the skill is invoked explicitly. For non-matching requests, decline immediately and do not inspect the local repository unless the user separately asked for repository-specific debugging or edits.

## Package-First Rules

- Decide package responsibility before moving functions or renaming types.
- Prefer short, specific package names tied to responsibility.
- Do not create or expand catch-all packages such as `util`, `common`, `helper`, or `model`.
- Split giant files when they hide more than one dominant responsibility.
- Keep a large file or package intact when it is one coherent behavior surface and splitting would add imports, exported names, test setup, or dependency edges without making changes safer.
- Prefer in-file sectioning, clearer names, direct helper extraction, or tighter control flow before creating new packages or files.
- Good split boundaries:
  - transport parsing vs business orchestration
  - API adapters vs domain logic
  - repository implementation vs query shaping
  - worker coordination vs task execution
- Do not split blindly when one file is intentionally centralized around one coupled concern such as:
  - one protocol state transition surface
  - one authoritative wire format
  - one tightly coupled migration surface

When leaving a giant file or package in place, state why the coupling is structural rather than accidental.

## Surface Triage Rules

- Name the dominant surface before recommending edits.
- If the code is mainly pure logic, optimize for explicit data flow and narrow inputs instead of new abstractions.
- If the code is mainly a parser or decoder, distinguish tokenization, decode, validation, and apply-time effects; keep them colocated when one file is easier to audit.
- If the code is mainly CLI wiring, distinguish argument parsing, command selection, execution policy, and side effects; split only if the command surface is too hard to test or change in place.
- If the code is mainly a lifecycle or state transition surface, make states and transitions more explicit before shuffling helpers.
- If the code is mainly an I/O boundary, keep boundary code thin and move calculation, normalization, and policy checks inward.

## Interface Rules

- Define interfaces on the consumer side when a consumer only needs a narrow behavior.
- Keep interfaces small and specific.
- Do not introduce an interface only because tests might want mocks later.
- Prefer functions that accept interfaces and return concrete types.
- Remove producer-owned interfaces when they only mirror one implementation and add no substitution point.
- If a concrete type is the real API, expose the concrete type and keep the abstraction pressure low.

## Error Rules

- Treat errors as part of normal control flow.
- Keep the happy path visually straight; handle errors early and return.
- Preserve cause chains with `%w` when crossing boundaries.
- Use `errors.Is` and `errors.As` for classification.
- Prefer local, explicit error handling over framework-style error DSLs.
- Do not hide control flow in helper stacks that make it harder to see failure and cleanup behavior.

## Context Rules

- Pass `context.Context` as the first parameter on request-scoped or I/O-bound paths.
- Use context for deadlines, cancellation, and request-scoped values only.
- Do not store `context.Context` in a struct field.
- Do not smuggle optional business data through context when an explicit parameter is clearer.
- If a call path is not request-scoped and not I/O-bound, question whether it needs context at all.

## Concurrency Rules

- Treat concurrency as a design choice with lifecycle cost, not a default speed trick.
- Every goroutine needs a clear owner and shutdown condition.
- Use channels for coordination, ownership transfer, and pipelines.
- Use mutexes for shared mutable state.
- Prefer the simplest synchronization primitive that makes ownership obvious.
- Separate concurrency refactors from feature changes unless the existing structure makes that impossible.

## Pure Logic Rules

- Extract pure parsing, validation, normalization, and calculation logic when it clarifies the code or makes testing easier.
- Do not force every effectful workflow into a fake pure pipeline.
- Prefer direct control flow, small structs, and explicit branches over decorative declarative abstractions.
- Use generics only when they remove real duplication without hiding intent.
- Prefer pure helpers that accept explicit inputs and return explicit outputs over helpers that reach into global config, context values, or process state.
- When splitting effectful code, move the decision or plan calculation first and defer the actual side effect boundary to a thinner caller.

## Parser Rules

- Keep lexical parsing, structural decoding, validation, and effectful apply steps distinct when they are currently interleaved.
- Prefer parser functions that return concrete parsed values plus explicit errors.
- Do not hide malformed-input handling behind side-effectful orchestration.
- For parser-heavy code, the first safe slice is usually extraction of pure-ish decode or normalize helpers, not a format rewrite.

## CLI Rules

- Keep CLI surfaces thin: parse args, resolve command, call a concrete operation, report output.
- Do not mix flag parsing, business policy, persistence, and transport formatting in the same long function when a smaller seam is available.
- Prefer one slice that separates command selection or input normalization from execution, rather than reorganizing the whole command tree.
- Preserve user-facing behavior unless the refactor explicitly scopes CLI UX changes.

## State Machine Rules

- Use a state machine only when lifecycle transitions are explicit and central to the problem.
- Prefer named states over bool or string flag combinations when the value space has real modes.
- Make allowed transitions visible in one place before moving transition side effects around.
- If the state machine is already centralized, do not split it purely for file-count aesthetics.

## I/O Boundary Rules

- Make filesystem, process, network, clock, and provider boundaries explicit.
- Keep boundary functions small and concrete; move calculation, normalization, and policy checks out of them first.
- Prefer injecting the minimum boundary dependency needed by the pure core rather than introducing broad service containers.
- When the code mixes planning and execution, split the plan or normalize step first, then keep a thin apply step at the edge.

## Test Structure Rules

- Prefer table-driven tests with subtests when the changed surface has multiple input and error-path variants.
- When a refactor changes parser, protocol, serializer, or decoder behavior, pair focused table cases with fuzz coverage where practical.
- Keep at least one behavior-level path green when splitting a giant file so the new narrower tests do not replace all end-to-end confidence.

## Module and Dependency Rules

- Keep module state honest with `go.mod`, `go.sum`, and `go mod tidy`.
- Do not mix dependency adds, removals, or toolchain churn into a normal refactor slice unless the slice specifically exists to clean module state.
- If a refactor deletes imports or moves packages across boundaries, confirm that `go mod tidy` leaves the module in the expected shape before calling the slice done.

## Verification

- Verification is mandatory.
- Run targeted checks first for the changed surface, then widen if needed.
- If write access or command execution is blocked, state the blocked proof explicitly and do not present the planned refactor as completed work.
- Default loop:
  - `go test ./...`
- Add checks when the change touches specific risk areas:
  - concurrency: `go test -race ./...`
  - multi-case behavioral changes: prefer table-driven tests with subtests
  - CLI behavior: run focused command or handler tests plus at least one smoke path if available
  - parser, protocol, serializer, decoder: consider fuzz coverage
  - lifecycle or state-machine changes: keep transition-level tests green
  - performance claim: benchmark first, then inspect with `pprof`
  - module dependency cleanup: confirm `go mod tidy` leaves the module in the expected state
- Prefer real behavior tests over snapshot-only proof when runtime boundaries moved.
- If multiple good slices exist, finish the highest-leverage safe slice first, then list remaining slices in priority order.
- Avoid creating notes or reports unless the user explicitly asks for them.

## Stop Conditions

- Stop when the next change would mix refactor work with feature or policy changes.
- Stop when the only remaining change is stylistic churn.
- Stop when behavior risk grows faster than the test baseline.
- Stop when a public API change, dependency swap, or unsafe-style boundary change should be isolated as its own slice.
- When stopping, name the deferred slice explicitly so the next pass starts from a concrete boundary.

## Repeat Loop

After each slice, ask four short questions:

- Is the change still one purpose?
- Is the package or runtime boundary clearer, or did keeping the code together make local reasoning better?
- Are error, context, or concurrency rules easier to reason about?
- Did verification prove behavior preservation?

If the answer is not clearly yes, shrink the next slice.

## Comment Rules

- Preserve existing comments that still explain a real invariant, boundary, or hazard.
- Do not add comments when clearer code, naming, extraction, or tests make the intent obvious.
- Add a new comment only when the slice introduces or exposes a non-obvious constraint that the code alone cannot make clear cheaply.
- Do not leave narration comments, refactor diary comments, TODO comments, or cleanup commentary after a behavior-preserving slice.
- If the change is correct without a new comment, prefer no new comment.

## References

- Read [references/auto-research.md](references/auto-research.md) only when the selected target is broad or the proof surface is unclear.
- Read [references/checklist.md](references/checklist.md) after each refactor pass.
- Read [references/eval.md](references/eval.md) when benchmarking the skill, revising the trigger description, or comparing candidate versions against the baseline.
- Source material:
  - [Effective Go](https://go.dev/doc/effective_go)
  - [Package names](https://go.dev/blog/package-names)
  - [Go Code Review Comments](https://go.dev/wiki/CodeReviewComments)
  - [Errors are values](https://go.dev/blog/errors-are-values)
  - [Contexts and structs](https://go.dev/blog/context-and-structs)
  - [Diagnostics](https://go.dev/doc/diagnostics)
  - [Managing dependencies](https://go.dev/doc/modules/managing-dependencies)
  - [Data Race Detector](https://go.dev/doc/articles/race_detector)
  - [Agent Skills](https://developers.openai.com/codex/skills)
  - [Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices)
  - [Agent evals](https://developers.openai.com/api/docs/guides/agent-evals)
