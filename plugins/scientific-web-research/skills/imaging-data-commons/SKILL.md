---
name: imaging-data-commons
description: Query and download public cancer imaging data from NCI Imaging Data Commons using idc-index. Use for accessing large-scale radiology (CT, MR, PET) and pathology datasets for AI training or research. No authentication required. Query by metadata, visualize in browser, check licenses.
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
  "service": "imaging-data-commons",
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

- `references/bigquery_guide.md`
- `references/cli_guide.md`
- `references/clinical_data_guide.md`
- `references/cloud_storage_guide.md`
- `references/dicomweb_guide.md`
- `references/digital_pathology_guide.md`
- `references/index_tables_guide.md`
- `references/parquet_access_guide.md`
- `references/sql_patterns.md`
- `references/use_cases.md`
