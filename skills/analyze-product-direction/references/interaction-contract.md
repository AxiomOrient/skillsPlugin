# Interaction Contract

Use this for every real interactive turn.

## Contents

- Core Rules
- Required Shape
- When To Use Options
- Tone
- Good Example: Mode Selection
- Good Example: Open Question
- Good Example: Approval
- Anti-Patterns

In Codex, the question is the assistant message itself. There is no separate `AskUserQuestion` tool surface here. Emulate gstack's intent by sending one short assistant turn that asks the question plainly, gives the minimum context needed, and then stops so the user can answer.

For Codex app, optimize for a clean chat bubble. The message should read like a person asking one focused question, not like a generated status report.

## Core Rules

- Ask exactly one question at a time.
- Start with 1-2 short sentences that re-ground the user.
- Then ask the question directly in plain language.
- If there are options, include a recommendation and explicit lettered choices.
- End with a direct reply instruction.
- After asking, stop and wait for the user's answer. Do not continue the workflow in the same turn.
- The user should be able to answer without reading a long repo recap.
- Treat the examples below as copyable turn shapes, not vague inspiration.
- Do not narrate your internal process before the question. Skip lines like "I'll inspect context first" or "I'll stop after one question."
- Match the user's language by default.
- Prefer 6-10 short lines total for a question turn in the app.
- Keep the question turn compact. Aim for roughly 120 words or less before the options.
- If a question is needed, the first user-facing assistant message for that step must already be the question turn.
- Read files silently. Do not announce setup, validation, or context gathering before the question.

## Required Shape

For choice questions:

```text
[1-2 short sentences that re-ground the user]

[one direct question sentence]

[one short sentence on why this matters]
[optional one-sentence recommendation]

A) ...
B) ...
C) ...

Reply with A, B, or C. I'll wait for your answer.
```

For open questions:

```text
[1-2 short sentences that re-ground the user]

[one direct question sentence]

[one short sentence on why this matters]
[one short sentence describing the answer shape]

Reply with one short paragraph. I'll wait for your answer.
```

## When To Use Options

Use explicit options for:

- mode selection
- startup stage selection
- browse permission
- prior-design reuse vs replace
- premise agreement vs disagreement
- approach choice
- approve / revise / start over

Do not use a choice question when repo evidence already makes one branch clearly dominant. In that case, infer the branch and ask the next substantive question instead.

## Tone

- plain language
- no internal jargon unless the repo already uses it
- no praise filler
- no fake certainty
- no long preamble that buries the question
- no report labels like `Context:` or `Question:`
- no "here is my full analysis" before the question
- no "I'll first check a few files" process narration before the question
- no hidden second question
- no terminal-style status narration
- no code fences around the actual user-facing question
- no "I will now use this skill" or "I will first inspect context" preamble
- no inline file citation dump unless a specific file is essential to the question

## Good Example: Mode Selection

```text
I can see the product direction, but I still do not know which frame should drive the session.

Which frame should we use for this session?

This matters because the next questions change depending on whether we are pressure-testing a product or shaping a builder project.
My recommendation is startup if real users, sponsor pressure, or business viability matter.

A) startup
B) intrapreneurship
C) hackathon or demo
D) open source or research
E) learning
F) fun or side project

Reply with A, B, C, D, E, or F. I'll wait for your answer.
```

## Good Example: Open Question

```text
I understand the broad problem, but I still do not know which failure hurts enough to anchor the wedge.

What is the single most painful failure you want this product to catch first?

This matters because the wedge should optimize for one costly miss, not five weak ones.
Answer with the failure, who experiences it, and what goes wrong if it is missed.

Reply with one short paragraph. I'll wait for your answer.
```

## Good Example: Approval

```text
The draft now has a recommended direction and a concrete next step. The only missing decision is whether to lock it or keep revising.

What should I do with this draft?

This matters because your choice changes the document state and determines whether we move on to planning or stay in discovery.
My recommendation is Approve if the direction is sharp enough to plan from, even if implementation details are still open.

A) Approve
B) Revise
C) Start over

Reply with A, B, or C. If B, include the section names to change. I'll wait for your answer.
```

## Anti-Patterns

- Do not dump a long repo summary and then tack on a question at the end.
- Do not write `Context:` / `Question:` / `Why this matters:` labels in Codex.
- Do not present options without telling the user how to answer.
- Do not ask a question and then keep analyzing in the same message.
- Do not end a question turn with a completion-style summary that makes the session look finished.
- Do not open with a mode-selection menu when the repo already clearly reads as startup or builder.
