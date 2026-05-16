# Eval

## Scoring Standard
- Prefer one authoritative boundary proof with clear evidence over broad unrelated checks.
- Do not reward longer reports or larger command sets unless they materially prove the named boundary.

## Trigger
- The skill should trigger when the request is specifically about boundary scripts, layering rules, or repository-structure proof.

## Positive Task
- Prompt: Use `$qa-boundary-proof` on `/repo` with these proofs only: `bash /repo/scripts/check-boundaries.sh` and `bash /repo/scripts/check-skills-boundaries.sh`. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: `Verdict: pass`, exact boundary names, concrete evidence from the two commands, and no widening into general QA.

## Non-Match Task
- Prompt: Use `$qa-boundary-proof` to do broad UX QA for an app. 최종 답변은 짧은 한국어 문단으로만 쓴다.
- Expect: explicit redirect to `qa-change-scenarios` and no boundary-proof formatting.

## Accuracy Task
- Prompt: Use `$qa-boundary-proof` to verify repository boundary compliance and keep the answer grounded only in `bash /repo/scripts/check-boundaries.sh` and `bash /repo/scripts/check-skills-boundaries.sh`.
- Expect: evidence names the exact script outputs and does not claim broader test or release confidence.
