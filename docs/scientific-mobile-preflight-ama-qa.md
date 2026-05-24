# Scientific Mobile Preflight AMA QA

## Scope

This QA covers the last source-name coverage gap from `K-Dense-AI/scientific-agent-skills` after the literature, reference, data lookup, clinical compliance, documents, lab connector, and remote compute packs were already converted.

The covered AMA plugin packs are:

- `plugins/scientific-web-research`: 8 web/API research skills.
- `plugins/scientific-visual-artifacts`: 9 visual and presentation artifact skills.
- `plugins/scientific-reasoning-docs`: 6 document-only reasoning and writing skills.
- `plugins/scientific-deferred-desktop`: 2 desktop-only skills installed as unavailable on mobile.

Together these packs close the remaining 25 upstream source names:

- Web/API: `adaptyv`, `bgpt-paper-search`, `exa-search`, `imaging-data-commons`, `paper-lookup`, `paperzilla`, `primekg`, `research-lookup`.
- Visual/artifact: `citation-management`, `generate-image`, `infographics`, `latex-posters`, `pptx-posters`, `scientific-schematics`, `scientific-slides`, `scientific-visualization`, `venue-templates`.
- Reasoning/docs: `consciousness-council`, `hypothesis-generation`, `literature-review`, `market-research-reports`, `research-grants`, `scholar-evaluation`.
- Deferred desktop: `autoskill`, `matlab`.

## Mobile Runtime Decision

The iOS runtime cannot execute upstream Python, shell, PowerShell, batch, R, MATLAB, Node, or desktop app commands. The converted packs therefore keep the skill instructions and non-script references, but route executable behavior through explicit AMA host intents:

- `scientific.web_api_preflight` gates API/web research work by credentials, source approval, and public lookup availability.
- `scientific.web_api_search` performs approved Swift `URLSession` searches for supported providers (`openalex`, `crossref`, `pubmed`, `semantic_scholar`, `exa`) without skill scripts.
- `scientific.artifact_workflow_preflight` gates visual/artifact work by sensitive-data review, renderer availability, and user approval.
- `scientific.deferred_desktop_preflight` marks desktop-only skills as blocked instead of pretending they can run on iOS.

Every mobile preflight output includes `local_scripts_executed=false`.

## Reference Parity

Non-script references were copied into AMA plugin packages so the installed mobile skill is not only a `SKILL.md` shell.

| Pack | Skills | References copied | Scripts/executables excluded |
| --- | ---: | ---: | ---: |
| `scientific-web-research` | 8 | 24 | 10 |
| `scientific-visual-artifacts` | 9 | 66 | 34 |
| `scientific-reasoning-docs` | 6 | 28 | 13 |
| `scientific-deferred-desktop` | 2 | 12 | 23 |
| Total | 25 | 130 | 80 |

The excluded files are not installed as executable mobile assets. Documentation references may still contain inert code examples when they are part of the original instruction material.

## Source Coverage Audit

The upstream repository was freshly cloned for final audit:

```text
https://github.com/K-Dense-AI/scientific-agent-skills
commit 66d1ad4
```

Coverage result:

```text
source_count=139
plugin_unique_count=142
missing_count=1
missing: pdf
extra_count=4
extra: scientific-citation-management
extra: scientific-literature-review
extra: scientific-paper-lookup
extra: scientific-research-lookup
```

The 4 extras are AMA-native aliases from the first literature pack. The original upstream names are also present in later category packs. The single missing source name is `pdf`, which is intentionally removed from the AMA mobile plugin set and replaced by the Markdown-first `scientific-documents` flow documented in `scientific-agent-skills-coverage-audit.md`. The upstream count increased from 137 to 139 after `bids` and `pacsomatic` landed; those two are covered by the remote compute pack and its QA document.

Scientific plugin static checks:

- 11 `plugins/scientific-*/ama-skill-plugin.json` files parsed successfully as JSON.
- 142 manifest entries point to existing `SKILL.md` files.
- `find plugins/scientific-*` for `*.py`, `*.sh`, `*.ps1`, `*.bat`, `*.js`, `*.ts`, `*.m`, `*.r`, and executable files returned no installed executable files.

## Scenario Matrix

