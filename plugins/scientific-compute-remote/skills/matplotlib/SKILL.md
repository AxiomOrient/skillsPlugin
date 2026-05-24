---
name: matplotlib
description: Low-level plotting guidance for full customization. On AMA iOS, simple line, scatter, and bar charts should use Swift SVG or Markdown chart intents; arbitrary matplotlib rendering and publication export require remote preflight.
ama-mobile-native-execution: true
---

# AMA Mobile Matplotlib-Compatible Skill

This skill is installed as part of `scientific-compute-remote`. On AMA iOS, do not run Python, matplotlib, notebooks, package managers, shell commands, or desktop tools. For simple charts, convert the request into the native Swift `scientific.chart_render_svg` host intent. Use remote compute preflight only when the requested plot needs unsupported matplotlib behavior.

## Required Mobile Flow

1. Read the request and identify the intended scientific compute task.
2. Use the reference files below when they help explain inputs, outputs, terminology, or expected artifacts.
3. If the request is a simple line, scatter, or bar chart, call `run_intent` with intent `scientific.chart_render_svg`.
4. If the request needs arbitrary matplotlib APIs, custom projections, complex subplot layout, statistical plotting libraries, file-driven Python code, or publication renderer parity, call `run_intent` with intent `scientific.remote_job_preflight`.
5. Treat any blocked remote status as final for nonlocal execution. Explain the blocker and the next required setup step.
6. Only describe a remote job as ready when the preflight status is `ready_for_remote_job`.

Recommended local chart parameters:

```json
{
  "title": "Dose response",
  "kind": "scatter",
  "xLabel": "Dose",
  "yLabel": "Response",
  "series": [
    {
      "name": "trial",
      "points": [
        {"x": 1, "y": 0.2},
        {"x": 2, "y": 0.4}
      ]
    }
  ]
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- Local Swift SVG rendering available: `true` for supported chart specs.
- Local Python, shell, MATLAB, Docker, GPU, notebook, or package-manager execution: unavailable on iOS.
- Artifact upload requires explicit user approval.
- PHI, secrets, controlled datasets, and private research data require a data review before remote execution.

## Reference Files Installed

- `references/api_reference.md`
- `references/common_issues.md`
- `references/plot_types.md`
- `references/styling_guide.md`
