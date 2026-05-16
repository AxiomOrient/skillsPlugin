---
name: execute-architecture-realignment
description: "[execute] 이미 정해진 구조 문제를 실제 코드 변경으로 바로잡습니다. 동작은 유지하면서 패키지, 모듈, 이름, 책임, 의존 방향을 작은 범위에서 정리할 때 사용합니다."
---

# Execute Architecture Realignment

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

## Non-Match Handling

If the request is still exploratory, is mainly a bug fix, or has no clear structure goal, stop immediately.
For any non-match, the first sentence must say that this is not the `execute-architecture-realignment` lane, then name the correct analysis or execution lane. Do not inspect files or propose a structure target.

- For target discovery:
  - 이 요청은 `execute-architecture-realignment` 범위가 아닙니다: structure target not chosen
  - 더 맞는 스킬이나 조건: analyze-architecture-integrity or `analyze-refactor-target`
- For ordinary implementation:
  - 이 요청은 `execute-architecture-realignment` 범위가 아닙니다: ordinary code change
  - 더 맞는 스킬이나 조건: execute-bounded-change
- For API-only design:
  - 이 요청은 `execute-architecture-realignment` 범위가 아닙니다: contract design only
  - 더 맞는 스킬이나 조건: design-api-contract
## 내부 정리 기준

최종 답변은 짧고 쉬운 한국어 문단으로 씁니다.

- Default shape:
  - `Goal: ...`
  - `Slice: ...`
  - `Verify: ...`
  - `Next: ...`
- 필드 나열 대신 짧은 문단으로 자연스럽게 정리합니다.
- Omit `Next` if there is no immediate next slice.

## Success Criteria First

Before editing, lock these four items:

- Goal
- Non-goals
- Done when
- Verification

If these are not explicit, do not call the restructure done.

## Quality Bar

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A structure change is valuable only when future edits become safer or easier because ownership, naming, dependency direction, or public surface is clearer.
- More files, broader moves, bigger diagrams, or longer explanations are not success by themselves.
- If the slice no longer improves an actual boundary, stop instead of turning the work into naming churn.

## Workflow

1. Read the chosen boundary, changed surface, and manifest or import edges before touching helpers.
   - If the target boundary is already named, do not run a fresh architecture-discovery pass.
   - Confirm the named files and dependencies only enough to lock one safe slice.
2. Write Goal, Non-goals, Done when, and Verification.
3. Choose one real unit of change:
   - package or module rename
   - boundary extraction
   - dependency inversion
   - layer cleanup
   - public surface reduction
   - effect-boundary cleanup
   - folder or manifest realignment
   - extension seam extraction
4. Update the smallest necessary code, imports, manifests, and tests.
5. Run focused verification first.
6. Re-evaluate only after the slice is green.

Do not batch multiple redesign purposes into one change.
Do not smuggle feature work into a structure slice.
Do not turn exploratory structure analysis into an execution patch; hand it to `analyze-architecture-integrity` or `analyze-refactor-target`.
If the work turns into parser extraction, concurrency cleanup, lifecycle cleanup, or other language-native restructuring inside an already-honest boundary, stop and hand off to the relevant `execute-refactor-*` lane.

## Naming Rules

- Name packages, modules, folders, and public types by responsibility.
- Do not create or preserve catch-all names such as `util`, `common`, `shared`, `helper`, `misc`, `base`, or `manager` unless the responsibility is truly singular and defensible.
- Prefer stable nouns for ownership and verbs for operations.
- If a rename would reduce ambiguity but widen too much code churn, stop and isolate the rename as its own slice.
- Follow language-local naming rules from [references/naming-guidelines.md](references/naming-guidelines.md).

## Boundary Rules

- Move dependencies inward toward stable policy or domain code when possible.
- Keep I/O, framework, SDK, persistence, and transport code at the edge.
- Keep one owner per side effect family where practical.
- Prefer consumer-owned interfaces or narrow ports over producer-owned abstraction layers.
- Shrink exports before adding more abstractions.

## Restructure Rules

- Split by reason to change, not by file length alone.
- If one file remains large because it is the single authoritative transition surface, protocol definition, or schema owner, leave it centralized and say why.
- Prefer one clear seam over many decorative layers.
- When moving code, move the minimum unit that clarifies ownership.
- When a public surface is too wide, reduce the surface before introducing new wrappers.
- Do not restructure vendor, generated, cache, or third-party trees unless the user explicitly scoped them:
  - `.git`
  - `node_modules`
  - `dist`
  - `build`
  - `.next`
  - `.svelte-kit`
  - `target`
  - `vendor`
  - `__pycache__`
  - `.venv`
  - `DerivedData`
  - `generated`

## Manifest And Package Rules

- Keep package or module metadata honest:
  - `go.mod` and `go.sum`
  - `pyproject.toml`
  - `Cargo.toml`
  - `Package.swift`
  - equivalent workspace manifests
- Do not mix dependency churn or toolchain migration into a normal structure slice unless that is the explicit goal.
- If folder or module names changed, verify entrypoints, exports, and import paths still line up.

## Verification

- Verification is mandatory.
- Run the cheapest proof that can honestly show the slice preserved behavior.
- Prefer target-local build or test commands first, then widen only if the boundary is shared.
- Add one boundary-oriented proof when possible:
  - import or compile check
  - focused unit or integration test
  - lint or boundary rule check
  - manifest or entrypoint validation
- If a rename or move touches public imports, verify old assumptions are either intentionally removed or explicitly migrated.
- Do not trigger broad repo builds when import, compile, lint, or focused test proof is enough for the named slice.

## Stop Conditions

- Stop when the next change would mix structure work with feature or policy changes.
- Stop when the remaining work is naming churn without structural payoff.
- Stop when the next slice needs a new architecture decision that has not been analyzed yet.
- Stop when proof is weaker than the risk introduced by the move.

## Read

- [references/checklist.md](references/checklist.md)
- [references/naming-guidelines.md](references/naming-guidelines.md)
- [references/eval.md](references/eval.md)
- [references/research-loop.md](references/research-loop.md)
