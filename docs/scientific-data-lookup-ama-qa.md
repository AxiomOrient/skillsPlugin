# Scientific Data Lookup AMA QA

Date: 2026-05-24

## Scope

This document records the third AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-data-lookup`

Converted skills:

- `database-lookup`
- `hugging-science`
- `usfiscaldata`
- `depmap`

The conversion target is iOS AMA. This category preserves mobile-safe research instructions and reference files, then moves executable network lookup behavior into AMA native Swift host intents.

## Mobile Capability

The plugin installs as one category with `ama-skill-plugin.json`. Each skill has an AMA-specific `SKILL.md` and includes upstream plain-document references where useful.

Included reference material:

- `database-lookup/references/*`
- `hugging-science/references/*`
- `usfiscaldata/references/*`
- `depmap/references/dependency_analysis.md`

Runtime-backed native intents:

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

Excluded behavior:

- no upstream `scripts/`
- no Python, shell, PowerShell, batch, Node, R, MATLAB, Docker, local CLI, or package manager files
- no desktop-only execution path

The pack still installs reference-heavy skills even when a future skill needs Swift support. Unsupported desktop execution is not hidden; AMA marks script-backed plugin skills as unavailable on mobile while leaving native `run_intent` skills available.

## AMA Runtime Implementation

AMA now has `AMASkillScientificDataLookupIntents` under `AMASkillsHost`.

The host normalizes public API responses into compact JSON for mobile use:

- Hugging Face dataset id, author, URL, description, license, task categories, tags, downloads, likes, gated state, last modified timestamp, and splits.
- Fiscal Data debt record date, total public debt outstanding, debt held by public, intragovernmental holdings, fiscal year, fiscal quarter, and raw labels.
- DepMap public release, release date, filename, signed download URL, MD5 hash, and file type from the official downloads CSV endpoint.
- PubChem CID, compound URL, molecular formula, molecular weight, SMILES, and IUPAC name from PUG REST.
- UniProt accession, entry ID, reviewed state, protein name, gene names, organism, taxonomy ID, and sequence length from UniProtKB REST.
- RCSB PDB entry ID, title, release date, experimental method, resolution, DOI, and primary citation title from the RCSB Data API.
- Ensembl gene stable ID, display name, description, species, assembly, locus, strand, and canonical transcript from Ensembl REST.
- Reactome stable pathway ID, dbId, display name, species, class, disease flag, diagram flag, dates, and DOI from ContentService mappings.
- QuickGO annotation ID, gene product, symbol, GO ID, aspect, evidence, reference, taxon, assigning group, and date from EBI QuickGO services.
- ChEBI OBO ID, label, IRI, description, and synonyms from EBI OLS4 ChEBI search.
- InterPro accession, name, entry type, GO terms, and protein location fragments from the InterPro JSON API.
- STRING query item, STRING ID, preferred name, taxon, annotation, and network URL from the STRING JSON API.
- KEGG entry ID, description, entry URL, and raw TSV line from KEGG REST `find`.
- Open Targets approved symbol, approved name, biotype, function descriptions, protein IDs, subcellular locations, and pathways from the public GraphQL API.
- `mobile_runtime.local_scripts_executed=false` is included so QA can verify that the iOS path did not run local programs.

AMASample registers these host intents in its verification runtime and exposes a one-by-one scenario:

- `ama-skills-host-scientific-data-lookup`

## Product Tests

AMA package tests:

```text
cd /Users/axient/repoAgent/AMA
swift test --filter scientificDataLookup
```

Result:

- Passed 2 tests.
- Verified native intent response normalization for Hugging Face, Fiscal Data, DepMap, PubChem, UniProt, PDB, Ensembl, Reactome, QuickGO, ChEBI, InterPro, STRING, KEGG, and OpenTargets.
- Verified the actual `scientific-data-lookup` plugin installs, loads, and calls `scientific.huggingface_dataset_search` through AMA native intent execution.

AMASample local AMA package tests:

```text
cd /Users/axient/repoAgent/AMASample/LocalPackages/AMA
swift test --filter scientificDataLookup
```

Result:

- Passed 2 tests after syncing `/Users/axient/repoAgent/AMA` into `/Users/axient/repoAgent/AMASample/LocalPackages/AMA`.

AMASample iOS simulator tests:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleScientificDataLookupDerivedData
```

Result:

- Passed 25 Swift Testing tests.
- Verified `prepareExposesOneByOneAMAVerificationScenarios` includes and executes `ama-skills-host-scientific-data-lookup`.
- Verified the scenario output reports data lookup host intent readiness, DepMap release file lookup, PubChem compound lookup, UniProt protein lookup, PDB entry lookup, Ensembl gene lookup, Reactome pathway mapping, QuickGO annotation search, ChEBI term search, InterPro protein entries, STRING identifier mapping, KEGG find, OpenTargets target lookup, and tool adapter registration.

A narrower `-only-testing AMASampleServiceTests/prepareExposesOneByOneAMAVerificationScenarios` run built successfully but executed 0 XCTest tests because this suite uses Swift Testing discovery. That run is treated as a harness mismatch, not product proof.

## Real Use Test

A temporary Swift package at `/tmp/ama-data-live-depmap` called the real AMA native intents over live public APIs.

Observed mobile result:

```text
live_depmap_status=ok
live_depmap_count=2
live_depmap_release=DepMap Public 26Q1
live_depmap_file=ScreenSequenceMap.csv
live_pubchem_cid=2244
live_pubchem_formula=C9H8O4
live_uniprot_accession=P04637
live_uniprot_reviewed=true
live_pdb_entry=4HHB
live_pdb_resolution=1.74
live_ensembl_gene=ENSG00000141510
live_reactome_pathway=R-HSA-111448
live_quickgo_annotation=GO:0008285
live_chebi_term=CHEBI:15377
live_interpro_entry=IPR002117
live_string_id=9606.ENSP00000269305
live_kegg_entry=cpd:C01405
live_opentargets_symbol=TP53
live_scripts=false
```

This proves the mobile path used AMA Swift host intents and public HTTPS APIs without invoking local scripts.

The DepMap source endpoint was also checked directly on 2026-05-24:

```text
https://depmap.org/portal/api/download/files
content-type: text/csv
header: release,release_date,filename,url,md5_hash
first release observed: DepMap Public 26Q1
```

## Desktop Comparison

Desktop REST comparison used the same public API surfaces directly:

- Hugging Face datasets API
- U.S. Fiscal Data API
- DepMap downloads CSV API
- PubChem PUG REST API
- UniProtKB REST API
- RCSB PDB Data API
- Ensembl REST API
- Reactome ContentService API
- EBI QuickGO REST API
- EBI OLS4 ChEBI API
- InterPro JSON API
- STRING JSON API
- KEGG REST API
- Open Targets Platform GraphQL API

Observed desktop result:

```text
desktop_hf_dataset_id= microsoft/msr_genomics_kbcomp
desktop_hf_gated= False
desktop_fiscal_date= 2026-05-14
desktop_fiscal_total= 38954466670318.20
desktop_depmap_first_release= DepMap Public 26Q1
desktop_depmap_first_file= ScreenSequenceMap.csv
desktop_pubchem_cid= 2244
desktop_uniprot_accession= P04637
desktop_pdb_entry= 4HHB
desktop_ensembl_gene= ENSG00000141510
desktop_reactome_pathway= R-HSA-111448
desktop_quickgo_annotation= GO:0008285
desktop_chebi_term= CHEBI:15377
desktop_interpro_entry= IPR002117
desktop_string_id= 9606.ENSP00000269305
desktop_kegg_entry= cpd:C01405
desktop_opentargets_symbol= TP53
```

Quality judgment:

- Equivalent for the tested lookup outputs. Mobile and desktop returned the same Hugging Face top dataset, the same Fiscal Data latest debt date and total, DepMap release file metadata from the same CSV schema, PubChem aspirin CID 2244, UniProt reviewed TP53 accession P04637, PDB entry 4HHB, Ensembl TP53 gene ENSG00000141510, Reactome pathway R-HSA-111448, QuickGO annotation GO:0008285, ChEBI water term CHEBI:15377, InterPro p53 family entry IPR002117, STRING TP53 identifier 9606.ENSP00000269305, KEGG aspirin compound cpd:C01405, and Open Targets TP53 symbol.
- Better suited for iOS because the executable behavior is native Swift host intent code rather than desktop shell or Python scripts.
- Not yet equivalent for every database mentioned by upstream `database-lookup`. This slice covers Hugging Face, Fiscal Data, DepMap release-file discovery, PubChem compound properties, UniProt protein search, PDB entry lookup, Ensembl gene lookup, Reactome pathway mapping, QuickGO annotation search, ChEBI term search, InterPro protein entries, STRING identifier mapping, KEGG find, and OpenTargets target lookup with native intents, keeps database routing/reference material, and leaves bulk DepMap matrix computation as remote/desktop work.

## Remaining Work

This category is production-usable for the implemented public lookup surfaces, with medium release confidence for the whole category because not every upstream database has a native AMA intent yet.

Next conversion slices should add native intents only when the mobile behavior can be verified end to end:

- Additional public REST databases such as NCBI E-utilities, ENA, BindingDB, BioGRID, and Metabolomics Workbench.
- Remote compute/database packs that require credentials and user approval.
- Clear unavailable-on-mobile status for any upstream skill that still requires external programs.
