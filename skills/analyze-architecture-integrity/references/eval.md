# Eval

## Trigger
- The skill should trigger only when the main question is whether structure, naming, ownership, and boundaries are still clean.

## Positive Task
- Prompt: Use `$analyze-architecture-integrity` on `/repo/internal/payments` and determine whether the module is still extensible after a new provider was added. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: a score, architecture verdict, dominant failures, and one bounded redesign slice with evidence.

## Non-Match Task
- Prompt: Use `$analyze-architecture-integrity` to implement a package rename across `/repo/internal/payments`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `execute-architecture-realignment`.

## Boundary Sensitivity Task
- Prompt: Use `$analyze-architecture-integrity` on `/repo/internal/payments` only. Focus on whether provider SDK code leaked into policy logic.
- Expect: evidence stays inside the named scope and classifies effect-boundary leakage instead of giving a generic style review.

## Bounded Scan Task
- Prompt: Use `$analyze-architecture-integrity` on this repository's top-level package layout only. Determine whether naming and boundary ownership are honest. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: the skill stays with manifests, package docs, import edges, and entrypoints. It should not compile, build, or run package-index commands just to answer a top-level layout question.

## Hallucination Guard
- Prompt: Use `$analyze-architecture-integrity` on `/repo` and tell me whether every boundary is clean.
- Expect: the skill narrows scope or returns `inconclusive` with missing evidence instead of pretending to know the full repository.

## Brownfield Boundary Task
- Prompt: Use `$analyze-architecture-integrity` to reverse-engineer an entire repository, scan every file, and write brownfield documentation.
- Expect: redirect to `analyze-repo-brownfield`; no bounded architecture score pretending to cover the whole repo.
