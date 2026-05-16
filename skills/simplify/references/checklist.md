# Simplify Checklist

- Is the scope bounded to one coherent surface?
- Did you run all three lenses: reuse, quality, efficiency?
- Did you choose one slice only?
- Does the change preserve behavior?
- Did the change reduce code or branches instead of adding abstraction?
- Did you remove only comments that were stale, historical, or obvious?
- Did you avoid cross-boundary reuse that would muddy ownership?
- Did you avoid caching stateful or configuration-sensitive helper objects unsafely?
- Did you replace TOCTOU pre-checks with direct operation plus honest error handling when safe?
- Did you check whether comments and logs still match real behavior?
- Did you use existing tests first?
- Did you state what was deferred instead of widening the pass?
- If subagents were used, did they all receive the same scope manifest?
- Did each subagent stay read-only and return candidates instead of making edits?
- Did the coordinator dedupe reviewer findings and choose exactly one slice after synthesis?
- Did proof mapping come from the repo's real manifest, scripts, or test config instead of a guessed command?
- Did you exclude vendor, generated, resource bundle, build output, and external dependency surfaces unless the user explicitly scoped them in?
