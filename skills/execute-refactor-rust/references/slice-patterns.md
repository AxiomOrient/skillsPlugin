# Preferred Slice Patterns

## Pattern A — Status model convergence
Before:
- `found: bool`
- `runtime_mode: Option<String>`
- `probe_error: Option<String>`
- `supports_json_events: bool`

After:
- `enum ProbeStatus { Missing, Degraded, Ready }`
- `struct ProbeMetadata { runtime_mode, capabilities, version }`

Use when status meaning is distributed across flags.

## Pattern B — Thin binary boot
Before:
- `main.rs` loads env, builds services, creates router, starts background loops, handles mapping

After:
- `config.rs`
- `bootstrap.rs`
- `service.rs`
- `main.rs` only wires and starts

Use when app startup order is hard to see.

## Pattern C — Actorized runtime owner
Before:
- `Arc<Mutex<State>>`
- process/client ownership shared across helpers

After:
- dedicated owner task
- request enum via channel
- response enum via oneshot
- reducer for visible transitions

Use when one exclusive runtime resource is being shared ambiguously.

## Pattern D — Reducer extraction
Before:
- persistence, event stamping, and projection update mixed

After:
- pure reducer module
- IO persistence module
- small orchestration function

Use when replay and correctness matter more than local brevity.
