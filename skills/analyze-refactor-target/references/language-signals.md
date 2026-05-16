# Language Signals

Use these signals to identify the likely implementation lane:

- Go:
  - `go.mod`
  - `.go` files
- Python:
  - `pyproject.toml`
  - `requirements.txt`
  - `.py` files
- Rust:
  - `Cargo.toml`
  - `.rs` files
- Swift:
  - `Package.swift`
  - `.xcodeproj`
  - `.swift` files

If multiple signals are present:

- choose the language of the bounded target first
- if the target is still ambiguous, prefer the language with the strongest compatibility or proof obligation
- if the work is mostly manifests, shared docs, or cross-language layout, recommend `execute-bounded-change`
