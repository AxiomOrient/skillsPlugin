---
name: analyze-refactor-target
description: "[analyze] 코드를 바로 바꾸기 전에 리팩터링 대상과 가장 작은 안전 범위를 찾습니다. 큰 정리 작업을 작게 자르거나 과한 분리를 피해야 할 때 사용합니다."
---

# Analyze Refactor Target

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

If the request is not about behavior-preserving structural refactoring, stop immediately.

- For net-new features, routine bug fixes, docs-only work, or pure performance tuning:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 먼저 필요한 조건을 한 줄로 말합니다.
- For whole-repo reverse engineering, brownfield docs, or broad risk inventories:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-repo-brownfield
## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Target: ...`
- `Language: ...`
- `Primary surface: ...`
- `Slice: ...`
- `Recommended execute lane: ...`
- `Verify: ...`

## Evidence Rules

- Name the files, manifests, tests, or call paths that make the target worth touching.
- Separate observed complexity from guessed future cleanup value.
- Exclude runtime artifacts from target discovery by default: build output, caches, coverage output, compiled output, dependency install directories, editor/tool local state, and archive metadata. Consider one only when the user explicitly scopes it or the refactor target is the generator/consumer that owns that exact artifact.
- Treat "keep this in one file/module" as a valid target decision when cohesion, discoverability, dependency management, or local reasoning would get worse after a split.
- Do not treat file length, function count, or module count alone as evidence that extraction is valuable.
- Stop if the user already chose the refactor target and only needs implementation.

## Cohesion / Split Balance

- Refactoring is not synonymous with splitting. Prefer the shape that makes the behavior easiest to understand, change, and verify.
- A split is worth recommending only when there is a real boundary: different change cadence, different owner, different public contract, different runtime effect, different test surface, or repeated code that cannot be simplified in place.
- Keeping code together is often better for one authoritative schema, one reducer/state transition table, one CLI command surface, one tightly coupled parser, or one adapter whose behavior is easier to audit in a single place.
- Before recommending extraction, name the cost: extra files, imports, visibility changes, indirection, test setup, and dependency direction. If that cost is higher than the clarity gain, recommend an in-place simplification instead.

## Large Surface Split Rules

Use these rules when the apparent target is a large file, type, object, package, or module.

- Size is only a smell. Do not recommend a split because of line count alone.
- First check whether the large surface is intentionally centralized:
  - aggregate or consistency boundary
  - composition root, coordinator, or facade
  - same-primary-entity support file
  - generated or framework-mandated colocation
  - hot-path locality surface
- Recommend `NO_SPLIT` when splitting would make searchability, invariants, dependency direction, or public API clarity worse.
- Recommend `EXTRACT_INTERNAL` when there are real concerns but the public or file boundary is not ready to move.
- Recommend `SPLIT_CANDIDATE` only when sub-boundaries are clear and extraction can be staged.
- Recommend `SPLIT_NOW` only when the smallest behavior-preserving extraction is obvious and locally verifiable.
- Before a split recommendation, name the first concrete extraction target and the proof that behavior stays unchanged.

## Workflow

1. If the user already named a target, validate that it is a real refactor surface.
2. If the target is not named, scan the bounded scope for the highest-value refactor candidate only, excluding runtime artifact paths.
3. Classify the dominant surface and the likely implementation language.
4. Choose the smallest behavior-preserving slice. The slice may be in-place simplification, naming/contract cleanup, or an explicit decision not to split.
5. Recommend the correct execute lane for that target:
   - `execute-refactor-go`
   - `execute-refactor-python`
   - `execute-refactor-rust`
   - `execute-refactor-swift`
   - or `execute-bounded-change` when the work is truly language-agnostic
6. Stop before editing.

## Read

- `references/checklist.md`
- `references/language-signals.md`

If the target is Rust and the shape is disputed, also read:

- `references/rust-target-classification.md`
- `references/rust-slice-patterns.md`
