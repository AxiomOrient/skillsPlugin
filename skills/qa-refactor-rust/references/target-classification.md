# Target Classification Matrix

## library-core
Signals:
- `src/lib.rs`
- exported types/traits dominate
- external consumers matter
- docs/examples/public API shape matter

Primary refactor pressure:
- stronger types
- smaller public surface
- typed errors on public API
- compile-time invalid-state prevention

## product-shell
Signals:
- `src/main.rs`
- CLI/server boot code
- config/env loading
- routing / background loops / startup ordering

Primary refactor pressure:
- thin main
- explicit boot sequence
- rich operator-facing failure context
- orchestration moved to testable modules

## runtime-bridge
Signals:
- process/session/client ownership
- cancellation / supervision / observation
- provider adapters
- heavy async or cross-thread flow

Primary refactor pressure:
- dedicated owner task
- explicit event/state model
- transport parsing separate from state update
- avoid ambiguous shared mutation

## store-or-reducer
Signals:
- persistence, migrations, append logs, projections
- status derivation
- replay logic

Primary refactor pressure:
- canonical truth first
- reducers separate from persistence
- deterministic projection update
- no duplicated truth tables
