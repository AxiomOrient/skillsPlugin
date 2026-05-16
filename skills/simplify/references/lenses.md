# Simplify Lenses

Use these three lenses in order and keep their outputs separate until synthesis.

## Reuse

Look for:
- repeated compatibility conversion
- repeated decode or normalize logic
- repeated identifier or cache-key construction
- repeated test wait helpers or setup helpers
- repeated serializer, decoder, parser, regex, formatter, or mapper construction in common paths
- repo-local helpers that already define the same serializer, parser, path, or formatter policy

Do not force reuse when:
- the duplicate code sits on different ownership boundaries
- a shared helper would leak the wrong dependency inward
- the repeated object is stateful, mutable, or configuration-sensitive
- the existing helper has different key strategy, byte output, newline, error, or compatibility semantics

## Quality

Look for:
- stale or historical comments
- empty or weak catch blocks
- one-line wrappers with no boundary value
- comments that describe *what* obvious code does
- logs or warnings whose text says one thing but control flow does another
- style-only cleanup that should be deferred because it has no behavior-preserving simplification value

Keep comments when:
- they explain invariants
- they explain compatibility constraints
- they explain effect or ownership boundaries

## Efficiency

Look for:
- TOCTOU patterns such as `exists` then `read/remove`
- repeated expensive work on common paths
- extra allocations or wrappers on hot/common flows
- safe opportunities to reuse stateless encoders, decoders, parsers, or formatters

Do not trade clarity for micro-optimization unless the simplification also makes the path easier to reason about.
Do not rewrite persistence, rollback, or missing-file nil behavior unless the narrower error contract and path-specific proof are clear.

## Default Exclusions

Exclude vendor directories, generated outputs, build artifacts, resource bundles, and external dependency code unless the user explicitly includes that surface and the repository owns the behavior.
