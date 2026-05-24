# Scientific Literature AMA QA

Date: 2026-05-16

## Scope

This document records the first production-quality AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-literature`

Converted skills:

- `scientific-paper-lookup`
- `scientific-research-lookup`
- `scientific-citation-management`
- `scientific-literature-review`

The conversion target is iOS AMA, not desktop Codex. The skills contain only mobile-safe instructions and call Swift host intents through AMA `run_intent`.

## Mobile Capability

AMA now owns the executable behavior in Swift host intents:

- `scientific.paper_search`
- `scientific.paper_lookup`
- `scientific.open_access_lookup`
- `scientific.doi_to_bibtex`

The host intents use URLSession and structured JSON normalization. No plugin skill runs Python, shell, PowerShell, batch, Node, local scripts, or desktop-only tools.

Supported sources in this slice:

- Crossref
- OpenAlex
- PubMed
- arXiv
- Unpaywall, only when the user supplies an email

## iOS Product Tests

AMA package focused tests:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter scientificLiterature
```

Result:

- Passed.
- Covered normalized mobile-safe results from fake Crossref, OpenAlex, PubMed, arXiv, BibTeX, and Unpaywall email gating.
- Covered real plugin load and native intent call flow with `load_skill -> run_intent`.

AMASample local package focused tests:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificLiterature
```

Result:

- Passed after syncing local AMA package into AMASample.

AMASample iOS simulator tests:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificDerivedData2
```

Result:

- Passed 23 tests.
- Verified AMASample exposes the scientific literature scenario and registers `scientific.paper_search` in the skill host surface.
- Verified the no-email Unpaywall path returns a controlled `needs_email` result instead of attempting unsafe background behavior.

Note: an earlier `tuist test AMASampleService --no-selective-testing --test-targets AMASampleServiceTests` run was blocked by an Xcode DerivedData `build.db` lock. The same target passed through `xcodebuild` with a clean derived data path.

## Real Use Test

A temporary live Swift package at `/tmp/ama-live-scientific` invoked the same AMA Swift host intents used by mobile:

- `scientific.paper_search` for `Attention Is All You Need`
- `scientific.doi_to_bibtex` for DOI `10.1038/nature12373`

Observed mobile result:

```text
mobile_status=ok
mobile_databases=['crossref', 'openalex']
mobile_result_count=2
crossref: Is Attention All You Need? / 10.1007/978-3-031-84300-6_13 / 2025
openalex: Attention Is All You Need / 10.65215/2q58a426 / 2025
bib_status=ok
bib_first_line=@article{Kucsko2013Nanometre,
bib_has_doi=true
```

This proves the plugin path reaches live scholarly APIs through AMA-native Swift code without local scripts.

## Desktop Comparison

Desktop reference calls used direct REST requests against the same services:

- Crossref `/works?query=Attention%20Is%20All%20You%20Need&rows=1`
- OpenAlex `/works?search=Attention%20Is%20All%20You%20Need&per-page=1`
- Crossref `/works/10.1038/nature12373`

Observed desktop reference result:

```text
desktop_crossref_title=Is Attention All You Need?
desktop_crossref_doi=10.1007/978-3-031-84300-6_13
desktop_openalex_title=Attention Is All You Need
desktop_openalex_doi=https://doi.org/10.65215/2q58a426
desktop_doi_title=Nanometre-scale thermometry in a living cell
desktop_doi_year=2013
```

Quality judgment:

- Equivalent for the tested metadata and citation path. The mobile host returned the same top Crossref and OpenAlex records as the desktop REST baseline.
- Better suited for iOS because the mobile result is normalized, explicit about source failures, and marks `local_scripts_executed=false`.
- Not yet equivalent to a full desktop scientific backend for bulk retrieval, local dataset processing, notebook execution, or script-based artifact generation. Those must become Swift host intents, app extensions, remote connectors, or unavailable capabilities in later plugin categories.

## Remaining Work

This slice does not complete the full `scientific-agent-skills` repository. Remaining categories should be converted as separate plugin packs with the same standard:

- literature and citation expansion beyond the first four skills
- data analysis and statistics
- bioinformatics and domain-specific scientific tools
- artifact generation and export
- remote compute or connector-backed workflows

Each future pack must include:

- category-level `ama-skill-plugin.json`
- mobile-only `SKILL.md` files
- executable behavior in AMA Swift host intents when needed
- install/load/run tests
- AMASample iOS scenario coverage
- live use comparison against an appropriate desktop or API baseline
