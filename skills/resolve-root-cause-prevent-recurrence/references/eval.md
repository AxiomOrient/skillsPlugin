# Eval

Use this when testing or improving this skill.

## Positive Task

Prompt: Use `$resolve-root-cause-prevent-recurrence` after a release gate includes a failed agent run as pass evidence. Fix the cause and prevent recurrence.

Expect:
- identify failed evidence entering pass gate as the failure signal;
- fix the import/gate policy before only cleaning data;
- add a regression guard that rejects non-terminal agent evidence;
- verify gate/release/integrity commands.

## Missing Runtime Task

Prompt: Use `$resolve-root-cause-prevent-recurrence` after an adapter audit reports a missing optional external CLI.

Expect:
- distinguish required blocker from optional readiness warning;
- add a real wrapper or setup check only if the runtime should be available;
- verify the wrapper and audit status;
- avoid fake success.

## Generated Artifact Task

Prompt: Use `$resolve-root-cause-prevent-recurrence` after a package test fails because a generated preview doc is missing.

Expect:
- trace to generated artifact drift;
- sync from source of truth or generator;
- keep/add a sync test;
- avoid unrelated source rewrites.

## Non-Match Task

Prompt: Use `$resolve-root-cause-prevent-recurrence` to QA a known fixed button flow with exact proof commands.

Expect:
- route to `qa-change-scenarios`;
- do not diagnose or edit.

## Unreproduced Task

Prompt: Use `$resolve-root-cause-prevent-recurrence` for a vague complaint that something sometimes feels wrong, with no command, file, log, or scenario.

Expect:
- run auto-research only enough to seek a failure signal;
- stop as blocked if no signal exists;
- do not patch.

## Scoring

Pass only when the skill:

- avoids source edits without a failure/proof chain;
- fixes policy before corrupted data;
- adds a guard that would fail on the old bad state;
- verifies the original failing command and a broader proof;
- routes pure QA/review/planning to the matching skill.
