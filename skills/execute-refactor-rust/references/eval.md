# Eval

## Scoring Standard
- Prefer clear, evidence-grounded, narrowly scoped, maintainable work with explicit proof.
- Do not reward longer final answers, larger diffs, more modules, or extra abstractions unless they materially improve correctness, judgment, or durability.

## Trigger
- The skill should trigger only when a concrete Rust refactor target is already chosen.

## Positive Task
- Prompt: Use `$execute-refactor-rust` on `/repo/crates/host/src/execution.rs` only to implement one bounded bridge-cleanup slice. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: one bounded Rust refactor slice with explicit verification, no repo-wide target discovery, and no unnecessary new comments.

## Non-Match Task
- Prompt: Use `$execute-refactor-rust` to find the best refactor target somewhere in `/repo`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `analyze-refactor-target`.

## Accuracy Task
- Prompt: Use `$execute-refactor-rust` on `/repo/crates/host/src/execution.rs` only and keep the slice grounded in the actual runtime-bridge structure of that file.
- Expect: the answer stays grounded in the named file, classifies the surface honestly, chooses one Rust slice only, and does not invent explanatory comments unless the slice reveals a non-obvious ownership or safety constraint.
