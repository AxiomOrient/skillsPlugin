---
name: qa-refactor-rust
description: "[qa] 완료된 Rust 리팩터링을 검증합니다. 동작 보존, 계약 유지, 응집도, 과분리 여부를 확인해야 할 때 사용합니다."
---

# QA Refactor Rust

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

완료된 Rust 리팩터링 한 조각이 동작과 계약을 보존했는지 검증합니다.

성공 기준:
- 검증 대상 diff 또는 changed file set이 분명합니다.
- touched behavior, public contract, proof command가 연결됩니다.
- 결과는 `pass`, `fail`, `inconclusive` 중 하나로 증거 기반입니다.
- proof가 부족하면 통과로 말하지 않고 missing proof를 남깁니다.

범위가 넓어서 검증 표면이 불분명하면 [references/auto-research.md](references/auto-research.md)를 읽고, 거기서 정한 연구 예산과 출력 계약으로 proof surface를 먼저 좁힙니다.

## Non-Match Handling

If there is no concrete refactor candidate or the work is still exploratory, stop immediately.

- For pre-edit analysis:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: analyze-refactor-target
- For implementation:
  - 이 요청이 이 스킬 범위가 아닌 이유를 한 문장으로 말합니다.
  - 더 맞는 스킬이나 조건: execute-refactor-rust
맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Verdict: pass | fail | inconclusive`
- `Behavior checked: ...`
- `Evidence: ...`
- `Missing proof: ...` only when the verdict is inconclusive

## Evidence Rules

- Verify the completed diff or changed file set before running proof; if there is no observable refactor slice, return inconclusive.
- Check public contracts and caller-visible behavior before internal helper shape.
- Do not fail a refactor because code stayed in one file or module. Fail it only if cohesion is accidental, behavior is harder to verify, or coupling is worse.
- Flag over-splitting when the diff adds modules, `pub` leakage, re-exports, feature-gate complexity, fixtures, or dependency edges without a clear behavior-preserving clarity gain.
- Do not edit the refactor while verifying it. If a fix is needed, report fail and hand off to `execute-refactor-rust` or `execute-bounded-change`.
- Treat a green broad command as weak if it does not exercise the touched path; name the smaller missing proof instead of overstating confidence.
- Reward clarity, depth, sound judgment, and durable practical contribution over output volume.
- A refactor passes because it preserves behavior while improving clarity or maintainability, not because the diff is large or the module count changed.

## Verification

- Compare the completed slice against the intended behavior and public contract.
- Prefer the narrowest Rust test, `cargo check`, or targeted command for the touched crate.
- Mark the result inconclusive if the refactor scope or proof command is missing.

## Workflow

1. Lock the exact refactor slice.
2. Re-run the narrowest proof that should preserve behavior.
3. Call out contract drift, missing proof, or widened scope.
4. Call out over-splitting or useful cohesion preservation when it affects maintainability.
5. Do not redesign the refactor.
