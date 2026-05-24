# Scientific Agent Skills Coverage Audit

Date: 2026-05-24

## Source Snapshot

- Upstream repository: `https://github.com/K-Dense-AI/scientific-agent-skills`
- Upstream commit checked: `66d1ad45ccbfe18f8665cd72d1ecb1043cd678f9`
- Upstream `scientific-skills/*/SKILL.md` count: 139
- AMA scientific plugin manifest skill total: 142
- AMA scientific plugin count: 11
- AMA manifest path validation: 142 manifest entries point to existing `SKILL.md` files.
- Per-skill route map: `docs/scientific-agent-skills-skill-map.md`.
- Full AMA runtime install/load smoke: `docs/scientific-all-plugin-install-ama-qa.md`.

## Product Rule

AMA iOS installs scientific skills as mobile plugin packs, not as the original desktop repository. Original `scripts/`, local Python, shell, PowerShell, batch, Node, MATLAB, Docker, package-manager, notebook, and desktop-only execution paths are not mobile capabilities.

Binary PDF handling is intentionally removed from the AMA mobile scientific skill set. The replacement product contract is Markdown-first:

- Use `scientific.document_inspect` and `scientific.document_to_markdown` for supported UTF-8 text-like artifacts, Markdown, CSV/TSV, JSON, XML, and HTML.
- Ask users to provide a Markdown or UTF-8 text-like export when the source is a binary document.
- Route future PDF publishing, OCR, or full-fidelity parsing through an approved native Swift document host intent or approved remote service; do not advertise local PDF execution.

## Coverage Result

Direct upstream-to-local name comparison intentionally reports one missing upstream skill:

| Upstream skill | AMA status | Reason | Replacement |
|---|---|---|---|
| `pdf` | intentionally removed | User requirement: remove PDF and replace with Markdown document flow. iOS mobile must not expose binary PDF parsing as an installed local skill. | `scientific-documents` pack with `markdown-mermaid-writing`, `markitdown`, `docx`, `pptx`, `xlsx`, plus Swift intents `scientific.document_inspect` and `scientific.document_to_markdown`. |

All other upstream skills are represented either by the same skill name or by a converted AMA category pack with mobile-safe routing:

| AMA category | Manifest skill count | Runtime pattern |
|---|---:|---|
| `scientific-clinical-compliance` | 4 | Documentation-only and clinical-safe output guidance |
| `scientific-compute-remote` | 84 | Remote preflight or Swift native substitutes for limited chart/numeric cases |
| `scientific-data-lookup` | 4 | Swift `URLSession` public API lookup intents |
| `scientific-deferred-desktop` | 2 | Desktop-only behavior blocked, with Swift native substitute where available |
| `scientific-documents` | 5 | Markdown-first Swift artifact intents and Office reference guidance |
| `scientific-lab-connectors` | 11 | Connector preflight, credentials, approval, and audit boundary |
| `scientific-literature` | 4 | Swift literature/search/citation intents |
| `scientific-reasoning-docs` | 6 | Documentation-only reasoning and writing guidance |
| `scientific-reference` | 5 | Documentation-only scientific thinking guidance |
| `scientific-visual-artifacts` | 9 | Artifact preflight, Markdown/SVG/native or remote renderer routing |
| `scientific-web-research` | 8 | Swift web API preflight and approved provider search |

The full one-row-per-upstream-skill mapping is maintained in `scientific-agent-skills-skill-map.md`.

## Validation Commands

```sh
git -C /tmp/scientific-agent-skills-latest rev-parse HEAD
find /tmp/scientific-agent-skills-latest -maxdepth 3 -path '*/scientific-skills/*/SKILL.md' -print | sed 's#.*/scientific-skills/##; s#/SKILL.md##' | sort > /tmp/upstream-scientific-skills.txt
find /Users/axient/repoAgent/skillsPlugin/plugins/scientific-* -path '*/skills/*/SKILL.md' -print | sed 's#.*/skills/##; s#/SKILL.md##' | sort -u > /tmp/ama-scientific-skills.txt
comm -23 /tmp/upstream-scientific-skills.txt /tmp/ama-scientific-skills.txt
```

Expected result:

```text
pdf
```

The expected `pdf` result is not a release gap. It is the intentional exclusion described above.

Manifest path validation:

```sh
python3 - <<'PY'
import json, pathlib
root = pathlib.Path('/Users/axient/repoAgent/skillsPlugin/plugins')
errors = []
plugin_count = 0
skill_count = 0
for manifest in sorted(root.glob('scientific-*/ama-skill-plugin.json')):
    plugin_count += 1
    data = json.loads(manifest.read_text())
    for item in data.get('skills', []):
        rel = item.get('path') if isinstance(item, dict) else str(item)
        skill_count += 1
        if not (manifest.parent / rel / 'SKILL.md').exists():
            errors.append(f'{manifest.parent.name}:{rel}')
print(f'plugin_count={plugin_count}')
print(f'manifest_skill_count={skill_count}')
print(f'missing_manifest_paths={len(errors)}')
for error in errors:
    print(error)
PY
```

Expected result:

```text
plugin_count=11
manifest_skill_count=142
missing_manifest_paths=0
```

The four local extras are the AMA-native literature aliases from the first converted pack:

```text
scientific-citation-management
scientific-literature-review
scientific-paper-lookup
scientific-research-lookup
```

Full AMA runtime smoke:

```sh
cd /Users/axient/repoAgent/skillsPlugin/tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Expected core result:

```text
scientific_plugin_count=11
scientific_installed_skill_count=142
scientific_loaded_skill_count=142
scientific_pdf_installed=false
scientific_executable_or_script_files=0
scientific_script_runner_calls=0
scientific_python_route=blocked_remote_compute
scientific_matlab_route=ios_native
```

## Regression Guard

Do not re-add `plugins/scientific-documents/skills/pdf` or any top-level AMA scientific `pdf` skill unless the product decision changes. If a future implementation adds PDF support, it must be a native Swift or approved remote capability with explicit tests for:

- no local script execution
- no desktop helper dependency
- user approval for external or remote processing
- Markdown-equivalent output path when the user needs document content inside AMA
