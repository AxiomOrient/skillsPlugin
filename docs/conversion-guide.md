# Converting Desktop Skills To AMA

Do not copy Codex or Claude desktop skills into AMA. Convert the user value, not the implementation.

## Conversion Decision Tree

1. Is the skill about developer process, repository work, CI, code review, refactoring, or shell tooling?
   - Do not convert unless there is a mobile end-user job.
2. Can the skill run as pure instruction/reference guidance?
   - Convert to instruction-only AMA skill.
3. Does it need deterministic local transformation or a preview?
   - Convert to WebKit `run_js` if it can run in browser JavaScript.
4. Does it need files, device state, connectors, permissions, external app opening, or app state mutation?
   - Implement the capability in Swift and expose it as a host intent; write a thin `run_intent` skill.
5. Does it need Python, Node, shell, Xcode, git, or arbitrary local filesystem access?
   - Do not ship it as an AMA skill package.

## What To Remove During Conversion

Remove:

- `agents/openai.yaml`
- desktop-specific prompt rules
- repository-analysis instructions
- CLI commands
- shell/Python/Node scripts
- references to Codex, Claude Code, XcodeBuildMCP, or terminal output
- local path assumptions

Keep only if mobile-relevant:

- short task instructions
- examples of user input and output
- reference documents that guide response behavior
- small static assets

## Rewrite Names

Desktop name:

```text
review-project-completion
```

AMA mobile name:

```text
summarize-project-note
```

Desktop name:

```text
execute-release-notes
```

AMA mobile name:

```text
draft-update-announcement
```

Desktop name:

```text
qa-change-scenarios
```

AMA mobile name:

```text
check-trip-plan
```

The AMA name must describe what the mobile user gets, not what an engineering agent does.

## Conversion Record Template

For each converted skill, write a short conversion note in the plugin README:

```text
Source idea:
Desktop assumptions removed:
AMA user job:
Runtime path: instruction-only | run_js | run_intent
Swift capability required: yes | no
Validation:
```

## Example

Original idea:

```text
Desktop skill summarizes a code review checklist.
```

AMA conversion:

```text
Mobile skill turns a pasted checklist or meeting note into a concise shareable summary.
```

Why:

- mobile user can paste text
- no repository access required
- output can be shared/exported through artifact intents
