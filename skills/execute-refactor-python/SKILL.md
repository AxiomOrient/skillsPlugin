---
name: execute-refactor-python
description: "[execute] 이미 선택된 Python 리팩터링 범위를 구현합니다. 동작은 유지하면서 이름, 구조, 중복, 책임 분리를 작게 정리할 때 사용합니다."
---

# Execute Refactor Python

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

Refactor the chosen Python target in the smallest behavior-preserving slice.

Success means:
- the goal, non-goals, done condition, and verification are clear before editing
- the change has one purpose and does not mix feature, policy, framework migration, or broad rewrite work
- behavior is preserved by the narrowest honest test, build, or smoke proof available
- any deferred slice is named only when it is needed to explain why the current slice stopped

Before tool-heavy work, send a one- or two-sentence user-visible update naming the first evidence you will inspect. Stop when the current slice is verified, when the next change would mix purposes, or when proof is too weak to justify more edits.

If the chosen target is broad, effect-heavy, or lacks an obvious proof command, read [references/auto-research.md](references/auto-research.md) before selecting the first slice. Use it to narrow research, not to discover a new repo-wide target.

Refactor Python automation code toward explicit contracts, explicit state, and thin effect boundaries. Preserve behavior first, then simplify the structure in the smallest slice that can be verified.
Do not equate refactoring with splitting. A cohesive Python file can be the best design for one workflow, parser, command surface, or adapter when locality makes it easier to run, review, and maintain.

Think in three compact lenses and repeat until the next slice is obvious:

- Contract first: what input, output, or state shape is still implicit?
- Effect first: which filesystem, process, network, LLM, or clock effect is leaking into core logic?
- Restartability first: if this step fails halfway through, what can safely be retried or replayed?

Prefer the standard library first. Reach for `dataclasses`, `typing`, `pathlib`, `asyncio`, `subprocess`, and `logging` before introducing new framework layers or convenience wrappers.
Prefer simple data and functions over framework magic. In automation code, boring code is usually the more durable refactor target.
Prefer deleting thin wrappers and hidden indirection before adding new abstractions. Simpler call graphs usually beat clever reuse in agent workflows.

Before choosing a slice, classify the changed surface into one or two dominant shapes:

- pure logic or normalization
- parser or decoder
- CLI or operator surface
- workflow planner, executor, or verifier
- explicit I/O boundary such as filesystem, subprocess, network, database, or LLM
- async orchestration or background job lifecycle

When the user gives only a scenario, snippet, or design direction, reason from the stated facts and make assumptions explicit. Do not block on local repository discovery unless the user asked for repository-specific validation or repo-specific edits.
When rejecting a non-idiomatic design direction, explain the Python-specific reason first. Do not pivot to workspace mismatch unless repository validation is part of the request.
Assume the refactor target is already chosen. If target discovery is still needed, redirect instead of doing discovery work here.

## Non-Match Handling

If the request does not match this skill, stop immediately.
For any non-match, briefly say this is not the `execute-refactor-python` lane, then name the better lane. Do not inspect the repository or choose a Python target.
If the prompt says "find the best refactor target" or asks where to refactor, answer only that this is target discovery for `analyze-refactor-target`; never name a file, package, module, risk, or proposed slice.

- For ordinary bug fixes, feature additions, framework-wide rewrites, GUI work, or pure performance tuning, answer in two parts only:
  - why this skill is not the right tool
  - what normal path should be used instead
