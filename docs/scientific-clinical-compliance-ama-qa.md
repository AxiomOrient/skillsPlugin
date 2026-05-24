# Scientific Clinical Compliance AMA QA

Date: 2026-05-16

## Scope

This document records the fourth AMA conversion slice for `K-Dense-AI/scientific-agent-skills`.

Converted category:

- `plugins/scientific-clinical-compliance`

Converted skills:

- `clinical-decision-support`
- `clinical-reports`
- `treatment-plans`
- `iso-13485-certification`

The conversion target is iOS AMA. This category is documentation-only in version `0.1.0`: it preserves clinical, regulatory, and QMS reference material while removing executable desktop behavior.

## Mobile Capability

The plugin installs as one category with `ama-skill-plugin.json`. Each skill has a mobile-specific `SKILL.md` and includes upstream reference/template material.

Included reference and template material:

- `clinical-decision-support`: 14 upstream reference/template files
- `clinical-reports`: 21 upstream reference/template files
- `treatment-plans`: 16 upstream reference/template files
- `iso-13485-certification`: 7 upstream reference/template files

Excluded behavior:

- no upstream `scripts/`
- no Python, shell, PowerShell, batch, Node, local LaTeX compilation, local validation scripts, or desktop automation
- no autonomous diagnosis, treatment, prescription, certification, legal, or regulatory determination

## Safety Rewrite

The upstream skills include useful documentation templates, but several source `SKILL.md` files instruct desktop agents to run Python scripts, generate schematics, validate documents, or produce clinical treatment material. Those instructions were not copied.

AMA rewrite rules applied:

- clinical skills are draft/documentation aids only
- de-identification and consent status must be explicit
- unknown clinical facts must stay unknown
- treatment-plan output must be clinician-reviewed and cannot prescribe
- ISO 13485 output is preliminary QMS documentation guidance, not certification advice
- future validators must be Swift host intents before they become executable mobile actions

## Static Checks

Script scan:

```text
find plugins/scientific-clinical-compliance -type f \
  \( -name '*.py' -o -name '*.sh' -o -name '*.ps1' -o -name '*.bat' -o -name '*.js' -o -name '*.ts' -o -perm +111 \) -print
```

Result:

- Empty output.

Manifest validation:

```text
python3 -m json.tool plugins/scientific-clinical-compliance/ama-skill-plugin.json
```

Result:

- Passed.

Reference/template parity:

```text
clinical-decision-support source_refs_assets=14 mobile_refs_assets=14
clinical-reports source_refs_assets=21 mobile_refs_assets=21
treatment-plans source_refs_assets=16 mobile_refs_assets=16
iso-13485-certification source_refs_assets=7 mobile_refs_assets=7
```

## Real Use Test

AMASample iOS simulator test:

```text
xcodebuild test \
  -scheme AMASampleService \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -destination 'platform=iOS Simulator,name=iPad (A16),OS=26.4.1' \
  -only-testing AMASampleServiceTests \
  -derivedDataPath /tmp/AMASampleClinicalComplianceDerivedData
```

Result:

- Passed 23 Swift Testing tests.
- Added and verified `ama-skills-plugin-clinical-compliance`.
- The scenario installs a clinical compliance category plugin, confirms four skills are selected and available, confirms references are copied, and confirms `load_skill` exposes de-identification and "Do not prescribe" mobile guardrails.

A temporary Swift package at `/tmp/ama-clinical-live` installed the real plugin from:

```text
/Users/axient/repoAgent/skillsPlugin/plugins/scientific-clinical-compliance
```

Observed result:

```text
clinical_installation_id=io.axiomorient.ama.scientific.clinical.compliance
clinical_skill_count=4
clinical_skill=clinical-decision-support|support=available|selected=true
clinical_skill=clinical-reports|support=available|selected=true
clinical_skill=iso-13485-certification|support=available|selected=true
clinical_skill=treatment-plans|support=available|selected=true
clinical_reports_loaded_ok=true
treatment_guardrail_loaded_ok=true
local_scripts_executed=false
```

This proves the actual plugin pack installs and `load_skill` exposes the expected de-identification and treatment safety guardrails without scripts.

## Desktop Comparison

Desktop source reference:

- `/tmp/scientific-agent-skills/scientific-skills/clinical-decision-support`
- `/tmp/scientific-agent-skills/scientific-skills/clinical-reports`
- `/tmp/scientific-agent-skills/scientific-skills/treatment-plans`
- `/tmp/scientific-agent-skills/scientific-skills/iso-13485-certification`

Quality judgment:

- Equivalent for documentation structure, reference lookup, template guidance, and checklist-oriented review.
- Better suited for iOS because desktop script instructions are removed and clinical/regulatory boundaries are explicit.
- Not equivalent for automated de-identification, document validation, LaTeX/binary document generation, image/schematic generation, or local gap-analysis execution. Those behaviors require future AMA Swift host intents or approved remote services.

## Release Confidence

Confidence for this category: medium.

Reason:

- Installation, loading, selected state, reference/template parity, and script exclusion are verified.
- The pack is documentation-only, so there is no hidden mobile execution path.
- Confidence is not high because clinical/regulatory output quality ultimately depends on human review and future executable validators are not implemented.
