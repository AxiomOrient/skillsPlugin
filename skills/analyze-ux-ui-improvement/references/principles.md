# UX/UI Improvement Principles

Use these as working rules. Convert them into target-specific checks before judging a UI.

## 1. Start With The User's Job

Sources: GOV.UK Design Principles, NN/g heuristics, Laws of UX mental model.

Rule: the screen must make the user's next valuable action obvious. If a UI element does not help the top task, reduce, move, or remove it.

Checks:
- The first viewport answers: where am I, what matters now, what can I do next?
- Labels use user/domain language, not implementation names.
- Primary action count is intentionally small; secondary actions are discoverable but quieter.

## 2. Preserve Orientation And Feedback

Sources: NN/g visibility of system status, Zeigarnik Effect, Goal-Gradient Effect, Peak-End Rule.

Rule: users should always know current state, progress, pending work, and the result of their last action.

Checks:
- Loading, empty, error, success, blocked, and completed states are explicit.
- Multi-step or long-running work exposes progress and the next step.
- End states are useful: confirmation, receipt, rollback, next action, or review.

## 3. Reduce Recall, Not Meaningful Complexity

Sources: Recognition rather than recall, Cognitive Load, Working Memory, Chunking, Tesler's Law.

Rule: do not force users to remember hidden rules, previous values, or off-screen context. Reduce presentation complexity first; preserve necessary domain complexity with progressive disclosure.

Checks:
- Critical inputs retain visible labels.
- Repeated choices use menus, suggestions, or recent values.
- Dense dashboards group by task/area/status, not by arbitrary visual symmetry.
- Details are one click/tap away, not mixed into every card.

## 4. Use Familiar Patterns Unless Evidence Says Otherwise

Sources: Jakob's Law, platform HIG, Material/USWDS/GOV.UK design systems.

Rule: platform and industry conventions are the default. Break them only for a measured task improvement with no accessibility regression.

Checks:
- Navigation pattern matches platform expectations.
- Icon-only controls are familiar or have accessible labels/tooltips.
- Forms, filters, search, tabs, lists, modals, and destructive actions behave conventionally.

## 5. Make Interaction Targets And Layout Operable

Sources: Fitts's Law, WCAG, Apple/Material platform guidance, USWDS accessibility.

Rule: targets must be reachable, distinguishable, and operable across mouse, touch, keyboard, screen readers, zoom, dynamic type, and reduced motion.

Checks:
- Touch/click targets are large enough and spaced.
- Keyboard/focus order is logical.
- Color is not the only carrier of meaning.
- Content reflows instead of requiring horizontal reading.
- Motion is purposeful and can be reduced.

## 6. Prevent Errors Before Explaining Them

Sources: NN/g error prevention and recovery, Postel's Law, Baymard form research.

Rule: constrain invalid states, offer safe defaults, keep users in control, and write recovery instructions in plain language.

Checks:
- Risky actions have preview, confirmation, undo, or rollback.
- Validation appears near the problem and names how to fix it.
- Destructive actions are separated from primary completion actions.
- Inputs accept common formatting but store normalized values.

## 7. Optimize For Scan And Repeated Use

Sources: Serial Position Effect, Von Restorff Effect, Pareto Principle, selective attention.

Rule: the interface should make important differences easy to scan without turning every element into a highlight.

Checks:
- Visual emphasis is scarce and reserved for priority, risk, or next action.
- Similar objects look similar; meaningful exceptions are visually distinct.
- Repeated workflows support shortcuts, defaults, recents, and bulk action only after the baseline path is clear.

## 8. Aesthetic Quality Supports Trust, But Never Replaces Usability

Sources: Aesthetic-Usability Effect, Occam's Razor, NN/g minimalist design.

Rule: visual polish can increase perceived trust, but only when hierarchy, legibility, and task flow are already sound.

Checks:
- Decorative surfaces do not compete with primary content.
- Spacing, typography, and color encode hierarchy consistently.
- Empty visual effects, gratuitous motion, and one-note palettes are rejected unless they serve comprehension.

## 9. Design For Inclusion From The Edges

Sources: WCAG, USWDS, Microsoft Inclusive Design, GOV.UK.

Rule: learn from excluded users and stressful contexts. A design that works under constraints often improves the mainstream path too.

Checks:
- The flow works with screen reader, keyboard, zoom, large text, high/low contrast, and reduced motion.
- Plain language replaces clever microcopy in critical tasks.
- The UI remains useful for novices, experts, distracted users, and users recovering from mistakes.
