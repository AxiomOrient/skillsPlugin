---
name: database-lookup
description: Mobile-safe routing for scientific database and public API lookup questions using included reference docs and AMA-native data intents where available.
---
# database-lookup

Use this skill when the user asks where to find scientific, biomedical, financial, environmental, astronomical, materials, or public-sector data.

## Workflow

1. Identify the entity type, domain, identifier, desired fields, time range, and whether the user needs metadata, records, bulk files, or analysis.
2. Route to the most specific included reference document under `references/`.
3. Prefer AMA-native host intents for supported public REST lookups.
4. Distinguish "can query now on iOS" from "reference only" and "requires external account/API key/remote compute".
5. Return source names, query plan, expected identifiers, limits, and next verification steps.

## Supported Native Paths

- Hugging Face dataset search: call `run_intent` with `scientific.huggingface_dataset_search`.
- U.S. Treasury Debt to the Penny latest record: call `run_intent` with `scientific.fiscaldata_latest_debt`.
- DepMap public release file metadata: call `run_intent` with `scientific.depmap_release_files`.
- PubChem compound properties: call `run_intent` with `scientific.pubchem_compound_lookup`.
- UniProtKB protein search: call `run_intent` with `scientific.uniprot_protein_search`.
- RCSB PDB entry metadata: call `run_intent` with `scientific.pdb_entry_lookup`.
- Ensembl gene lookup by species and symbol: call `run_intent` with `scientific.ensembl_gene_lookup`.
- Reactome pathway mapping for UniProt, ChEBI, or Ensembl identifiers: call `run_intent` with `scientific.reactome_pathway_mapping`.
- QuickGO annotation search by gene product, GO term, or taxon: call `run_intent` with `scientific.quickgo_annotation_search`.
- ChEBI term search through EBI OLS4: call `run_intent` with `scientific.chebi_term_search`.
- InterPro entries for a UniProt protein: call `run_intent` with `scientific.interpro_protein_entries`.
- STRING identifier mapping by gene or protein name: call `run_intent` with `scientific.string_identifier_mapping`.
- KEGG entry search through KEGG REST `find`: call `run_intent` with `scientific.kegg_find`.
- Open Targets target lookup by Ensembl ID through GraphQL POST: call `run_intent` with `scientific.opentargets_target_lookup`.

## Output Shape

Return:

- selected data source
- reason for selection
- query identifiers or parameters
- whether AMA can query it natively on iOS
- retrieved result or lookup plan
- source caveats and rate/API-key notes

## Mobile Boundary

Do not run scripts, package managers, notebooks, database CLIs, BigQuery CLIs, or local data-processing tools. If a database needs Python, R, SQL CLI, Docker, GPU, or large file processing, mark that part as remote/unsupported on iOS.
