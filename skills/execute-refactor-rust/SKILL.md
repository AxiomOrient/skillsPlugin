---
name: execute-refactor-rust
description: "[execute] 이미 선택된 Rust 리팩터링 범위를 구현합니다. 동작은 유지하면서 모듈, 타입, 이름, 책임 분리를 작게 정리할 때 사용합니다."
---

# Execute Refactor Rust

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

Refactor the chosen Rust target in the smallest behavior-preserving slice.

Success means:
- the target surface, goal, non-goals, done condition, and verification are clear before editing
- the change has one purpose and does not mix module split, API redesign, dependency swap, or async model rewrite
- behavior is preserved by the narrowest honest `cargo` proof or repo-local proof available
- any deferred slice is named only when it is needed to explain why the current slice stopped

Before tool-heavy work, send a one- or two-sentence user-visible update naming the first evidence you will inspect. Stop when the current slice is verified, when the next change would mix purposes, or when proof is too weak to justify more edits.

If the chosen target is broad, mixed-surface, or under-specified, read [references/auto-research.md](references/auto-research.md) before selecting the first slice. Use it to narrow research, not to discover a new repo-wide target.

Do not blindly push "data-first" everywhere.
Do not equate refactoring with splitting. A cohesive Rust module can be the best design for one reducer, schema truth, runtime bridge, or closed-domain state machine when locality makes invariants easier to audit.
Rust refactoring starts by classifying the target surface, because the correct shape for a library crate, product binary, and runtime bridge is not the same.
Assume the refactor target is already chosen. If target discovery is still needed, redirect instead of doing discovery work here.

## Non-Match Handling

If the request does not match this skill, stop immediately.
For any non-match, briefly say this is not the `execute-refactor-rust` lane, then name the better lane. Do not inspect the repository or choose a Rust target.
If the prompt says "find the best refactor target" or asks where to refactor, answer only that this is target discovery for `analyze-refactor-target`; never name a file, crate, module, risk, or proposed slice.

- For ordinary bug fixes, feature additions, pure performance tuning with no structural change, or non-Rust tasks, answer in two parts only:
  - why this skill is not the right tool
  - what normal path should be used instead
- For requests that still need target discovery:
  - 이 요청은 `execute-refactor-rust` 범위가 아닙니다: target discovery is still needed
  - 더 맞는 스킬이나 조건: analyze-refactor-target
- Do not inspect the local repository unless the user explicitly asked for repository-specific validation.
- Do not mention workspace contents unless repository validation is part of the request.
- Do not force the request into target classification, Goal / Non-goals / Done when / Verification, or refactor slice selection.

## 내부 정리 기준

최종 답변은 짧고 쉬운 한국어 문단으로 씁니다.

- 맞지 않는 요청이면 이유를 짧게 설명하고 더 맞는 스킬 이름만 덧붙입니다.
- For matching requests, use the normal response contract below.

## Core stance

1. **Classify first**
   - `library-core`: reusable crate, public API stability matters, consumers matter.
   - `product-shell`: binary/app/daemon, operator UX and boot/runtime flow matter.
   - `runtime-bridge`: adapter/process/network boundary, cancellation/ownership/concurrency matter.
   - `store-or-reducer`: persistence, projection, event/state transition truth matters.

2. **Model illegal states out of existence**
   - Prefer enums/newtypes/builders over `bool` + `Option` combinations when the domain has named modes.
   - Prefer one canonical status representation over duplicated partial flags.

3. **Keep effects at the edges**
   - Pure parse/normalize/plan/reduce logic stays free of fs/network/process/clock/env.
   - Apply/transport/runtime modules perform IO.

4. **Rust over ideology**
   - Use declarative / functional style where it improves invariants.
   - Stop when trait gymnastics, typestate abuse, deep iterator cleverness, or generic overfitting reduce readability.
   - In closed domains, prefer `enum + match` over trait objects.
   - In open extension seams, prefer traits.

5. **One bounded purpose per slice**
   - Never mix module split + API redesign + dependency swap + async model rewrite in one pass.
   - Include in-place cohesion cleanup as a valid slice when a split would add visibility, import, or module graph cost without stronger invariants.

6. **Cohesion before extraction**
   - Split only for a real boundary: public contract, ownership/isolation domain, transport/effect adapter, reusable parser, independently testable policy, or different change cadence.
   - Keep code together for one authoritative schema, one reducer, one transition table, one small product shell, or one bridge whose ordering and invariants are easier to audit locally.
   - Before creating a module, count the cost: `pub` leakage, re-exports, import churn, test fixture spread, feature-gate complexity, and weaker local reasoning.

