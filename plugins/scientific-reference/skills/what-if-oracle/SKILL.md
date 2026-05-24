---
name: what-if-oracle
description: Mobile-safe structured what-if scenario analysis for uncertain futures, strategic decisions, risks, contingencies, and second-order effects.
---
# what-if-oracle

Use this skill when the user asks "what if", wants scenario analysis, needs to stress-test a decision, or wants best case, likely case, worst case, contrarian, wild-card, and second-order possibilities.

## Workflow

1. Sharpen the scenario question before analysis. Identify the variable, magnitude, timeframe, current context, and decision owner.
2. If the question is vague, state the sharpened version and proceed only when it is reasonable from the supplied context.
3. Map 3 to 6 branches depending on stakes and user time:
   - best case
   - likely case
   - worst case
   - wild card
   - contrarian
   - second-order cascade
4. For each branch, give probability, confidence, narrative, assumptions, trigger signals, consequences, and required response.
5. Synthesize robust actions, hedge actions, decision triggers, and the most easily missed factor.

## Reference Use

Use `references/scenario-templates.md` for reusable branch structures and scenario prompts.

## Output Shape

Return:

- sharpened what-if question
- branch table
- branch narratives
- robust actions
- hedges
- decision triggers
- one non-obvious insight

## Mobile Boundary

This is a reasoning-only AMA skill. Do not run external programs, scripts, or desktop automation.
