# UX/UI Audit Rubric

Use this rubric to evaluate a project, screen, or flow. Keep findings evidence-based and implementable.

## Severity

- `P0`: Blocks task completion, causes data loss, legal/accessibility failure, unsafe action, or severe trust break.
- `P1`: Common path friction, high cognitive load, hidden state, confusing navigation, weak error prevention, or poor mobile/assistive use.
- `P2`: Repeated annoyance, weak scanability, inconsistent component use, unclear copy, missing empty/loading/success states.
- `P3`: Polish, spacing, visual rhythm, icon quality, microcopy refinement.

## Audit Checklist

### Task And Information Architecture

- Does the first screen identify purpose, state, priority, and next action?
- Are navigation labels user-facing and stable?
- Are top tasks faster than rare tasks?
- Is the flow complete from start to end state?

### Visual Hierarchy And Scan

- Is there one obvious primary action per task context?
- Are sections grouped by real relationship?
- Are important differences visible without excessive color or badges?
- Are card/list/table densities appropriate for the product type?

### Interaction And Feedback

- Are clickable/tappable objects visibly interactive?
- Are loading, empty, blocked, error, success, and completed states implemented?
- Are risky actions reversible or confirmed?
- Is the user's last action acknowledged quickly?

### Accessibility And Inclusion

- Keyboard/focus order works.
- Screen reader labels and semantic structure are sufficient.
- Target sizes, spacing, contrast, dynamic type/zoom, and reduced motion are respected.
- Color, position, or sound are not the sole meaning channels.

### Forms And Inputs

- Labels remain visible.
- Fields follow a logical single-column order unless compact grouping is unambiguous.
- Validation is timely, local, and constructive.
- Required/optional rules are clear.
- Inputs accept common human formatting.

### Platform Fit

- Navigation, sheets/modals, tabs, toolbars, search, menus, and gestures match platform expectations.
- Responsive behavior is deliberate for compact, medium, and expanded widths.
- Platform accessibility features can complete critical tasks.

## Output Template

```markdown
Verdict: improve | hold | redesign needed
Top task: ...
Primary risk: ...

Rules used:
- ...

Findings:
1. [P1] Title
   Evidence: file/screen/line/screenshot
   Rule violated: ...
   Better change: ...
   Validation: ...

Conflicts resolved:
- Rejected ... because ...

Next proof:
- ...
```

## Minimum Evidence For Claims

- For code projects: inspect actual view/component files, routes, state handling, and previews/tests where available.
- For screenshots: inspect layout, hierarchy, copy, affordances, and missing states; say what cannot be verified.
- For design proposals: name assumptions and the smallest test needed.
- For regulated or accessibility-sensitive flows: require WCAG/platform accessibility verification before "done".
