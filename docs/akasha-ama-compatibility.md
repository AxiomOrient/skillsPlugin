# Akasha AMA Compatibility

## Decision

Akasha can run in AMA when its desktop scripts are treated as source algorithms and reimplemented as Swift host intents. The mobile skill package should not contain Python, shell, PowerShell, batch, subprocess, or SQLite helper scripts.

## Implemented Native Intent Slice

The first usable AMA slice maps these Akasha procedures to Swift intents:

| Akasha skill | AMA native intent | Pack |
|---|---|---|
| `akasha-scope-lock` | `akasha.scope_lock` | `intake-routing` |
| `akasha-route-lock` | `akasha.route_lock` | `intake-routing` |
| `akasha-request-router` | `akasha.request_route` | `intake-routing` |
| `akasha-security-checklist` | `akasha.security_check` | `safety-trust` |
| `akasha-gate-judgment` | `akasha.gate_judgment` | `safety-trust` |
| `akasha-brief-to-draft` | `akasha.brief_to_draft` | `writing-continuity` |
| `akasha-summarize` | `akasha.summarize` | `writing-continuity` |
| `akasha-patch-shape` | `akasha.patch_shape` | `engineering-control` |

## Remaining Akasha Surfaces

The remaining Akasha skills are not copied as executable desktop skills. They need one of these paths:

- document-only conversion when the skill is just decision procedure and output contract
- Swift host intent when it writes app state, creates artifacts, indexes files, or needs deterministic transformation
- WebKit skill only when it can run inside a bundled HTML/JS page without external process access

## Mobile Boundary

AMA skills should call `run_intent` for native capability. Swift code owns deterministic execution, workspace writes, artifact creation, permission gates, and durable app storage. `SKILL.md` owns only when to use the capability, what parameters to collect, and how to report the returned result.

## Compatibility Rule

A plugin pack is compatible only when:

- it has `ama-skill-plugin.json`
- every skill has `SKILL.md` frontmatter with `name` and `description`
- no skill folder contains `scripts/`, `.py`, `.sh`, `.ps1`, `.bat`, `.rb`, `.pl`, `.php`, `.ts`, or external-process assumptions
- any executable behavior is routed to an AMA Swift host intent
