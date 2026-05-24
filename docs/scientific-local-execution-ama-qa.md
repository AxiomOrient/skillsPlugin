# Scientific Local Execution AMA QA

Date: 2026-05-24

## Target

Verify that API-search, visual artifact, and MATLAB-like scientific skill paths can be used on iOS through AMA-native host intents without executing installed skill scripts.

## Scenario Matrix

| Surface | Scenario | Expected result | Evidence |
| --- | --- | --- | --- |
| API search | Scientific literature/data lookup skills route to Swift `URLSession` host intents | Host intents are registered and mobile-safe | Existing AMASample scenarios verify `scientific.paper_search`, `scientific.open_access_lookup`, `scientific.web_api_preflight`, and data lookup registration paths |
| MATLAB-like numeric | Matrix, FFT/DFT, moving average, interpolation, and first-order linear ODE work routes to `scientific.numeric_eval` | Swift kernels return deterministic structured results and report no MATLAB/Python interpreter | `AMASkillsHostTests.scientificLocalExecutionRunsNumericKernelsAndRendersChartArtifacts` and AMASample `ama-skills-host-scientific-local-execution` |
| Visual artifact | Simple line/scatter/bar chart routes to `scientific.chart_render_svg` or `scientific.chart_render_markdown` | Returns SVG/Markdown and persists `image/svg+xml` or `text/markdown` artifacts | Same focused AMA test and AMASample iOS service scenario |
| External script skill | Skill directory contains script/runtime files | Skill installs but is unavailable on mobile | Plugin scanner keeps script/executable-containing skills as `unavailableOnMobile` |
| Native replacement skill | Skill mentions MATLAB/Python but declares native replacement | Skill remains available only when `ama-mobile-native-execution: true` is present and no script files exist | `installSkillPluginAllowsNativeMobileReplacementForExternalRuntimeText` |

## Passed Proofs

- AMA package focused proof passed:
  - `swift test --filter 'scientificLocalExecution|installSkillPluginAllowsNativeMobileReplacementForExternalRuntimeText'`
  - `swift test --filter scientificLocalExecutionRunsNumericKernelsAndRendersChartArtifacts`
  - Result: matrix, FFT/DFT, moving average, linear interpolation, first-order linear ODE, SVG chart, Markdown chart document, and native mobile replacement assertions passed.
- AMASample local package proof passed:
  - `swift test --filter scientificLocalExecution`
  - `swift test --filter scientificLocalExecutionRunsNumericKernelsAndRendersChartArtifacts`
  - Result: AMASample's synced AMA package exposes the same expanded Swift numeric kernels and Markdown chart document renderer.
- AMASample iOS simulator proof passed:
  - `bash scripts/generate.sh`
  - `xcodebuild test -scheme AMASampleService -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' -only-testing AMASampleServiceTests -derivedDataPath /tmp/AMASampleScientificLocalExecutionDerivedData`
  - Result: `** TEST SUCCEEDED **`, 25 tests passed.
  - `xcodebuild test -scheme AMASampleService -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' -only-testing AMASampleServiceTests -derivedDataPath /tmp/AMASampleScientificNumericKernelsDerivedData`
  - Result: `** TEST SUCCEEDED **`, 25 tests passed. Result bundle: `/tmp/AMASampleScientificNumericKernelsDerivedData/Logs/Test/Test-AMASampleService-2026.05.24_14-59-43-+0900.xcresult`.
  - `xcodebuild test -scheme AMASampleService -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' -only-testing AMASampleServiceTests -derivedDataPath /tmp/AMASampleScientificMarkdownChartDerivedData`
  - Result: `** TEST SUCCEEDED **`, 25 tests passed. The local execution scenario verified SVG and Markdown chart artifacts. Result bundle: `/tmp/AMASampleScientificMarkdownChartDerivedData/Logs/Test/Test-AMASampleService-2026.05.24_15-55-50-+0900.xcresult`.
- Scientific plugin executable scan passed:
  - All current `plugins/scientific-*` skill packs scanned with zero `.py`, `.sh`, `.ps1`, `.bat`, `.js`, `.ts`, `.m`, `.r`, executable files, or script files.

## Remaining Gaps

- `scientific.chart_render_svg` and `scientific.chart_render_markdown` are intentionally constrained to simple SVG charts and Markdown chart documents. PNG and richer visual layouts still need native renderers.
- MATLAB-like execution now covers common vector/matrix/stat operations, linear regression, bounded real-input FFT/DFT, moving average smoothing, linear interpolation, and a first-order linear Euler ODE kernel. Richer signal processing, nonlinear ODE solvers, sparse/decomposition-heavy linear algebra, and selected MATLAB Coder bridges remain future host intents.
- API search has Swift `URLSession` host intent patterns already, but provider coverage is still incremental. Some web/API skills still preflight or require credentials/approval.

## Confidence

Release confidence for this local execution slice is high for the tested surfaces: Swift numeric matrix/stat/regression execution, bounded FFT/DFT, moving average, interpolation, first-order linear ODE execution, constrained SVG chart and Markdown chart document artifact generation, native replacement plugin availability, and AMASample iOS simulator integration. Confidence remains medium for the broader scientific skill catalog because many specialized libraries still require remote/preflight handling or future Swift/Coder host intents.
