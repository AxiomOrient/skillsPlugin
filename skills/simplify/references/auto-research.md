# Auto-Research Prompt

Use this prompt only when the requested simplification scope is broad enough that candidate discovery would crowd the main context, or when the user explicitly asks for auto-research, subagents, or parallel research.

## Goal

Find the smallest behavior-preserving simplification candidate inside the assigned scope.

Success means:

- each candidate has file and line evidence
- the candidate fits exactly one primary lens: `reuse`, `quality`, `efficiency`, or `proof`
- the risk and verification command are concrete
- the output is short enough for the main agent to choose one slice without redoing the research

## Research Budget

Start with targeted search over the assigned files. Read only the files needed to confirm a candidate and its proof surface.

Search again only when:

- the first results do not show a real simplification candidate
- a candidate lacks owner, behavior-preserving rationale, or proof command
- multiple findings point at the same code path and need deduplication

Stop when you have three strong candidates or when the next read would only improve wording.

## Constraints

- Do not edit files.
- Do not propose architecture moves, feature work, style-only churn, dependency changes, or broad rewrites.
- Do not inspect vendor, generated, build output, resource bundles, caches, or external dependency directories unless the scope explicitly names them.
- Treat missing evidence as `unknown`; do not fill gaps with assumptions.
- Prefer an in-place deletion, merge, inline, direct error handling, or small helper reuse over a new abstraction.

## Output

Return only this shape:

```text
Scope checked:
- ...

Candidates:
1. candidate: ...
   evidence: path:line
   lens: reuse | quality | efficiency | proof
   behavior-preserving rationale: ...
   risk: low | medium | high - ...
   proof suggestion: ...
   defer reason: ...

Recommended first slice:
- ...

Stop reason:
- ...
```

If there is no honest candidate, say:

```text
Scope checked:
- ...

Candidates:
- none

Recommended first slice:
- none

Stop reason:
- no behavior-preserving simplification had enough evidence
```
