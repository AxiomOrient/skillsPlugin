# Scientific Compute Remote Skills

This directory contains 84 AMA mobile-safe scientific compute skills converted from the upstream scientific-agent-skills catalog.

Use these skills as planning and preflight layers for Python, MATLAB-like, GPU, notebook, Docker, simulation, model, and large-file workflows. They do not ship local executable scripts. Any actual non-iOS compute must pass through `scientific.remote_job_preflight`; bounded native replacements should route to Swift host intents such as `scientific.numeric_eval`, `scientific.chart_render_svg`, `scientific.chart_render_markdown`, or `scientific.document_to_markdown`.
