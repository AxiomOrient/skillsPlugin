---
name: execute-refactor-swift
description: "[execute] 이미 선택된 Swift 리팩터링 범위를 구현합니다. 동작은 유지하면서 파일, 타입, 뷰, 책임 분리를 작게 정리할 때 사용합니다."
---

# Execute Refactor Swift

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

Refactor the chosen Swift target in the smallest behavior-preserving slice.

Success means:
- the goal, non-goals, done condition, and verification are clear before editing
- the change has one purpose and does not mix feature, policy, API redesign, or broad concurrency migration work
- behavior is preserved by the narrowest honest test, build, or smoke proof available
- any deferred slice is named only when it is needed to explain why the current slice stopped

Before tool-heavy work, send a one- or two-sentence user-visible update naming the first evidence you will inspect. Stop when the current slice is verified, when the next change would mix purposes, or when proof is too weak to justify more edits.

If the chosen target is broad, concurrency-sensitive, or lacks an obvious proof command, read [references/auto-research.md](references/auto-research.md) before selecting the first slice. Use it to narrow research, not to discover a new repo-wide target.

Refactor Swift code toward value-first domain models, actor-isolated shared state, and explicit concurrency boundaries. Preserve behavior first, then remove structural complexity in the smallest slice that can be verified.
Do not equate refactoring with splitting. A cohesive Swift file can be the best design for one reducer, actor-backed store, CLI command, parser, or provider adapter when locality makes behavior easier to audit.

Use Swift on Swift’s own terms: value semantics for domain state, actor isolation for shared mutable resources, and explicit Sendable boundaries where data crosses concurrency domains.

Think in three compact lenses and repeat until the next slice is obvious:

- Value first: which state should be a `struct` or `enum` instead of a reference graph?
- Isolation first: which shared mutable state really belongs behind an `actor`?
- Boundary first: where are parsing, CLI, I/O, and concurrency lifecycles still mixed together?

Before choosing a slice, classify the changed surface into one or two dominant shapes:

- value-first domain or reducer logic
- parser or decoder
- CLI or operator surface
- actor-isolated shared resource
- state machine or lifecycle transition surface
- explicit I/O boundary such as filesystem, process, network, model backend, or persistence

When the user gives only a scenario, snippet, or design direction, reason from the stated facts and make assumptions explicit. Do not block on local repository discovery unless the user asked for repository-specific validation or repo-specific edits.
When rejecting a non-idiomatic design direction, explain the Swift-specific reason first. Do not pivot to workspace mismatch unless repository validation is part of the request.
Assume the refactor target is already chosen. If target discovery is still needed, redirect instead of doing discovery work here.

## Non-Match Handling

If the request does not match this skill, stop immediately.
For any non-match, briefly say this is not the `execute-refactor-swift` lane, then name the better lane. Do not inspect the repository or choose a Swift target.
If the prompt says "find the best refactor target" or asks where to refactor, answer only that this is target discovery for `analyze-refactor-target`; never name a file, package, module, risk, or proposed slice.

- For ordinary bug fixes, feature additions, UI-only work, or pure performance tuning, answer in two parts only:
  - why this skill is not the right tool
  - what normal path should be used instead
- For requests that still need target discovery:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-refactor-swift` 범위가 아닙니다.
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
Goal: clarify the CLI run command surface without changing user-visible behavior.
Non-goals: CLI UX changes, new flags, provider behavior changes
Done when:
- parsing, command selection, and execution responsibilities are easy to identify
- code may stay in one file if that keeps the command easier to audit
- user-visible output is unchanged
- tests still pass
Verification:
- swift test
- swift build
```

If these are not explicit, do not call the refactor done.
Do not turn this skill into repo-wide candidate discovery.

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A better refactor makes one real behavior, boundary, or invariant easier to read and verify; more split files, more abstractions, or larger diffs are not proof of improvement.
- Prefer the least clever code shape that preserves idiomatic Swift and makes state, isolation, failure, and ownership easier to audit.
- If the next change would only improve appearances or metrics, stop instead of creating churn.

## Workflow

1. Read the state ownership map, changed surface, and I/O or concurrency edges before touching helpers.
2. Write Goal, Non-goals, Done when, and Verification.
3. Identify one real unit of change:
   - value-model extraction
   - in-place cohesion cleanup
   - parser isolation
   - CLI boundary cleanup
   - actor isolation cleanup
   - state transition cleanup
   - Sendable boundary cleanup
   - I/O boundary cleanup
   - structured concurrency cleanup
   - unsafe opt-out removal
4. Add or confirm the smallest useful regression check.
5. Pick one bounded slice and implement it unless a stop condition is hit.
6. Run verification for the changed surface.
7. Re-evaluate and choose the next smallest slice only after the previous slice is green.

