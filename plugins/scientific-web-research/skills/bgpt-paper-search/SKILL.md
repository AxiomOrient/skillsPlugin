---
name: bgpt-paper-search
description: Search scientific papers and retrieve structured experimental data extracted from full-text studies via the BGPT MCP server. Returns 25+ fields per paper including methods, results, sample sizes, quality scores, and conclusions. Use for literature reviews, evidence synthesis, and finding experimental details not available in abstracts alone.
---

# AMA Mobile Web Research Skill

This skill is installed as part of `Scientific Web Research`. On AMA iOS, do not run local scripts, browser automation, package managers, or desktop tools.

## Required Mobile Flow

1. Identify the lookup service, query, identifier, or dataset requested by the user.
2. Read the reference files below when they help normalize the service-specific request.
3. Before contacting any external service, call `run_intent` with intent `scientific.web_api_preflight`.
4. If the preflight status is not `ready_public_lookup` or `ready_authenticated_lookup`, explain the blocker and stop before external lookup.
5. When ready, call `run_intent` with intent `scientific.web_api_search` for supported providers (`openalex`, `crossref`, `pubmed`, `semantic_scholar`, `exa`), or use another host-approved Swift network connector for this service. Do not execute source repository scripts.

Recommended parameters:

```json
{
  "service": "bgpt-paper-search",
  "query": "plain-language lookup query",
  "requiresAPIKey": false,
  "hasAPIKey": false,
  "userApprovedExternalLookup": false
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- External lookup requires explicit user approval.
- Authenticated services require credentials in AMA secret storage.

## Reference Files Installed

- No extra reference files in the upstream skill.
