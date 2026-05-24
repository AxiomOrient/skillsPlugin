---
name: matlab
description: MATLAB and GNU Octave numerical computing guidance for matrix operations, data analysis, visualization, and scientific computing on AMA iOS. Use native Swift host intents for supported numeric and chart operations, and explain when arbitrary MATLAB/Octave scripts still require desktop or build-time conversion.
ama-mobile-native-execution: true
---

# AMA Mobile MATLAB-Compatible Skill

This skill is installed as part of `Scientific Deferred Desktop`, but it now has a mobile-native replacement path for common numeric and plotting requests. AMA iOS must not execute arbitrary `.m` files, GNU Octave sessions, shell commands, package managers, or downloaded scripts.

## Required Mobile Flow

1. Classify the request:
   - Vector/matrix summaries, dot products, transpose, matrix multiplication, linear regression, real-input FFT/DFT spectrum, moving average smoothing, linear interpolation, or first-order linear ODE Euler integration: use `scientific.numeric_eval`.
   - Simple local line, scatter, or bar visualization: use `scientific.chart_render_svg`.
   - Arbitrary `.m` script execution, toolbox functions, Simulink, App Designer, symbolic math, file I/O workflows, or unsupported numerical routines: call `scientific.deferred_desktop_preflight`.
2. When using a native host intent, tell the user this is a Swift iOS kernel, not a MATLAB or Octave interpreter.
3. If the user needs their own MATLAB algorithm to run offline on iOS, recommend a build-time conversion path: MATLAB Coder compatibility check → generated C/C++ → signed Swift package or XCFramework → AMA host intent.
4. Do not present native-kernel results as full MATLAB compatibility.

Recommended local numeric parameters:

```json
{
  "operation": "matrix_multiply",
  "matrixA": [[1, 2], [3, 4]],
  "matrixB": [[5, 6], [7, 8]]
}
```

Recommended signal/ODE parameters:

```json
{
  "operation": "fft_real",
  "values": [1, 0, -1, 0]
}
```

```json
{
  "operation": "linear_interpolate",
  "x": [0, 10],
  "y": [0, 100],
  "targetX": [2.5, 7.5]
}
```

```json
{
  "operation": "ode_euler_linear",
  "coefficient": 1,
  "constant": 0,
  "initialValue": 1,
  "start": 0,
  "end": 0.2,
  "step": 0.1
}
```

Recommended chart parameters:

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
- iOS native numeric execution available: `true` for supported `scientific.numeric_eval` operations, including the bounded FFT/interpolation/ODE subset.
- iOS native chart artifact execution available: `true` for supported `scientific.chart_render_svg` operations.
- General MATLAB/Octave interpreter execution available: `false`.

## Reference Files Installed

- `references/data-import-export.md`
- `references/executing-scripts.md`
- `references/graphics-visualization.md`
- `references/mathematics.md`
- `references/matrices-arrays.md`
- `references/octave-compatibility.md`
- `references/programming.md`
- `references/python-integration.md`