## 내부 정리 기준

Internal work record, not a final-answer template:

```md
Primary target: library-core | product-shell | runtime-bridge | store-or-reducer
Secondary target: none | library-core | product-shell | runtime-bridge | store-or-reducer
Goal: ...
Why this slice: ...
Change set:
- ...
Verify:
- ...
Risks:
- ...
Remaining slice, only if the current work is not complete:
- ...
```

Do not hide the target classification in the internal work record.
If the crate is mixed (`src/lib.rs` plus a thin binary, or public namespaces plus product docs), name the primary target and the secondary target explicitly.
Do not call the work done without verification or an explicit limitation.
`Verify` must name the command that ran or the concrete reason verification was blocked.
Do not reduce complex refactors to a two-line answer.

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A better refactor makes one real behavior, boundary, or invariant easier to read and verify; more modules, more traits, deeper generics, or larger diffs are not proof of improvement.
- Prefer the least clever code shape that preserves idiomatic Rust and makes ownership, lifetimes, errors, and state transitions easier to audit.
- If the next change would only improve appearances or metrics, stop instead of creating churn.

## Workflow

1. Validate that the Rust target is already chosen and bounded.
2. Lock the behavior-preserving brief and repository phase.
3. Classify the target surface before choosing the slice shape.
4. Apply one Rust-native slice and verify it with the narrowest honest proof.
5. If write access or command execution is blocked, state the blocked proof explicitly and do not present the planned refactor as completed work.
6. Stop or roll back if proof weakens or the slice starts changing behavior.

## Step 0 — Validate the chosen target

Before proposing a shape, do a compact validation pass on the chosen target:

1. Read the local crate manifest, public modules, and top-level docs.
2. Read any repo-local verification or release-hardening docs if they exist (`docs/`, `SPEC`, release notes, cargo-proof docs).
3. Determine whether the target is:
   - externally consumed library,
   - internal application-core library,
   - product binary,
   - bridge/adapter,
   - reducer/store.
4. If both library and product-shell signals are present, choose the primary target by the surface with the stronger compatibility obligation and more explicit docs. Name the secondary target instead of pretending the repo is pure.
5. For any disputed pattern, consult this priority order:
   - official Rust Book / std docs / API Guidelines,
   - Tokio docs for async ownership patterns,
   - docs for crates already used in the repo,
   - focused ecosystem notes only when primary sources are insufficient.
6. Write down the chosen architecture and why the alternatives lost.

Do not widen this into repo-wide candidate discovery.

## Step 1 — Lock the brief

Before editing, lock all of these:

```md
Goal: ...
Non-goals: ...
Done when:
- ...
Verification:
- ...
```

If these are not explicit, do not refactor.

## Step 1.5 — Honor the repo phase

If the repository already states a current phase such as cargo proof, release hardening, API stabilization, or migration cleanup, prefer the smallest slice that removes the current proof blocker before proposing a broader structural redesign.

Examples:
- If local docs require exact-tree `cargo fmt/check/test/clippy/doc`, use that verification contract instead of the generic fallback loop.
- If a public library surface is declared deliberate or SemVer-sensitive, avoid changing public structs/enums first unless the migration plan is part of the brief.

## Step 2 — Choose the architecture by target type

### Mixed surfaces

If the crate is a mixed surface:
- choose one primary target only,
- name the secondary target,
- make the first slice serve the primary target without destabilizing the secondary one,
- prefer internal adapters, constructors, reducers, or support modules before breaking public API shapes.

### A. library-core

Optimize for:
- narrow public surface
- strong domain types
- predictable failure modes
- future API stability
- compile-time invalid-state prevention

Default moves:
- replace raw string/int/bool arguments with enums/newtypes/builders
- replace duplicated state encodings with one canonical type
- move env/fs/network/process/clock access out of core logic
- prefer typed errors on public/external surfaces
- keep `anyhow`/report-style errors at binaries or internal composition boundaries
- document invariants at type and module boundaries

Avoid:
- leaking report-style dynamic errors in public API
- exposing weak DTOs as the core domain model
- trait objects when the set of behaviors is closed
- reshaping public structs/enums as a first move when an internal adapter can remove the same ambiguity without a migration plan

### B. product-shell

Optimize for:
- visible boot flow
- explicit operator/runtime lifecycle
- configuration clarity
- failure diagnosis
- thin `main`, thick tested core

