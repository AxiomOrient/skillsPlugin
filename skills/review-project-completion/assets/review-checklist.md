# Review Checklist

Use this as the fast pass before writing the final report.

## Boundary and Inputs

- confirm the project or subsystem boundary
- identify the truth-defining artifacts
- list missing artifacts before scoring

## Required Review Passes

- check goal clarity and scope closure
- check document-to-code consistency
- check architectural boundaries and responsibility split
- check each core feature for requirement, implementation, test, and failure handling
- check error policy, validation, recovery, and observability
- check unit, integration, E2E, regression, failure-case, and boundary-value coverage
- check install, configuration, secrets, execution modes, deployment, rollback, and incident docs
- check unresolved blockers and operational risks

## Before Final Verdict

- verify that the core user flows are closed end to end
- verify that every major claim has evidence
- separate blockers from non-blocking issues
- separate missing implementation from missing verification
- separate document gaps from code gaps
- use `근거 부족` where evidence is genuinely missing

## Report Requirements

- preserve the eight required output sections
- keep the verdict to one of the four allowed labels
- score all seven dimensions from 0 to 5
- include the requirement traceability matrix
- include only real blockers in the blocker section
