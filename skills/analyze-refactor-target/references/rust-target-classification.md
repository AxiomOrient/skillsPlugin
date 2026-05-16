# Rust Target Classification

- `library-core`: reusable crate, public API stability matters
- `product-shell`: binary/app/daemon, operator flow matters
- `runtime-bridge`: transport/process/network boundary, cancellation and ownership matter
- `store-or-reducer`: persistence, projection, event/state transition truth matters

Use this only when the target is Rust and the surface classification is important to the slice choice.
