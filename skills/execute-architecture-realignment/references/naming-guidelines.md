# Naming Guidelines

Use these rules only when a structure slice changes names.

## Shared Rules

- Prefer names that answer "who owns this responsibility?"
- Avoid names that only describe mechanics, convenience, or historical leftovers.
- Prefer shorter names once the responsibility is unambiguous.
- Do not encode multiple responsibilities in one package or module name.

## Go

- Prefer short lowercase package names tied to responsibility.
- Avoid stutter with exported identifiers.
- Do not create `util`, `common`, `helper`, or `model` packages.

## Python

- Prefer lowercase package and module names.
- Keep `__init__` surfaces minimal and intentional.
- Separate orchestration packages from adapters and domain logic.

## Rust

- Prefer snake_case module names.
- Keep `pub` surfaces narrow and intentional.
- Do not leak internal organization through broad re-export trees unless the API truly needs it.

## Swift

- Prefer noun-first module or target names tied to feature or responsibility.
- Keep files centered on the dominant type or boundary.
- Do not use protocol or manager names to hide unclear ownership.

## TypeScript Or JavaScript

- Prefer folder names by feature or boundary role, not by layer folklore alone.
- Keep barrel exports narrow.
- Do not use `shared` or `utils` as a dumping ground without a precise sub-boundary.