| Scenario | Surface | Expected result | Evidence |
| --- | --- | --- | --- |
| Install/read all final packs | AMA plugin manifest and skill scanner | 4 plugins and 25 skills are visible | `/tmp/ama-scientific-remainder-live`: `remainder_plugin_count=4`, `remainder_skill_count=25` |
| Web/API skill with credentials risk | `scientific.web_api_preflight` | Skill remains installable, execution is gated | `exa_loaded_ok=true`, `exa_support=available`, `web_status=needs_credentials` |
| Web/API native execution | `scientific.web_api_search` | External lookup requires user approval; OpenAlex, Crossref, PubMed, and Semantic Scholar return normalized Swift results; Exa missing key is blocked before network | AMA and AMASample tests verify `needs_external_lookup_approval`, OpenAlex result `CRISPR mobile review`, Crossref DOI `10.5555/ama.crossref`, PubMed PMID `41000001`, Semantic Scholar paper ID `S2MOBILE001`, Exa `needs_credentials`, and no local scripts |
| Visual artifact skill with renderer dependency | `scientific.artifact_workflow_preflight`; simple charts use `scientific.chart_render_svg`/`scientific.chart_render_markdown` | Skill remains installable; simple SVG chart and Markdown chart document artifacts can render locally, while unsupported renderers are gated | `slides_loaded_ok=true`, `slides_support=available`, `artifact_status=needs_remote_renderer`; local execution QA verifies SVG and Markdown chart artifacts |
| Reasoning-only document skill | Mobile document-only skill | Skill is available with the same installed instructions and references as the local plugin source | `reasoning_loaded_ok=true`, `reasoning_support=available`, `reasoning_markdown_parity=true`, `reasoning_reference_parity=true`, `reasoning_runtime_uses_installed_content=true` |
| Desktop-only skill | `scientific.deferred_desktop_preflight` | Skill is installed but unavailable on mobile | `matlab_loaded_ok=true`, `matlab_support=unavailableOnMobile`, `deferred_status=blocked_desktop_only` |
| iOS host integration | `AMASkillsHost` in AMA SwiftPM | New preflight and native web/API search intents compile and route statuses | `swift test --filter scientificMobilePreflightRoutesWebArtifactAndDeferredSkills` passed 1 test in `/Users/axient/repoAgent/AMA` |
| AMASample iOS use | `AMASampleService` on iPad simulator | App service exposes verification scenario and all existing scenarios still pass | `xcodebuild test ... -only-testing AMASampleServiceTests` passed 25 tests |

## Commands Run

```sh
cd /Users/axient/repoAgent/AMA
swift test --filter scientificMobilePreflightRoutesWebArtifactAndDeferredSkills
```

Result: passed 1 test. This covers approval gating, OpenAlex search, Crossref search, PubMed ESearch/ESummary search, Semantic Scholar paper search, Exa credential gating, artifact preflight, desktop-only blocking, and `local_scripts_executed=false`.

```sh
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificMobilePreflightRoutesWebArtifactAndDeferredSkills
```

Result: passed 1 test after syncing the AMA local package into AMASample.

```sh
cd /tmp/ama-scientific-remainder-live
swift run AMAScientificRemainderLive
```

Result:

```text
remainder_plugin_count=4
remainder_skill_count=25
exa_loaded_ok=true
slides_loaded_ok=true
reasoning_loaded_ok=true
matlab_loaded_ok=true
exa_support=available
slides_support=available
reasoning_support=available
matlab_support=unavailableOnMobile
web_status=needs_credentials
artifact_status=needs_remote_renderer
deferred_status=blocked_desktop_only
reasoning_markdown_parity=true
reasoning_source_reference_count=1
reasoning_installed_reference_count=1
reasoning_reference_parity=true
reasoning_runtime_uses_installed_content=true
```

```sh
xcodebuild test -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificSemanticScholarDerivedData
```

Result: 25 tests passed, `TEST SUCCEEDED`. The `ama-skills-host-scientific-mobile-preflight` scenario detail includes `OpenAlex Swift search`, `Crossref Swift search`, `PubMed Swift search`, `Semantic Scholar Swift search`, `Exa credentials gate`, `artifact renderer gate`, `desktop block`, and `no local scripts`.

XCResult:

```text
/tmp/AMASampleScientificSemanticScholarDerivedData/Logs/Test/Test-AMASampleService-2026.05.24_15-28-25-+0900.xcresult
```

```sh
xcodebuild test -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificMarkdownChartDerivedData
```

Result: 25 tests passed, `TEST SUCCEEDED`. The `ama-skills-host-scientific-local-execution` scenario detail includes `Markdown chart artifact` in addition to Swift matrix execution, SVG chart artifact creation, and no local scripts.

XCResult:

```text
/tmp/AMASampleScientificMarkdownChartDerivedData/Logs/Test/Test-AMASampleService-2026.05.24_15-55-50-+0900.xcresult
```

## Desktop vs Mobile Quality

- Web/API skills are now desktop-equivalent for the supported provider slice: OpenAlex, Crossref, PubMed, Semantic Scholar, and Exa route through Swift `URLSession`, preserve instructions/references, enforce approval and credentials gating, and return normalized records. Other providers remain preflight/routing until their Swift connector is added.
- Visual/artifact skills are desktop-equivalent only for the constrained simple SVG chart slice and text-first Markdown chart document slice. They are not desktop-equivalent for local LaTeX, Python image generation, PowerPoint, binary document rendering, or external renderer execution; those remain product-usable on iOS as artifact planning and approval skills with renderer dependency made explicit.
- Reasoning/document skills are mobile-equivalent for instruction quality because their core value is prompt structure plus reference material, and no executable runtime is required.
- Deferred desktop skills are intentionally not mobile-equivalent. They are installable for catalog completeness but marked unavailable on mobile so users see the limitation instead of receiving a broken execution path.

## Verdict

Release confidence for this scope is **medium-high** for the implemented provider slice and **medium** for the broader scientific web/artifact catalog.

The core iOS invariant holds: all remaining source-name skills are installable as category plugins, non-script references are present, scripts are excluded from mobile packages, OpenAlex/Crossref/PubMed/Semantic Scholar/Exa have native Swift search handling, simple SVG chart and Markdown chart document generation is native, and impossible desktop execution is surfaced as gated or unavailable state. Confidence is not fully high for the whole catalog because richer renderer-backed artifact skills and many specialized web/API providers still need additional native connectors.
