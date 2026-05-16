# Forms And Input Guidance

Use this reference when auditing sign-up, checkout, onboarding, settings, admin panels, data entry, filters, or any flow where users enter information.

## Core Rule

Forms are not layout decoration. They are a conversation with consequences. Optimize comprehension, error prevention, and recovery before compactness.

## Rules

1. Use a single primary column for forms unless grouped fields are semantically obvious and short.
2. Keep labels visible during and after entry. Do not rely only on placeholder text.
3. Ask only for information needed now. Defer optional/rare fields.
4. Put help text next to the field it explains.
5. Validate near the field, in plain language, with a fix.
6. Preserve entered data on errors.
7. Use sensible input types, keyboard types, masks, and auto-formatting without rejecting common formatting.
8. Make primary and cancel actions visually and spatially distinct.
9. For risky submissions, preview consequences or provide confirmation/undo.
10. For long forms, group into meaningful sections and show progress if it reduces uncertainty.

## Common Findings

- Multi-column layout creates ambiguous reading order.
- Placeholder-only labels disappear and increase recall load.
- Inline validation is late, vague, or shown far from the field.
- Required fields are not clear until after submission.
- Buttons say "Submit" instead of the user outcome.
- Errors erase user input.
- Form asks for business-friendly data before user value is clear.

## Validation

- Keyboard-only completion.
- Screen reader pass for labels, errors, and grouping.
- Mobile viewport pass.
- Test one happy path, one missing-field path, one invalid-format path, and one recovery path.

Sources: Baymard form research, NN/g error prevention/recovery and recognition over recall, WCAG input assistance criteria, platform HIG form controls.
