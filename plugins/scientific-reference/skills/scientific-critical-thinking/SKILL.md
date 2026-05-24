---
name: scientific-critical-thinking
description: Mobile-safe evaluation of scientific claims, evidence quality, study design, bias, confounding, and statistical interpretation.
---
# scientific-critical-thinking

Use this skill when the user asks whether a scientific claim, paper, protocol, result, or argument is well supported.

## Workflow

1. Identify the claim, population/domain, intervention or exposure, comparison, outcome, and evidence type.
2. Separate what the evidence directly shows from what the author or user infers.
3. Evaluate study design, measurement validity, controls, blinding, randomization, sample size, missing data, and statistical assumptions.
4. Check bias and confounding risks before judging conclusions.
5. Grade confidence conservatively and name what evidence would change the assessment.

## Reference Use

Use the included references as needed:

- `references/scientific_method.md`
- `references/experimental_design.md`
- `references/common_biases.md`
- `references/statistical_pitfalls.md`
- `references/evidence_hierarchy.md`
- `references/logical_fallacies.md`

## Output Shape

Return:

- claim being evaluated
- evidence basis
- design and measurement assessment
- bias/confounding assessment
- statistical assessment
- confidence level and rationale
- missing evidence or next verification step

## Mobile Boundary

This skill may request AMA-native artifact support for diagrams, but it must not execute the original schematic scripts or any desktop command.
