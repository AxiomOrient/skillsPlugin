# Research Loop

Use this loop only when revising this skill itself.

## Source Priority

1. OpenAI official docs for:
- skills
- tools
- structured outputs
- prompt engineering
- evals and agent evals
2. OpenAI GitHub examples, especially Cookbook material for eval flywheels and structured outputs
3. Existing local skill conventions in `${CODEX_HOME:-$HOME/.codex}/skills`

## Improvement Loop

1. Analyze recent false triggers, missed triggers, and low-signal outputs.
2. Measure using the tasks in [eval.md](eval.md) plus one fresh real prompt.
3. Improve only one of:
- trigger description
- output shape
- scorecard wording
- stop rules
4. Re-run the eval prompts.
5. Keep the revision only if trigger precision, evidence quality, or redesign-slice quality improved.

## OpenAI-Specific Guidance To Preserve

- Prefer tool-backed evidence gathering over unsupported claims.
- Prefer structured, schema-like output shapes when consistency matters.
- Treat evals as a permanent loop, not a one-time validation step.
- Use stronger models for difficult architecture judgement when quality matters more than latency.
