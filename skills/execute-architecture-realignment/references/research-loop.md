# Research Loop

Use this loop only when revising this skill itself.

## Source Priority

1. OpenAI official docs for:
- skills
- tools
- structured outputs
- prompt engineering
- evals and agent evals
2. OpenAI GitHub Cookbook examples for measurable improvement loops
3. Local execute and refactor skills for house style and stop conditions

## Improvement Loop

1. Capture one missed-trigger case, one false-trigger case, and one successful realignment case.
2. Run the prompts in [eval.md](eval.md).
3. Change exactly one of:
- trigger wording
- workflow wording
- stop conditions
- checklist or naming rules
4. Re-run the eval prompts.
5. Keep the change only if scope discipline, verification clarity, or trigger precision improved.

## OpenAI-Specific Guidance To Preserve

- Prefer measurable eval loops over intuition-only prompt edits.
- Use structured outputs or rigid output shapes when consistency matters.
- Prefer higher-capability models when architecture judgement quality matters more than speed.
