# Rust Slice Patterns

Good first slices:

- isolate parse/normalize logic from IO
- simplify a cohesive reducer/schema/bridge in place when splitting would hide invariants
- replace duplicated status flags with one canonical enum
- move weak public API types behind an internal adapter
- make runtime state transitions and transport parsing easier to distinguish, whether colocated or split
- shrink async lock scope or move ownership to a clearer boundary

Avoid mixing:

- module split + API redesign + dependency swap
- module split without a real contract, ownership, effect, or test boundary
- async model rewrite + public type changes
- proof-contract changes + broad structural cleanup
