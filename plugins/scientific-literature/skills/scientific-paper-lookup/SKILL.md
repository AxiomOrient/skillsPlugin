---
name: scientific-paper-lookup
description: Search or look up scholarly papers on iOS through AMA native literature intents for OpenAlex, Crossref, PubMed, and arXiv metadata.
---
# scientific-paper-lookup

Use this skill when the user asks to find papers, search scholarly literature, look up a DOI/PMID/arXiv id, compare paper metadata, or collect source evidence for a scientific answer.

## Native execution

For topic search, collect:

- `query`: paper topic or bibliographic query
- optional `databases`: any of `openalex`, `crossref`, `pubmed`, `arxiv`
- optional `limit`: 1 to 20 per database
- optional `fromYear` and `toYear`
- optional `email`: only when the user explicitly supplies it for polite API pools

Call `run_intent`:

```json
{
  "intent": "scientific.paper_search",
  "parameters": {
    "query": "<topic or bibliographic query>",
    "databases": ["openalex", "crossref"],
    "limit": 5
  }
}
```

For identifier lookup, collect:

- `identifier`: DOI, PMID, or arXiv id
- optional `identifierType`: `doi`, `pmid`, or `arxiv`
- optional `email`

Call `run_intent`:

```json
{
  "intent": "scientific.paper_lookup",
  "parameters": {
    "identifier": "<DOI, PMID, or arXiv id>",
    "identifierType": "doi"
  }
}
```

## Output handling

Return the native payload under `paper_search` or `paper_lookup`. Preserve:

- normalized paper records
- databases queried and endpoints used
- failures as partial evidence, not silent omissions
- the `mobile_runtime.local_scripts_executed` proof

Do not call shell, Python, `curl`, browser automation, desktop search tools, or external package managers from this skill.
