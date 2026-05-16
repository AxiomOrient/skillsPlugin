---
name: analyze-test-contract
description: "[analyze] 테스트가 중요한 동작을 제대로 증명하는지 확인합니다. 테스트가 약하거나 불안정하거나 너무 세부 구현에 묶였는지 판단해야 할 때 사용합니다."
---

# Analyze Test Contract

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

If the request is not really about test quality or test-contract accuracy, stop immediately.

- For routine feature work, broad QA, or coverage-only reporting, answer in two parts only:
  - why this skill is not the right tool
  - what normal path should be used instead
- For whole-repo brownfield analysis, summarize tests by protected behavior in `analyze-repo-brownfield` first; use this skill only for a bounded weak-test or failing-test audit.
- Do not force the request into a contract-audit workflow when the real job is implementation or execution.

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## 내부 정리 기준

최종 답변은 짧고 쉽게 쓰고, 문제가 있으면 그것부터 말합니다.

- Default shape:
  - `Finding: ...`
  - `Why: ...`
  - `Better proof: ...`
  - `Change: code | test | both | investigate`
- Use one short block per finding.
- If there are no findings, use:
  - `Verdict: ...`
  - `Keep: ...`
- Do not pad with background explanation unless the user asks.

## Scope Lock

Start with one failing test, one representative test, or one test file only.

- On large repositories, do not audit a whole target or suite in one pass.
- If the request is repo-wide, choose one highest-signal test surface first and say that the rest is deferred.
- If the request is broad, ambiguous, or missing proof commands, read [references/auto-research.md](references/auto-research.md) first and use it only to choose one audit target.
- Limit each pass to one bounded rewrite and one focused proof command unless the contract clearly spans shared infrastructure.
- If the user gives a concrete file path or snippet, lock to that artifact for the first pass and do not inspect sibling tests unless the contract cannot be understood without them.

If a test mirrors a repository rule enforced by a script, manifest, or boundary checker, treat that script and the test as one contract.

- If both the script and the test fail for the same reason, classify product or repo drift before weakening the test.
- Do not “fix” a boundary test by relaxing it when the repository is the thing that drifted.

## Success Criteria First

Before changing tests, lock these four items:

- Goal
- Non-goals
- Done when
- Verification

Example:

```md
Goal: split one broad search test into distinct ranking and snippet contracts.
Non-goals: search algorithm changes, fixture content changes, new public API
Done when:
- each test proves one contract
- failure location identifies the broken contract directly
- no real regression detector is weakened
Verification:
- targeted test command
- full suite if the touched surface is shared
```

## Workflow

1. Identify the proof surface.
2. State the intended contract in one sentence.
3. Classify the test:
   - behavior contract
   - state transition proof
   - wire or schema proof
   - persistence or materialization proof
   - mirror or parity proof
   - timing, cancellation, or concurrency proof
4. Classify the weakness:
   - implementation coupling
   - hidden logic in the test
   - broad scope
   - weak oracle
   - accidental contract
   - flaky dependency
   - missing negative case
   - duplicated proof
5. Decide the verdict:
   - product bug
   - test bug
   - both
   - insufficient evidence
6. Choose one bounded rewrite:
   - split one broad test into narrower contracts
   - strengthen the oracle
   - move the test to the correct surface
   - replace helper-coupled proof with public-surface proof
   - add one missing negative or malformed-input case
   - parameterize repeated examples
7. Verify the changed proof surface first, then widen only if needed.

For repositories with expensive proof scripts:

- start with one test file or one filtered test name
- widen to the full target only if the changed contract shares helpers or fixtures broadly
- run repo-wide proof only when the contract is explicitly repo-wide

Do not batch unrelated test rewrites together.
Do not weaken a true regression detector just to get green.

## Core Rules

- Coverage is not proof. A covered line can still be weakly or wrongly tested.
- One test should prove one meaningful contract.
- Public contract tests should use the public surface, not internal helpers or hidden seams.
- If a system has multiple representations such as state, files, mirrors, caches, indexes, or APIs, test those contracts separately.
- If one representation is derived from another, compare overlapping identities first and only require full parity when full parity is the real contract.
- Prefer hermetic tests with explicit setup, execution, and teardown.
- Hidden branching, loops, or business logic inside tests lowers trust in the test.
- If a failure could come from product code or test code, say so explicitly before rewriting anything.
- Preserve true bug detectors. If the test caught a real regression, fix the product or split the contract; do not erase the signal.

## Rewrite Rules

- Split broad tests when one failure message currently hides multiple contracts.
- Strengthen weak oracles that only check non-empty output, existence, or generic truthiness when a stronger observable behavior is available.
- Prefer descriptive parameterization when the same contract is repeated over multiple examples.
- Treat exact prompt, markdown, or prose string equality as implementation-coupled unless the text itself is a declared product contract.
- When testing zero, nil, or negative limit behavior, use more than one entry so the limit contract is actually observable.
- Keep fixture parity tests when the fixture is the contract. Split them only to improve failure localization.
- Replace timing-sensitive polling or sleeps with owned synchronization when possible. If not possible, make the timing assumption explicit.
- Keep negative-path and malformed-input tests near parsers, validators, serializers, and import/export boundaries.
- If mutation testing or property-based testing would materially strengthen the proof, recommend it as an optional next step rather than making it mandatory by default.

## Language And Environment References

The base workflow is language-agnostic.

- If the request names Swift, SwiftPM, XCTest, or Swift Testing, read [references/swift.md](references/swift.md).
- If the request names Python or pytest, read [references/python.md](references/python.md).
- If the request names Java, JUnit, or mutation testing, read [references/java.md](references/java.md).
- Otherwise stay with the base workflow and do not invent language-specific doctrine.

## Verification

- Verification is mandatory when you change tests, classify an active failure, or claim a rewrite is better.
- For a read-only first-pass audit, you may return findings from the visible test contract without running proof if:
  - no file is changed
  - the contract weakness is directly visible in the test code
  - any repository-level proof contract is already known from the request or nearby scripts
- Run the narrowest real proof command for the changed surface first when proof is actually needed.
- Widen to the full suite only when the test surface shares infrastructure or contracts broadly.
- Prefer proving:
  - the intended contract still holds
  - the split tests fail independently for independent reasons
  - any preserved regression detector still catches the same product bug
- Avoid claiming a test rewrite is better without evidence from a real proof command or clearly stronger oracle.

## Stop Conditions

- Stop when the next change would mix test cleanup with feature work.
- Stop when the remaining complaints are stylistic rather than proof quality.
- Stop when the product behavior itself is undefined and the contract must be clarified before any test rewrite is honest.
- When stopping, name the unresolved contract explicitly.

## References

- Read [references/auto-research.md](references/auto-research.md) only when the audit target or proof surface is unclear.
- Read [references/checklist.md](references/checklist.md) after each audit pass.
- Read [references/eval.md](references/eval.md) when benchmarking or revising the skill.
- Optional language references:
  - [references/swift.md](references/swift.md)
  - [references/python.md](references/python.md)
  - [references/java.md](references/java.md)
- Source material:
  - [Unit testing best practices](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-best-practices)
  - [Software Engineering at Google, Chapter 11](https://abseil.io/resources/swe-book/html/ch11.html)
  - [PIT mutation testing basic concepts](https://pitest.org/quickstart/basic_concepts/)
  - [Hypothesis documentation](https://hypothesis.readthedocs.io/en/hypothesis-python-4.57.1/)
  - [swiftlang/swift-testing](https://github.com/swiftlang/swift-testing)
