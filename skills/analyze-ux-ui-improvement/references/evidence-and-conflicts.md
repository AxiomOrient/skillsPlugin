# Evidence And Conflict Resolution

## Evidence Hierarchy

Use the strongest available evidence for the decision:

1. Direct user research, production analytics, support tickets, accessibility test results, and task completion data for this product.
2. Standards and conformance requirements: WCAG/WAI, platform accessibility APIs, legal/regulated-domain constraints.
3. Platform and official system guidance: Apple HIG, Material, USWDS, GOV.UK, Fluent/Microsoft.
4. Mature heuristics and empirical UX research: NN/g heuristics, Baymard task-specific research, peer-reviewed HCI where relevant.
5. Laws of UX and cognitive principles as lenses for explaining likely effects.
6. Aesthetic trend, brand preference, stakeholder taste.

Do not let levels 5-6 override levels 1-3.

## Conflict Rules

### Familiarity vs Novelty

Better rule: default to the conventional pattern, then improve the weak point inside that pattern.

Reject novelty when it creates new vocabulary, hidden gestures, unusual placement, or nonstandard state behavior without evidence of better task completion.

### Minimalism vs Completeness

Better rule: remove irrelevant presentation, not necessary information. Put advanced or low-frequency detail behind progressive disclosure.

Do not hide labels, status, consequences, or recovery paths just to make the screen look clean.

### Speed vs Safety

Better rule: optimize speed for reversible, frequent, low-risk actions; optimize clarity and confirmation for irreversible, financial, legal, destructive, or public actions.

### Aesthetic Delight vs Accessibility

Better rule: keep the aesthetic only if it passes contrast, focus, motion, target-size, semantic-label, and reflow checks.

### Personalization vs Consistency

Better rule: give experts accelerators without removing the novice path. Customization should add efficiency, not change the meaning of core actions.

### Engagement vs User Agency

Better rule: motivate by clarifying progress, benefit, and next action. Avoid dark patterns, artificial urgency, manipulative defaults, and excessive gamification.

## Laws Of UX As Lenses

Use Laws of UX to diagnose, not to prescribe blindly:

- Hick's Law and Choice Overload: reduce simultaneous decisions.
- Fitts's Law: enlarge and place frequent/important targets well.
- Jakob's Law: follow external conventions.
- Miller's Law / Working Memory / Chunking: group information and avoid recall.
- Doherty Threshold: keep feedback fast; use skeletons/progress when work takes longer.
- Gestalt laws: proximity, common region, similarity, and connectedness should match semantic relationships.
- Von Restorff: reserve visual distinctiveness for the item that truly needs attention.
- Peak-End: repair the worst moment and design a strong finish.
- Zeigarnik: expose unresolved work without creating anxiety.
- Tesler's Law: move unavoidable complexity to the system when possible; when not possible, teach it progressively.

## Source Families Used

- Laws of UX: https://lawsofux.com/
- NN/g 10 Usability Heuristics: https://www.nngroup.com/articles/ten-usability-heuristics/
- WCAG / WAI: https://www.w3.org/TR/WCAG22/
- Apple Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/
- Material Design: https://m3.material.io/
- GOV.UK Design Principles: https://www.gov.uk/guidance/government-design-principles
- USWDS Accessibility: https://designsystem.digital.gov/documentation/accessibility/
- Microsoft Inclusive Design: https://inclusive.microsoft.design/
- Baymard form and checkout UX research: https://baymard.com/learn/form-design
