# Swift Capability Guide

Some skills cannot be implemented as documents or WebKit scripts. In AMA, those behaviors belong in Swift.

## When To Implement Swift First

Use Swift host capabilities when a skill needs:

- device state: torch, brightness, haptics, volume, idle timer
- clipboard access
- artifact preview/share/export
- connector upload, such as Drive
- external URL opening
- app-owned persistence
- permission prompts
- side effects outside chat
- secure credential handling

## AMA Host Intent Pattern

Define a payload:

```swift
public struct MyIntentRequest: AMASkillHostIntentPayload {
    public static var toolSchema: JSONValue {
        ToolSchema.object(
            properties: [
                "value": ToolSchema.string(description: "Value to process.", minLength: 1)
            ],
            required: ["value"]
        )
    }

    public var value: String
}
```

Define a descriptor:

```swift
AMASkillHostIntentDescriptor.typed(
    name: "my.intent.name",
    description: "Do the native mobile action.",
    approvalPolicy: .requireApproval
) { (request: MyIntentRequest, context: ToolExecutionContext) in
    ToolResult.text(
        callID: "my.intent.name",
        toolName: "my.intent.name",
        content: "Done."
    )
}
```

Register it through an `AMASkillHostIntentSet` and route it through AMA's skill intent service.

## Skill Routing For Native Capability

The `SKILL.md` should not explain Swift internals. It should route clearly:

```markdown
When the user asks to perform the native action, collect `value`.
Call `run_intent` with:

{
  "intent": "my.intent.name",
  "parameters": {
    "value": "<value>"
  }
}

If the host asks for approval or permission, wait for the result and report only the actual result.
```

## Approval Rules

Read-only host state can be automatic only when the descriptor is registered that way. Side effects should require approval.

Examples that should require approval:

- open external URL
- share/export artifact
- upload to connector
- write clipboard
- change device state

## Artifact Rules

If Swift creates or consumes files, it should work through `ToolExecutionContext` and persisted artifacts. Do not ask the skill to write arbitrary filesystem paths.

## Secret Rules

If a secret is required, declare it in the skill frontmatter and let AMA's secret store handle it. Do not ask the user to paste secrets into ordinary chat unless the app's product flow explicitly supports that.