- For requests that still need target discovery:
  - 첫 문장을 이렇게 시작합니다: 이 요청은 `execute-refactor-python` 범위가 아닙니다.
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
Goal: clarify the repo sync workflow so planning choices and subprocess execution are easier to verify.
Non-goals: CLI UX changes, new retry policy, new logging backend
Done when:
- plan/apply/verify responsibilities are explicit
- code may stay in one file if that keeps failure handling easier to follow
- subprocess calls live behind one port
- tests still pass
Verification:
- python -m pytest
```

If these are not explicit, do not call the refactor done.
Do not turn this skill into repo-wide candidate discovery.

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A better refactor makes one real behavior, boundary, or invariant easier to read and verify; more split files, more abstractions, or larger diffs are not proof of improvement.
- Prefer the least clever code shape that preserves idiomatic Python and makes failure, cleanup, and ownership easier to audit.
- If the next change would only improve appearances or metrics, stop instead of creating churn.

## Workflow

1. Read the workflow boundary, changed surface, and effect edges before touching helpers.
2. Write Goal, Non-goals, Done when, and Verification.
3. Identify one real unit of change:
   - contract extraction
   - state record extraction
   - pure logic extraction
   - in-place cohesion cleanup
   - parser isolation
   - CLI boundary cleanup
   - plan/apply/verify split
   - port or adapter isolation
   - error or retry policy cleanup
   - async lifecycle cleanup
   - logging or checkpoint boundary cleanup
4. Add or confirm the smallest useful regression check.
5. Pick one bounded slice and implement it unless a stop condition is hit.
6. Run verification for the changed surface.
7. Re-evaluate and choose the next smallest slice only after the previous slice is green.

Do not batch multiple refactor purposes into one change.
Do not mix feature work into the slice.
This applies even when the skill is invoked explicitly. For non-matching requests, decline immediately and do not inspect the local repository unless the user separately asked for repository-specific debugging or edits.

## Contract-First Rules

- Move untyped workflow payloads toward explicit contracts at the boundary.
- Use `TypedDict` for boundary dict payloads.
- Use frozen, slotted `dataclass` records for internal state, commands, and results.
- Use `Protocol` for replaceable ports and adapters.
- Do not let `dict[str, Any]` flow through core decision logic once the boundary is known.
- If a contract is still unstable, narrow it before introducing new behavior.

## Cohesion And Split Balance Rules

- Prefer the shape that makes the workflow easiest to run, inspect, and change. Fewer files can be better when the behavior is tightly coupled.
- Split only for a real boundary: a separate public contract, effect adapter, reusable parser, independently testable policy, or workflow phase that changes at a different cadence.
- Keep code together for one authoritative schema, one command implementation, one linear workflow, one small adapter, or one parser where cross-file navigation would obscure the actual order of operations.
- Before adding a module, count the cost: imports, package init surface, test fixtures, mock plumbing, and hidden dependency direction. If the cost exceeds the clarity gain, simplify in place.

## Surface Triage Rules

- Name the dominant surface before recommending edits.
- If the code is mainly pure logic, optimize for explicit inputs and outputs instead of clever class hierarchies.
- If the code is mainly a parser or decoder, distinguish tokenize, decode, validate, and apply-time effects; split only when those stages are independently useful or hard to test in place.
- If the code is mainly a CLI surface, distinguish argument parsing, command selection, execution, and output formatting; keep a compact command together when that improves usability.
- If the code is mainly workflow orchestration, distinguish plan, apply, verify, and checkpoint boundaries; keep a linear workflow together when cross-file hops make failure handling harder to follow.
- If the code is mainly an async or background lifecycle, make task ownership, cancellation, and checkpoint behavior explicit before shuffling helpers.

## Pure Core And Effect Shell Rules

- Keep normalization, planning, validation, scoring, and verification free of filesystem, subprocess, network, database, LLM, and clock access where practical.
- Keep side effects in thin adapters or apply-time shells.
- Do not force everything into a fake pure pipeline when the boundary is inherently effectful.
- Prefer pure helpers that accept explicit values and return explicit results over helpers that reach into global objects or context bags.
- When splitting mixed code, move plan or normalize logic first and keep apply-time code thin.

## State Record Rules

- Replace scattered mutable fields or global bags with explicit state records.
- Prefer one visible `RunState`, `TaskState`, or `CheckpointState` record over many hidden attributes.
- Use `dataclasses.replace` or fresh result objects instead of hidden in-place mutation where that clarifies the flow.
- Do not store live connections, open handles, or process objects in checkpoint state.
- Make retry count, last error, current step, and result code explicit if they drive control flow.

## Plan / Apply / Verify Rules

- `plan_*` must not perform side effects.
- `apply_*` must not invent new business policy.
- `verify_*` should judge outputs with minimal or no side effects.
- Dry-run should fall out naturally from this split.
- If dry-run is impossible, the code is probably still mixing plan and apply.

## Ports And Adapters Rules

- Hide `subprocess`, HTTP, filesystem, database, and LLM calls behind narrow ports.
- Keep one adapter per effect family where practical.
- Do not let orchestration code call `subprocess.run`, raw HTTP clients, or direct file writes from many places.
- Prefer adapters that return explicit result objects rather than naked tuples or ad hoc dicts.

## Path And Filesystem Rules

- Use `Path` for path construction and return `Path` from path-calculation helpers.
- Separate path calculation from file reading or writing.
- Do not build important paths by string concatenation if `Path` makes the contract clearer.
- Make idempotent writes and checkpoint layout explicit.
- When retry or replay is expected, prefer idempotent effects so the same apply step can run twice without corrupting state.

## Parser Rules

- Keep tokenize, parse, validate, and apply steps distinct when they are currently interleaved.
- Prefer parser functions that return explicit parsed values and explicit errors.
- Do not hide malformed-input handling inside effectful orchestration.
- For parser-heavy code, the first safe slice is usually extraction of pure-ish decode or normalize helpers, not a format rewrite.

## CLI Rules

- Keep CLI surfaces thin: parse args, resolve command, call a concrete workflow, print results.
- Do not mix flag parsing, business rules, persistence, and transport formatting in one long function if a smaller seam is available.
- Preserve user-facing behavior unless the refactor explicitly scopes CLI UX changes.
- Prefer one slice that separates command parsing or selection from execution, rather than reorganizing the whole CLI tree.

## Async And Background Rules

- Add `async` only at real I/O boundaries; do not spread it by contagion.
- Every created task needs a visible owner, cancellation path, and shutdown condition.
- Prefer `TaskGroup` for bounded fan-out.
- Keep retry policy in orchestration, not hidden inside worker tasks.
- Make timeout and cancellation policy explicit at the boundary.

## Error, Retry, And Timeout Rules

- Model failure classes explicitly when they matter for control flow.
- Do not use broad `except Exception` unless it immediately re-raises with context or is the final process boundary.
- Keep retry policy at the effect boundary.
- Make timeout behavior explicit.
- Do not continue after failure unless the skip-or-continue policy is explicit in code.

## Logging And Checkpoint Rules

- Treat logs as events, not just prose.
- Include stable fields such as `run_id`, `task_id`, `step`, `attempt`, and `result` where those exist.
- Prefer structured logging over `print`.
- Keep checkpoints serializable and restart-safe.
- Do not store sensitive raw payloads by default just because logging is available.

## Test Structure Rules

- Prefer table-driven tests with subtests or parametrization when the changed surface has multiple input and error-path variants.
- Keep contract tests close to ports and adapters.
- Keep at least one workflow-level path green when splitting orchestration.
- For parser-heavy code, pair focused input cases with malformed-input cases.
- For retry, timeout, cancellation, or checkpoint logic, add one behavior test that proves the policy rather than only the implementation detail.

## Packaging And Dependency Rules

- Keep packaging and tool configuration honest with `pyproject.toml`.
- Do not mix dependency churn, build backend swaps, or toolchain migration into a normal refactor slice unless that is the explicit goal.
- If imports or package layout changed, verify the project metadata and test entrypoints still line up.

## Verification

- Verification is mandatory.
- Run targeted checks first for the changed surface, then widen if needed.
- If write access or command execution is blocked, state the blocked proof explicitly and do not present the planned refactor as completed work.
- Default loop:
  - `python -m pytest`
- Add checks when the change touches specific risk areas:
  - parser or decoder changes: add focused malformed-input coverage
  - CLI changes: run focused command tests plus one smoke path if available
  - async or background changes: keep cancellation or lifecycle tests green
  - packaging changes: verify `pyproject.toml` and entrypoints still work
  - long-running async workflows: if available, inspect task state with runtime tooling rather than guessing
- Prefer real behavior tests over snapshot-only proof when orchestration or restart behavior moved.
- If multiple good slices exist, finish the highest-leverage safe slice first, then list remaining slices in priority order.
- Avoid creating notes or reports unless the user explicitly asks for them.

## Stop Conditions

- Stop when the next change would mix refactor work with feature or policy changes.
- Stop when the only remaining change is stylistic churn.
- Stop when behavior risk grows faster than the test baseline.
- Stop when a packaging change, dependency swap, or async model rewrite should be isolated as its own slice.
- When stopping, name the deferred slice explicitly so the next pass starts from a concrete boundary.

## Repeat Loop

After each slice, ask four short questions:

- Is the change still one purpose?
- Is the contract or effect boundary clearer, or did keeping the workflow together make local reasoning better?
- Is state, retry, or lifecycle easier to reason about?
- Did verification prove behavior preservation?

If the answer is not clearly yes, shrink the next slice.

## Comment Rules

- Preserve existing comments that still explain a real invariant, boundary, restartability constraint, or hazard.
- Do not add comments when clearer contracts, names, extracted helpers, or tests make the intent obvious.
- Add a new comment only when the slice introduces or exposes a non-obvious constraint that would otherwise stay implicit.
- Do not leave narration comments, refactor diary comments, TODO comments, or cleanup commentary after a behavior-preserving slice.
- If the change is correct without a new comment, prefer no new comment.

## References

- Read [references/auto-research.md](references/auto-research.md) only when the selected target is broad or the proof surface is unclear.
- Read [references/checklist.md](references/checklist.md) after each refactor pass.
- Read [references/eval.md](references/eval.md) when benchmarking the skill, revising the trigger description, or comparing candidate versions against the baseline.
- Source material:
  - [Python 3.14 documentation](https://docs.python.org/)
  - [PEP 20](https://peps.python.org/pep-0020/)
  - [typing](https://docs.python.org/3/library/typing.html)
  - [subprocess](https://docs.python.org/3/library/subprocess.html)
  - [pathlib](https://docs.python.org/3/library/pathlib.html)
  - [asyncio](https://docs.python.org/3/library/asyncio.html)
  - [Coroutines and tasks](https://docs.python.org/3/library/asyncio-task.html)
  - [logging](https://docs.python.org/3/library/logging.html)
  - [Writing your pyproject.toml](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)
  - [Python classes tutorial](https://docs.python.org/3/tutorial/classes.html)
  - [What’s New in Python 3.14](https://docs.python.org/3/whatsnew/3.14.html)
