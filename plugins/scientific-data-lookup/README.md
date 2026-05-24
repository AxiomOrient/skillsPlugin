# Scientific Data Lookup

AMA-native scientific data lookup skill pack converted from the K-Dense scientific agent skills catalog.

This pack is mobile-safe:

- no Python, shell, PowerShell, batch, Node, MATLAB, or desktop daemon files
- no local script execution
- public REST lookups run through AMA Swift host intents
- broad database catalogs are included as documentation-only references

## Skills

- `database-lookup`: route a scientific data question to the right public database or API reference.
- `hugging-science`: search Hugging Face scientific datasets through `scientific.huggingface_dataset_search`.
- `usfiscaldata`: retrieve and explain U.S. Treasury Fiscal Data through `scientific.fiscaldata_latest_debt`.
- `depmap`: discover DepMap public release files through `scientific.depmap_release_files` and plan downstream analysis; no local Python matrix processing.

## Native Intents

- `scientific.huggingface_dataset_search`
- `scientific.fiscaldata_latest_debt`
- `scientific.depmap_release_files`
- `scientific.pubchem_compound_lookup`
- `scientific.uniprot_protein_search`
- `scientific.pdb_entry_lookup`
- `scientific.ensembl_gene_lookup`
- `scientific.reactome_pathway_mapping`
- `scientific.quickgo_annotation_search`
- `scientific.chebi_term_search`
- `scientific.interpro_protein_entries`
- `scientific.string_identifier_mapping`
- `scientific.kegg_find`
- `scientific.opentargets_target_lookup`

Source: `K-Dense-AI/scientific-agent-skills`, MIT license. See `LICENSE.md`.
