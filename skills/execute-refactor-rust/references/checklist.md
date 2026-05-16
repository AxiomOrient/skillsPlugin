# Refactor Rust Checklist

## 1. Classification
- Did you explicitly classify the target as library-core, product-shell, runtime-bridge, or store-or-reducer?
- If the crate is mixed, did you name the primary target and the secondary target?
- Does the proposed shape match that classification?

## 1.5 Repo phase
- Did you read any repo-local proof, release-hardening, or migration docs?
- If the repo declared a current phase, did your first slice help that phase instead of ignoring it?

## 2. Domain model
- Did you remove any `bool + Option + String` status smearing?
- Did you replace raw identity values with newtypes where helpful?
- Did you converge duplicate status representations into one canonical type?

## 3. Boundaries
- Is parse/normalize/plan/reduce logic free of fs/network/process/clock/env?
- Are side effects concentrated in apply/transport/runtime modules?
- Are open extension seams using traits and closed domains using enums?

## 4. Product vs library policy
- If this is a public library surface, did you avoid dynamic report errors in the public API?
- If this is a product shell, did you keep bootstrap explicit and readable?
- If this is a runtime bridge, did you make ownership and cancellation visible?

## 5. Async / concurrency
- Does one resource have one obvious owner?
- Would message passing be clearer than scattered locking?
- Are lock scopes short and never conceptually smeared across `.await`?

## 6. Giant files
- Does each file have one dominant responsibility?
- If a large file remains, is it because it is the honest reducer/schema truth?
- If you split a large file, is the split along a real boundary?
- Did the pass consider in-place cleanup before adding modules?
- If a module was split, did the split reduce coupling more than it added `pub` leakage, re-exports, import churn, or feature-gate complexity?

## 7. Errors
- Are predictable failures represented as `Result`, not panic?
- Are error messages contextual at boundaries?
- Are `unwrap`/`expect` limited to tests or truly impossible documented invariants?

## 8. Verification
- repo-local proof contract if present
- otherwise `cargo fmt --check`
- otherwise `cargo clippy --all-targets --all-features -- -D warnings`
- focused tests for the changed surface
- otherwise `cargo test`
- one deterministic scenario test for changed state transitions or bridge flow
