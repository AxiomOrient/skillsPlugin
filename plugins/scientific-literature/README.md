# Scientific Literature

AMA-native scientific literature skill pack converted from the K-Dense scientific agent skills catalog.

This pack is intentionally mobile-safe:

- no Python, shell, PowerShell, batch, Node, MATLAB, or desktop daemon files
- no local script execution
- public scholarly lookups run through AMA Swift host intents
- API-key or email values are passed only when the user supplies them for a specific call

## Skills

- `scientific-paper-lookup`: search or look up scholarly papers through OpenAlex, Crossref, PubMed, and arXiv.
- `scientific-research-lookup`: route research questions into mobile-safe scholarly lookup and synthesis.
- `scientific-citation-management`: generate BibTeX and check open-access metadata without citation scripts.
- `scientific-literature-review`: structure literature-review output from retrieved paper evidence.

## Native intents

- `scientific.paper_search`
- `scientific.paper_lookup`
- `scientific.doi_to_bibtex`
- `scientific.open_access_lookup`

This is the first reversible category from the scientific-agent-skills AMA plan. Remote Python/GPU/lab integrations belong in later packs.
