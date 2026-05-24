---
name: timesfm-forecasting
description: Zero-shot time series forecasting with Google's TimesFM foundation model. Use for any univariate time series (sales, sensors, energy, vitals, weather) without training a custom model. Supports CSV/DataFrame/array inputs with point forecasts and prediction intervals. Includes a preflight system checker script to verify RAM/GPU before first use.
---

# AMA Mobile Remote Compute Skill

This skill is installed as part of `scientific-compute-remote`. The upstream desktop skill depends on Python, scientific packages, GPU/simulation/model runtimes, large local files, or other non-iOS execution. On AMA iOS, do not run local scripts, package managers, notebooks, shell commands, or desktop tools.

## Required Mobile Flow

1. Read the request and identify the intended scientific compute task.
2. Use the reference files below when they help explain inputs, outputs, terminology, or expected artifacts.
3. Before promising execution, call `run_intent` with intent `scientific.remote_job_preflight`.
4. Treat any blocked status as final for local iOS execution. Explain the blocker and the next required setup step.
5. Only describe a remote job as ready when the preflight status is `ready_for_remote_job`.

Recommended `run_intent` parameters:

```json
{
  "skill": "timesfm-forecasting",
  "task": "plain-language user task",
  "requiresRemoteExecution": true,
  "hasRemoteProvider": false,
  "inputArtifactCount": 0,
  "containsSensitiveData": false,
  "userApprovedUpload": false
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- Local Python, shell, MATLAB, Docker, GPU, notebook, or package-manager execution: unavailable on iOS.
- Artifact upload requires explicit user approval.
- PHI, secrets, controlled datasets, and private research data require a data review before remote execution.

## Reference Files Installed

- `examples/anomaly-detection/output/anomaly_detection.json`
- `examples/anomaly-detection/output/anomaly_detection.png`
- `examples/covariates-forecasting/output/covariates_data.png`
- `examples/covariates-forecasting/output/covariates_metadata.json`
- `examples/covariates-forecasting/output/sales_with_covariates.csv`
- `examples/global-temperature/README.md`
- `examples/global-temperature/output/animation_data.json`
- `examples/global-temperature/output/forecast_animation.gif`
- `examples/global-temperature/output/forecast_output.csv`
- `examples/global-temperature/output/forecast_output.json`
- `examples/global-temperature/output/forecast_visualization.png`
- `examples/global-temperature/output/interactive_forecast.html`
- `examples/global-temperature/temperature_anomaly.csv`
- `references/api_reference.md`
- `references/data_preparation.md`
- `references/system_requirements.md`