Default moves:
- separate config loading / validation / service construction / runtime start
- move request mapping and orchestration out of `main`
- keep `main` as boot wiring only
- allow application-level error aggregation at the outer shell
- keep user-facing failure context rich

Avoid:
- forcing typed error micro-hierarchies into app bootstrap for no benefit
- hiding startup order in builders/macros so thoroughly that the runtime graph disappears

### C. runtime-bridge

Optimize for:
- exclusive resource ownership
- cancellation semantics
- event/state transitions
- deterministic observation
- recoverability

Default moves:
- prefer dedicated-task / message-passing ownership for exclusive runtime resources
- centralize transition logic in one reducer/transition module
- replace lock-scattered mutations with explicit events and state transitions
- encode probe/run/session status as enums, not `found + error + mode + flag`
- keep transport parsing distinct from runtime state updates

Avoid:
- async mutex everywhere by default
- mixing parsing, supervision, and persistent state updates in one function/file

### D. store-or-reducer

Optimize for:
- one canonical truth
- append/update determinism
- projection clarity
- replayability

Default moves:
- isolate schema IO from projection logic
- isolate event stamping from persistence
- keep reducers pure where possible
- derive metrics/views from canonical events, not side copies

Avoid:
- duplicate truth tables spread across store/view/service files
- write-time side decisions hidden in helpers

## Step 3 — Rust-specific decision rules

### Use enums/newtypes when:
- the value space is named and closed
- combinations of `bool`/`Option` express hidden states
- a string/int has identity semantics

### Use trait objects when:
- the extension set is open across adapters/providers/backends
- test seams need runtime substitution

### Prefer `enum + match` when:
- the domain is closed inside one crate
- exhaustive handling is valuable
- transitions should be visible in one place

### Prefer message passing over shared async locking when:
- one task should own a client/process/session
- requests naturally serialize through one resource
- lock scope would cross `.await`

### Error policy

- Public library surface: typed errors first.
- Internal application-core: dynamic reports acceptable only at composition edges.
- Application shell: rich contextual reports acceptable.
- `unwrap`/`expect`: only for tests, examples, or truly impossible internal invariants that are documented.

## Step 4 — Candidate slice ranking

Rank slices in this order:

1. current proof blocker removal when the repo explicitly says proof/release hardening is the active phase
2. illegal-state removal with behavior preserved
3. public API strengthening without behavior change
4. in-place cohesion cleanup or giant file split along existing boundaries, choosing the lower-indirection option
5. async ownership cleanup that reduces lock ambiguity
6. error-boundary cleanup
7. clone/borrow cleanup
8. cosmetic simplification last

Reject a slice when:
- it needs multiple architectural decisions at once
- behavior preservation cannot be verified
- it changes public API and internal shape together without a migration plan

## Giant file rule

A giant file should be split only when the split line is real.
Good boundaries:
- model vs normalization
- planner vs applier
- reducer vs persistence
- transport parse vs runtime update
- provider-specific vs shared runtime
- public contract mapping vs orchestration

Do not split a file that is giant because it is the one honest reducer or schema truth.
If you keep it large, say why.

## Verification

Minimum loop:
- repo-local proof contract if documented
- otherwise: `cargo fmt --check`
- otherwise: `cargo clippy --all-targets --all-features -- -D warnings`
- targeted tests for the changed surface
- otherwise: `cargo test`

For async/bridge/store changes, also require at least one deterministic scenario test that covers the transition you reshaped.

If the environment cannot run Cargo, state that the refactor is analysis-only and downgrade confidence.
If any proof weakens after the change, restore the touched files from the pre-edit diff or stop with the exact failing proof before widening the slice.

## Output quality bar

A good refactor proposal must answer all of these:
- What kind of Rust surface is this really?
- Why is this structure wrong for that surface?
- What illegal state or mixed responsibility is being removed?
- Why is this the smallest safe slice?
- What proves behavior preservation?
- What is intentionally deferred?

## Comment Rules

- Preserve existing comments that still explain a real invariant, ownership rule, unsafe justification, or boundary hazard.
- Do not add comments when clearer types, enums, functions, module boundaries, or tests make the intent obvious.
- Add a new comment only when the slice introduces or exposes a non-obvious constraint that the code cannot express cheaply on its own.
- Do not leave narration comments, refactor diary comments, TODO comments, or cleanup commentary after a behavior-preserving slice.
- If the change is correct without a new comment, prefer no new comment.

## References

Read these before broad refactors:
- `references/checklist.md`
- `references/target-classification.md`
- `references/auto-research.md`
- `references/slice-patterns.md`
