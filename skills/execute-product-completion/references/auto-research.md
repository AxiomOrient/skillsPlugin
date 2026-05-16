# Auto-Research Prompt

Use this only before implementing a product-completion step when the remaining work is broad, the blocker source is unclear, or the proof surface is not obvious. Skip it when one requirement, one code owner, and one proof command are already clear.

## Goal

Find one implementable product-completion step with a complete evidence chain:

`requirement or confirmed failure -> current implementation owner -> verification proof`

Success means:

- the step is tied to documented requirement, confirmed failure, or core user path blocker evidence
- the target code owner is named by path/module with a reason
- the verification proof exercises the behavior that will change
- unsupported ideas become backlog or blocker, not implementation scope
- confidence is based on evidence quality, not on intuition

## Research Budget

Start with the smallest set that can build the evidence chain:

- implementation plan, issue, spec, README, acceptance criteria, or user-stated goal
- failing log, reproduction, broken workflow, or core path description when present
- manifests, entrypoints, scripts, tests, fixtures, and configs that prove the core path
- the smallest source files needed to connect requirement, behavior, and proof

Read more only when one evidence-chain slot is empty:

- requirement source is unclear or conflicts with another source
- current implementation owner cannot be located
- proof command exists but does not exercise the behavior
- blocker type may change the step: environment, dependency, credential, requirement conflict, or architecture invariant

Stop when exactly one implementable step has a complete evidence chain, or when the missing evidence is a blocker. Do not keep reading to collect nice-to-have context.

## Accuracy Gates

Do not recommend implementation unless all three gates pass:

1. Requirement gate: quote or cite the source path, test, issue, failing command, or user request that makes the step necessary.
2. Ownership gate: name the code, config, test, or doc surface that owns the behavior now.
3. Proof gate: name the command or manual scenario, expected success signal, and expected failure signal.

If a gate fails, return `blocked` or `근거 부족` and say which evidence would unblock the step.

## Constraints

- Do not edit files during auto-research.
- Do not invent undocumented features, UX assumptions, markets, users, retries, fallbacks, or abstractions.
- Do not turn unrelated cleanup, stabilization, architecture realignment, or refactor desire into product completion.
- Do not choose a step whose proof only proves compilation when the behavior is runtime/user-visible.
- Treat broad green commands as weak unless they exercise the touched behavior.
- Prefer fixing a verified blocker over expanding scope.

## Output

Return only this shape:

```text
Evidence chain:
- requirement/failure/core path: path-or-command - reason
- current owner: path-or-module - reason
- proof: command-or-manual-scenario - expected success / expected failure

Recommended step:
- ...

Goal:
- ...

Non-goals:
- ...

Done condition:
- ...

Failure condition:
- ...

Verification:
- ...

Confidence:
- high | medium | low - evidence-based reason

Backlog or blocker:
- ...

Stop reason:
- ...
```

If no step is safe to implement, return:

```text
Evidence chain:
- requirement/failure/core path: ...
- current owner: missing
- proof: missing

Recommended step:
- none

Backlog or blocker:
- blocked - ...

Stop reason:
- implementation would require guessing
```
