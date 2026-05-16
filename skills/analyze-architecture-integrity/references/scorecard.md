# Architecture Integrity Scorecard

Score each axis `0`, `1`, or `2`.

- `0`: broken, misleading, or materially blocking change
- `1`: partially clear but drifting or inconsistent
- `2`: clear, honest, and easy to extend

Maximum score: `14`

## Axes

1. Boundary ownership
- Is each package, module, or folder owned by one dominant responsibility?
- Are edge adapters, orchestration, and domain logic separated honestly?

2. Dependency direction
- Do dependencies mostly point inward toward policy or core logic?
- Are higher-level decisions free from lower-level framework leakage?

3. Naming honesty
- Do package, module, folder, and public type names describe responsibility rather than convenience or mechanism?
- Are catch-all names such as `util`, `common`, `shared`, `misc`, `helper`, or `manager` avoided unless they are truly precise?

4. Extension seams
- Can one new feature, provider, route, or workflow step be added without editing unrelated modules?
- Are plugin or adapter seams explicit where variability is real?

5. Effect isolation
- Are filesystem, network, database, queue, subprocess, HTTP, UI, or LLM effects kept at clear boundaries?
- Is policy or normalization kept out of edge code where practical?

6. Cohesion
- Does each touched file or package have one dominant reason to change?
- Is heavy coupling structural and explicit rather than accidental and smeared?

7. Verification surface
- Can important behaviors be proven with focused tests or boundary checks?
- Are tests aligned to seams rather than forcing whole-app orchestration for every change?

## Verdict Bands

- `12-14`: `healthy`
- `8-11`: `drifted`
- `0-7`: `critical`

Use `inconclusive` instead of a band when the evidence is too weak to score honestly.

## Common Anti-Signals

- catch-all packages or folders
- circular imports or mutual knowledge across layers
- domain logic importing transport, persistence, or SDK specifics
- naming by mechanism instead of role
- one package both planning and performing side effects
- new variants requiring edits in many siblings
- tests proving only full-stack behavior because seams are missing
