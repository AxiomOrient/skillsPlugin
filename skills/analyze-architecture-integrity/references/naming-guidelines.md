# Naming Guidelines

Use these rules only when diagnosing naming drift.

## Shared Rules

- Prefer names that answer "who owns this responsibility?"
- Avoid names that only describe convenience, mechanism, or historical leftovers.
- Prefer shorter names once the responsibility is unambiguous.
- Treat `shared`, `common`, `util`, `helper`, `misc`, and `manager` as suspect until proven precise.

## Package Or Module Names

- A good name should predict the dominant reason to change.
- If one name covers policy, persistence, rendering, and orchestration together, it is probably dishonest.
- A boundary name should make extension pressure legible. If every new feature seems to fit under one vague name, the name is too broad.

## Public Types

- Prefer role nouns for owners and state.
- Prefer operation verbs for actions.
- Do not use abstract shells to hide unclear ownership.

## Language Notes

- Go: prefer short lowercase package names tied to responsibility.
- Python: prefer lowercase module names and keep orchestration separate from adapters and domain code.
- Rust: prefer snake_case modules and narrow `pub` surfaces.
- Swift: prefer noun-first module and file names centered on the dominant type or boundary.
- TypeScript or JavaScript: prefer feature or boundary-role names over folklore layer names.
