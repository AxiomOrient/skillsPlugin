---
name: scientific-research-lookup
description: Route a mobile research question to AMA scholarly lookup intents and produce a source-grounded research answer without desktop search CLIs.
---
# scientific-research-lookup

Use this skill when the user asks for current scientific background, recent studies, source gathering, or evidence for a research claim.

## Native execution

Start with scholarly metadata lookup unless the user only asks for writing structure.

Collect:

- `query`: the research question
- optional `databases`: prefer `openalex`, `crossref`, and `pubmed`; add `arxiv` for math, CS, physics, statistics, and preprints
- optional `limit`: 3 to 10 per database
- optional year bounds

Call `run_intent`:

```json
{
  "intent": "scientific.paper_search",
  "parameters": {
    "query": "<research question>",
    "databases": ["openalex", "crossref", "pubmed"],
    "limit": 5
  }
}
```

## Synthesis rules

Use only returned paper evidence for claims about specific papers. Distinguish:

- confirmed paper metadata from the intent result
- interpretation or synthesis by the agent
- missing evidence or failed databases

Do not claim exhaustive coverage. If the source payload has failures or sparse results, say that the result is partial and name the missing source.

## Mobile boundary

This skill replaces the upstream desktop `parallel-cli`, OpenRouter script, and Python lookup behavior with AMA host intents. Do not run CLI search, Python scripts, shell commands, or desktop-only tools.
