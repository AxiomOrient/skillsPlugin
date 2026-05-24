# Plugin Pack Structure

AMA plugin packs should be grouped by user-facing mobile capability. A pack is the install/uninstall unit.

## Repository Layout

```text
plugins/
  create/
    ama-skill-plugin.json
    README.md
    skills/
      create-qr-code/
        SKILL.md
        scripts/
          index.html
      create-share-card/
        SKILL.md
        references/
          styles.md
  device/
    ama-skill-plugin.json
    README.md
    skills/
      device-torch-control/
        SKILL.md
      device-screen-session/
        SKILL.md
```

## Manifest Template

Use `ama-skill-plugin.json`, not `.codex-plugin/plugin.json`, for AMA-native packs.

```json
{
  "schemaVersion": "ama.skill.plugin.v1",
  "id": "io.axiomorient.ama.skills.create",
  "name": "AMA Create Skills",
  "version": "0.1.0",
  "description": "Mobile creation skills for AMA.",
  "homepage": "https://github.com/AxiomOrient/skillsPlugin/tree/main/plugins/create",
  "skills": [
    {
      "path": "skills/create-qr-code",
      "selected": true
    }
  ]
}
```

## Category Recommendations

Start with these packs only when there is a real skill to put inside them:

- `create`: generate QR, simple visuals, share cards, text transformations.
- `device`: torch, brightness, haptics, clipboard, volume, idle timer routing.
- `productivity`: notes, summaries, reminders, calendar-like preparation if native support exists.
- `knowledge`: explain, summarize, transform user-provided text; no repo analysis.
- `media`: image/audio/video-facing mobile workflows backed by AMA runtime capabilities.
- `export`: artifact preview/share/export/upload workflows.

Avoid categories named after agent process:

- `analysis`
- `execution`
- `review`
- `qa`

Those are Codex-style workflow lanes, not mobile user capability packs.

## Repository Catalog

Use `ama-skill-repository.json` at the repository root when the GitHub URL should install multiple category packs.

The repository catalog is not a plugin manifest. It declares which category plugin paths belong to the public install set:

```json
{
  "schemaVersion": "ama.skill.repository.v1",
  "id": "io.axiomorient.ama.skills.repository",
  "name": "AxiomOrient AMA Skills Plugin Repository",
  "version": "0.1.0",
  "plugins": [
    {
      "id": "io.axiomorient.ama.scientific.documents",
      "path": "plugins/scientific-documents",
      "category": "scientific",
      "skillCount": 5
    }
  ]
}
```

## Install And Remove Behavior

AMA copies each plugin skill into the user skills root with a generated directory name based on plugin id and skill name. Removing a plugin removes every skill installed from that plugin.

Therefore:

- one plugin id equals one user-managed bundle
- do not mix unrelated categories in one manifest
- do not put experimental and stable skills in the same plugin
- do not make one repository-wide `ama-skill-plugin.json`
- use the root `ama-skill-repository.json` only as a catalog for category plugin paths

## Web Install Note

Repository root URLs can install all indexed category packs. Category tree URLs can install one pack. Individual skill URLs can still be installed from GitHub tree URLs, but category plugin install should be the primary path for curated AMA packs.
