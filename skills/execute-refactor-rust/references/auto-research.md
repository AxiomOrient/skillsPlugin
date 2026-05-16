# Auto-Research Prompt

Use this before choosing a Rust refactor slice when the target is broad, mixed-surface, or under-specified.

## Goal

Find the smallest behavior-preserving Rust refactor slice for the chosen target.

Success means:

- the target surface is classified as `library-core`, `product-shell`, `runtime-bridge`, `store-or-reducer`, or mixed
- the first slice removes one concrete responsibility, invariant, or ownership problem
- the slice has a concrete proof command
- the output is short enough to choose and implement without redoing the research

## Research Budget

Start with:

- target crate `Cargo.toml`
- `lib.rs`, `main.rs`, or the named module entrypoint
- repo-local proof or release-hardening docs if present
- the 2-3 files most directly involved in the chosen target

Search or read again only when:

- public API vs product-shell responsibility is unclear
- async ownership, state representation, or error policy affects the slice
- the proof command is missing or does not touch the changed path
- primary Rust/Tokio/crate docs are needed to resolve a disputed pattern

Stop when one safe first slice and proof command are clear, or when the next read would only improve wording.

## Constraints

- Do not edit files during auto-research.
- Do not widen into repo-wide target discovery.
- Do not propose module split, API redesign, dependency swap, and async rewrite in one slice.
- Treat missing evidence as `unknown`.
- Prefer in-place cohesion cleanup when a split would add visibility, import, fixture, or feature-gate cost without stronger invariants.

## Output

Return only this shape:

```text
Target classification:
- primary:
- secondary:

Evidence checked:
- path:line - reason

Recommended first slice:
- ...

Success criteria:
- ...

Verification:
- ...

Stop reason:
- ...
```
