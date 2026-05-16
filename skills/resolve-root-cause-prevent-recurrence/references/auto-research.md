# Auto-Research For Root Cause Prevention

Use only when the request is broad or missing a complete failure/proof chain.

## Goal

Reduce the request to one actionable chain:

```text
failure signal -> runtime surface -> suspected boundary -> proof command -> prevention guard
```

## Read Budget

Start with:

- the user request and named files, commands, screenshots, or logs;
- the most recent failing command output;
- local instructions such as `AGENTS.md`;
- the closest README, package script, test, fixture, manifest, ledger, or gate file;
- existing skill references only when the request is about skill behavior.

Read more only when:

- the failing surface is ambiguous;
- command output and code disagree;
- generated artifacts, snapshots, or hashes are involved;
- a required external runtime may be missing;
- one focused rerun can distinguish product failure from harness failure.

Stop when:

- one failure signal, one runtime surface, one likely boundary, one proof command, and one prevention guard are clear;
- the request is actually pure scenario QA, review, planning, or unreproduced speculation;
- required proof depends on unavailable credential, permission, or external service.

## Output For Internal Use

```text
Failure signal:
Runtime surface:
Suspected boundary:
Proof command:
Prevention guard:
Route:
Unknowns:
Stop reason:
```

## Routing

- Pure pass/fail scenario validation -> `qa-change-scenarios`
- Unknown causal chain with reproduced failure -> `analyze-root-cause`
- Small known patch -> `execute-bounded-change`
- Product-completion blocker -> `execute-product-completion`
- Skill/process update -> `skill-creator` plus this skill
