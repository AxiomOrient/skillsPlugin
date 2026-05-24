---
name: scientific-visualization
description: Meta-skill for publication-ready figures. Use when creating journal submission figures requiring multi-panel layouts, significance annotations, error bars, colorblind-safe palettes, and specific journal formatting (Nature, Science, Cell). Orchestrates matplotlib/seaborn/plotly with publication styles. For quick exploration use seaborn or plotly directly.
ama-mobile-native-execution: true
---

# AMA Mobile Scientific Artifact Skill

This skill is installed as part of `Scientific Visual Artifacts`. On AMA iOS, do not run local Python, shell, LaTeX, Office automation, plotting scripts, or desktop renderers.

## Required Mobile Flow

1. Clarify the artifact kind, source data, target audience, and requested output.
2. Read the reference files below for structure, quality criteria, and formatting guidance.
3. For simple line, scatter, or bar charts, call `run_intent` with intent `scientific.chart_render_svg` or `scientific.chart_render_markdown` and produce a constrained chart spec instead of asking for Python/matplotlib.
4. For unsupported figure types, multi-panel publication layouts, statistical annotations, LaTeX labels, or journal-specific renderer output, call `run_intent` with intent `scientific.artifact_workflow_preflight`.
5. Treat `needs_remote_renderer`, `needs_sensitive_data_review`, or `needs_artifact_creation_approval` as blockers for unsupported local iOS execution.
6. Only proceed with native AMA artifact tooling when the host provides a Swift renderer/editor or an approved remote renderer.

Recommended parameters:

```json
{
  "title": "Experiment signal",
  "kind": "line",
  "xLabel": "Time",
  "yLabel": "Signal",
  "series": [
    {
      "name": "sample A",
      "points": [
        {"x": 0, "y": 1},
        {"x": 1, "y": 2}
      ]
    }
  ]
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- Simple SVG/Markdown chart artifact generation uses the Swift `scientific.chart_render_svg` and `scientific.chart_render_markdown` host intents.
- Artifact creation or mutation requires explicit approval.
- Remote rendering and sensitive input handling require separate product support.

## Reference Files Installed

- `assets/nature.mplstyle`
- `assets/presentation.mplstyle`
- `assets/publication.mplstyle`
- `references/color_palettes.md`
- `references/journal_requirements.md`
- `references/matplotlib_examples.md`
- `references/publication_guidelines.md`
