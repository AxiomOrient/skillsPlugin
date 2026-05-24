---
name: exa-search
description: Web toolkit powered by Exa, tuned for scientific and technical content. Use this skill for web search and URL extraction through approved Swift web API intents. On AMA iOS, prefer pages, abstracts, metadata, and Markdown-compatible content; do not extract binary document content locally.
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
  "service": "exa-search",
  "query": "plain-language lookup query",
  "requiresAPIKey": true,
  "hasAPIKey": false,
  "userApprovedExternalLookup": false
}
```

## iOS Runtime Rules

- Local scripts executed: `false`.
- External lookup requires explicit user approval.
- Authenticated services require credentials in AMA secret storage.

## Reference Files Installed

- `references/web-extract.md`
- `references/web-search.md`
