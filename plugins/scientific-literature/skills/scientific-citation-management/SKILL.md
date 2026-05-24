---
name: scientific-citation-management
description: Generate BibTeX from DOI metadata and check open-access status on iOS through AMA native intents instead of citation scripts.
---
# scientific-citation-management

Use this skill when the user asks for BibTeX, DOI-to-citation conversion, open-access status, or a citation-ready paper record.

## DOI to BibTeX

Collect:

- `doi`: required
- optional `email`: user-supplied Crossref polite-pool email

Call `run_intent`:

```json
{
  "intent": "scientific.doi_to_bibtex",
  "parameters": {
    "doi": "<doi>",
    "style": "bibtex"
  }
}
```

Return `doi_to_bibtex.bibtex` and cite the Crossref source metadata that produced it.

## Open access lookup

Collect:

- `doi`: required
- optional `email`: required by Unpaywall if the user wants a live OA lookup

Call `run_intent`:

```json
{
  "intent": "scientific.open_access_lookup",
  "parameters": {
    "doi": "<doi>",
    "email": "<user supplied email>"
  }
}
```

If no email is supplied, return the native `needs_email` result. Do not invent, store, or reuse an email address.

## Mobile boundary

Do not run Zotero, Python BibTeX scripts, shell commands, or filesystem citation managers from this skill. AMA native intents own all deterministic citation operations in this pack.
