# Converting Desktop Skills To AMA

Do not copy Codex or Claude desktop skills into AMA. Convert the user value, preserve useful reference material, and replace unsafe execution paths with an explicit iOS route.

## Conversion Decision Tree

1. Is the skill only about developer process, repository work, CI, code review, refactoring, or shell tooling?
   - Do not convert unless there is a mobile end-user job.
2. Can the skill run as pure instruction/reference guidance?
   - Convert to an instruction-only AMA skill.
3. Does it need a small deterministic transformation that can run inside WebKit JavaScript?
   - Convert to a WebKit `run_js` skill. Do not port Node, Python, shell, or desktop helpers.
4. Does it need files, device state, connectors, permissions, external app opening, app state mutation, or platform APIs?
   - Implement the capability in Swift and expose it as a host intent; write a thin `run_intent` skill.
5. Does it need Python, R, MATLAB, GPU, shell, Node, desktop browser automation, or arbitrary local filesystem access?
   - Install the skill only if its reference and routing value remains useful. Mark the execution route explicitly:
     - `remote-preflight` for approved remote/service execution.
     - `ios-native` for a narrow Swift replacement.
     - `deferred-desktop` for mobile-unavailable behavior.
     - `instruction-only` for documentation-only guidance.

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

When preserving a skill that originally had scripts or executable helper files, remove those files from the AMA plugin package. If the scripts are needed to understand the workflow, convert them to Markdown references or describe the required Swift/remote capability.

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
Runtime path: instruction-only | run_js | run_intent | remote-preflight | deferred-desktop
Swift capability required: yes | no
Remote provider required: yes | no
Validation:
```

## Required QA Gates

Before publishing a converted pack:

- `ama-skill-plugin.json` exists and lists the intended skills.
- `SKILL.md` exists for every listed skill.
- The repository root `ama-skill-repository.json` count matches actual skill directories when the pack is part of the public GitHub catalog.
- No plugin package ships `.py`, `.sh`, `.ps1`, `.bat`, `.js`, `.ts`, `.swift`, `.m`, `.r`, `.R`, executable helper files, or `scripts/` unless it is an approved WebKit JavaScript skill.
- No PDF binaries are shipped. Scientific document workflows use Markdown or text-like artifacts.
- Local install/load smoke passes.
- If published on GitHub, a live GitHub URL install/uninstall smoke passes for the root URL or the changed category tree URL.

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