Do not batch multiple refactor purposes into one change.
Do not mix feature work into the slice.
This applies even when the skill is invoked explicitly. For non-matching requests, decline immediately and do not inspect the local repository unless the user separately asked for repository-specific debugging or edits.

## Value-First Rules

- Make `struct` and `enum` the default for domain state and transitions.
- Use `class` only when identity, platform integration, observation, or inheritance is genuinely required.
- Prefer enums with associated values over bool or string flag soups when lifecycle modes are real.
- Prefer boring values and reducers over clever reference graphs.
- If a value can be `Sendable`, design it that way early instead of patching warnings later.

## Actor Rules

- Shared mutable state belongs behind an `actor`, not in globals or mutable singletons.
- Do not make everything an actor. Pure state values should remain values.
- Keep actor APIs narrow and concrete.
- Move calculation, validation, and transition logic outside the actor when they do not need isolation.
- If an actor is only hiding one dictionary plus file I/O, separate the pure state transition from the effectful persistence boundary.
- Reserve `@MainActor` for UI or presentation boundaries instead of using it as a generic fix for isolation issues.
- Prefer a global actor only when a whole presentation domain truly shares one isolation boundary; do not use it to hide mutable singleton design.

## Sendable Rules

- Treat `Sendable` as a design constraint, not a warning to silence.
- Prefer values that can cross concurrency boundaries safely.
- `@Sendable` closures should capture only safe values or actor references.
- Do not use `@unchecked Sendable` as a default escape hatch.
- If a type needs unsafe opt-out, explain why the ownership model is still sound.

## Refactor-Test Contract Rules

- When a refactor breaks tests, first classify the failure as:
  - product regression
  - test bug
  - both
  - insufficient evidence
- Do not weaken a test only to get green if it still detects a real behavior regression.
- Separate public compatibility tests from internal helper tests. If a behavior is meant to be public, test it through the public surface without `@testable import`.
- If a Swift 6 concurrency fix changes representation, compare old and new semantics before deciding that the failing test is wrong.
- If the system has derived representations such as state, files, mirrors, or APIs, keep the canonical boundary clear and verify each derived boundary separately.

## Surface Triage Rules

- Name the dominant surface before recommending edits.
- If the code is mainly a parser, distinguish decode, validate, and apply-time effects; keep them colocated when that preserves a clearer read path.
- If the code is mainly a CLI surface, distinguish option parsing, command selection, execution, and output formatting; split only when tests or change safety improve enough to justify the extra files.
- If the code is mainly a state machine, make states and transitions explicit before moving side effects.
- If the code is mainly an actor-backed store, shrink the actor to coordination and persistence rather than letting it absorb business logic.
- If the code is mainly an I/O boundary, keep the boundary thin and move policy or transformation inward.

## Cohesion And Split Balance Rules

- Prefer the shape that makes value ownership, isolation, and user-visible behavior easiest to inspect. More files are not automatically cleaner.
- Split only for a real boundary: separate public contract, separate actor/isolation domain, separate effect adapter, reusable parser, independently testable policy, or different change cadence.
- Keep code together for one authoritative reducer, one schema/wire format, one compact command, one actor facade plus its private state, or one provider adapter where cross-file navigation would hide invariants.
- Before creating a new file or target, count the cost: access-control changes, extra imports, public/internal visibility drift, target graph churn, and weaker locality. If that cost exceeds clarity gain, simplify in place.

## Parser Rules

- Keep lexical decoding, structural parsing, validation, and effectful apply steps distinct when they are currently interleaved.
- Prefer parser functions that return explicit values and explicit errors.
- Do not hide malformed-input handling inside orchestration or actor methods.
- For parser-heavy code, the first safe slice is usually extraction of pure decode or normalize helpers, not a format rewrite.

## CLI Rules

- Keep CLI surfaces thin: parse args, resolve command, call a concrete operation, print results.
- Do not mix option parsing, environment assembly, persistence, and execution policy in one long function if a smaller seam is available.
- Preserve user-facing behavior unless the refactor explicitly scopes CLI UX changes.
- Prefer one slice that separates parsing or command selection from execution, rather than reorganizing the whole command tree.

## State Machine Rules

- Use enums with associated values when lifecycle transitions are explicit and central to the problem.
- Make allowed transitions visible in one place before moving side effects around.
- Prefer pure reducers for state transitions and keep shared mutable storage at the edge.
- If the transition surface is already intentionally centralized, do not split it for aesthetics alone.

## I/O Boundary Rules

- Make filesystem, process, network, model backend, and persistence edges explicit.
- Keep boundary functions small and concrete.
- Move parsing, normalization, policy, and transition logic out of I/O shells first.
- Prefer protocol seams at boundaries and concrete or generic paths in hot loops.

## Protocol And Concrete Rules

- Use protocols at seams for capabilities, ports, and testing.
- In hot paths, prefer concrete or generic implementations over `any Protocol` when existential cost or indirection matters.
- Do not protocol-ize everything by default.
- Delete thin wrappers and needless type erasure before adding more abstraction.

## Concurrency Rules

- Prefer structured concurrency over detached or hidden task spawning.
- Every task needs visible ownership, cancellation, and completion behavior.
- Do not hide lifecycle policy behind convenience helpers.
- If the concurrency surface is mostly coordination, keep state in one actor or reducer and fan-out at the edge.
- Do not use low-level synchronization primitives as the default answer when actors are sufficient.
- Reach for the Synchronization library only after actor boundaries and value ownership are already clear, and only when measurement shows a real hotspot.

## Safety Escape Hatch Rules

- Treat `@unchecked Sendable`, `nonisolated(unsafe)`, and similar opt-outs as exceptional.
- If an escape hatch must stay, isolate it in one slice and justify it explicitly.
- Prefer fixing ownership, isolation, or state shape before accepting unsafe annotations.
- Treat `@MainActor` the same way at non-UI boundaries: not as the default answer to data-race or global-state design problems.
- Consider noncopyable or ownership-specific tools only after the value and actor design is already clear.

## Verification

- Verification is mandatory.
- Run targeted checks first for the changed surface, then widen if needed.
- If write access or command execution is blocked, state the blocked proof explicitly and do not present the planned refactor as completed work.
- Default loop:
  - `swift test`
  - `swift build`
- Add checks when the change touches specific risk areas:
  - parser changes: malformed input and decode-path tests
  - CLI changes: command parsing tests plus one smoke path if available
  - actor or Sendable changes: concurrency or isolation-focused tests
  - state machine changes: transition-level tests
  - package or target graph changes: confirm `Package.swift` still builds the intended surfaces
- If the repository already uses Swift Testing, prefer that style, including `#expect` and parameterized tests, instead of introducing a parallel test idiom for one slice.
- Prefer real behavior tests over snapshot-only proof when isolation or lifecycle behavior moved.
- If multiple good slices exist, finish the highest-leverage safe slice first, then list remaining slices in priority order.
- Avoid creating notes or reports unless the user explicitly asks for them.

## Stop Conditions

- Stop when the next change would mix refactor work with feature or policy changes.
- Stop when the only remaining change is stylistic churn.
- Stop when behavior risk grows faster than the test baseline.
- Stop when a module graph change, async model rewrite, or unsafe-annotation sweep should be isolated as its own slice.
- Stop when the current module is already thin, cohesive, and value-safe enough that the next change would be churn rather than structural improvement.
- When stopping, name the deferred slice explicitly so the next pass starts from a concrete boundary.

## Repeat Loop

After each slice, ask four short questions:

- Is the change still one purpose?
- Is value ownership or actor isolation clearer, or did keeping the code together make local reasoning better?
- Are Sendable, I/O, or lifecycle boundaries easier to reason about?
- Did verification prove behavior preservation?

If the answer is not clearly yes, shrink the next slice.

## Comment Rules

- Preserve existing comments that still explain a real invariant, actor boundary, Sendable constraint, or lifecycle hazard.
- Do not add comments when clearer value types, actor boundaries, names, extracted helpers, or tests make the intent obvious.
- Add a new comment only when the slice introduces or exposes a non-obvious constraint that the code cannot express cheaply on its own.
- Do not leave narration comments, refactor diary comments, TODO comments, or cleanup commentary after a behavior-preserving slice.
- If the change is correct without a new comment, prefer no new comment.

## References

- Read [references/auto-research.md](references/auto-research.md) only when the selected target is broad or the proof surface is unclear.
- Read [references/checklist.md](references/checklist.md) after each refactor pass.
- Read [references/eval.md](references/eval.md) when benchmarking the skill, revising the trigger description, or comparing candidate versions against the baseline.
- Source material:
  - [Announcing Swift 6](https://swift.org/blog/announcing-swift-6/)
  - [Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
  - [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/)
  - [Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/)
  - [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)
  - [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)
  - [Swift 6 Concurrency Migration Guide](https://www.swift.org/migration/documentation/swift-6-concurrency-migration-guide/migrationstrategy/)
  - [Data Race Safety](https://www.swift.org/migration/documentation/swift-6-concurrency-migration-guide/dataracesafety/)
  - [Enable data-race safety checking](https://www.swift.org/migration/documentation/swift-6-concurrency-migration-guide/enabledataracesafety/)
