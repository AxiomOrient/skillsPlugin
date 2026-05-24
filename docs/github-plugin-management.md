# GitHub Plugin Management For AMA

Date: 2026-05-24

## Decision

AMA should manage large skill sets as GitHub-hosted plugin repositories, not as loose individual skills.

The user-facing install input can be either:

- Repository root: `https://github.com/AxiomOrient/skillsPlugin`
- Specific plugin pack: `https://github.com/AxiomOrient/skillsPlugin/tree/main/plugins/scientific-documents`

The repository root path installs the packs declared in `ama-skill-repository.json`, including the 11 scientific category packs. A specific plugin tree path installs only that pack.

## Research Basis

GitHub's REST Contents API can read public repository contents without authentication, and private repository access uses fine-grained tokens with `Contents` read permission. For large repository roots, GitHub's Git Trees API supports recursive tree listing, which avoids one Contents API call per directory. GitHub's archive endpoints are redirects and private archive URLs expire, so AMA uses Contents plus Trees API metadata and raw file downloads for deterministic file-by-file mobile installs instead of shelling out to `git` or relying on desktop zip tools.

Reference:

- GitHub REST repository contents: `https://docs.github.com/en/rest/repos/contents`
- GitHub REST Git trees: `https://docs.github.com/en/rest/git/trees`
- GitHub repository archive endpoints: `https://docs.github.com/en/rest/repos/contents#download-a-repository-archive-zip`

## AMA Runtime Behavior

Implemented AMA APIs:

- `AMASkillLibrary.installSkillPlugins(fromRemoteRepositoryURL:selectedByDefault:)`
- `AMASkillLibrary.uninstallSkillPlugins(fromRemoteRepositoryURL:)`

Minimal host-app usage:

```swift
let installed = try await library.installSkillPlugins(
    fromRemoteRepositoryURL: "https://github.com/AxiomOrient/skillsPlugin"
)

let removedPluginIDs = try await library.uninstallSkillPlugins(
    fromRemoteRepositoryURL: "https://github.com/AxiomOrient/skillsPlugin"
)
```

Install flow:

1. Normalize the user-provided HTTPS GitHub URL.
2. Fetch repository contents through `AMAURLSessionRemoteSkillFetcher`.
3. If the repository root contains `ama-skill-repository.json`, use that index and Git Trees API recursive listing to fetch only declared plugin pack paths.
4. For a specific tree URL or repositories without an index, discover AMA plugin manifests named `ama-skill-plugin.json`.
5. Materialize each plugin package into a temporary local directory.
6. Reuse `installSkillPlugin(fromDirectoryURL:)` so local and GitHub installs share validation, skill-name collision checks, execution-support classification, selection state, and update behavior.
7. Store each installation with a `sourceLocation` derived from the repository URL and plugin path.

Uninstall flow:

1. Normalize the same GitHub repository URL.
2. Find installed plugin records whose `sourceLocation` matches that repository or a `#plugins/...` child.
3. Remove all matched plugin skill directories and selection state through `uninstallSkillPlugin(id:)`.

## Scientific Pack Management

The root repository currently declares 11 scientific plugin packs in `ama-skill-repository.json`:

```text
scientific-clinical-compliance: 4
scientific-compute-remote: 84
scientific-data-lookup: 4
scientific-deferred-desktop: 2
scientific-documents: 5
scientific-lab-connectors: 11
scientific-literature: 4
scientific-reasoning-docs: 6
scientific-reference: 5
scientific-visual-artifacts: 9
scientific-web-research: 8
```

Total scientific installed skills: 142.

This gives the app three management levels:

- all packs: install/uninstall by repository URL
- category pack: install/uninstall by plugin URL or plugin id
- individual skill: load/select within the installed plugin, but delete by plugin unit

## Verification

AMA package test:

```sh
cd /Users/axient/repoAgent/AMA
swift test --filter 'RemoteSkill|Plugin'
```

Result on 2026-05-24:

```text
16 RemoteSkill|Plugin tests passed
```

AMASample iOS simulator service test:

```sh
xcodebuild test \
  -workspace /Users/axient/repoAgent/AMASample/App.xcworkspace \
  -scheme AMASampleService \
  -destination 'platform=iOS Simulator,name=iPad (A16)' \
  -only-testing AMASampleServiceTests
```

Result on 2026-05-24:

```text
25 tests passed
```

Full scientific repository smoke:

```sh
cd /Users/axient/repoAgent/skillsPlugin/tools/ama_scientific_all_plugin_smoke
swift run AMAScientificAllPluginSmoke
```

Result:

```text
all_plugin_count=15
all_installed_skill_count=150
all_loaded_skill_count=150
scientific_plugin_count=11
scientific_installed_skill_count=142
scientific_loaded_skill_count=142
scientific_executable_or_script_files=0
scientific_script_runner_calls=0
scientific_pdf_installed=false
scientific_markdown_document_convertible=true
scientific_python_route=blocked_remote_compute
scientific_matlab_route=ios_native
akasha_security_status=ok
akasha_security_verdict=BLOCK
```

Live GitHub root install smoke:

```text
source=https://github.com/AxiomOrient/skillsPlugin
live_github_installations=11
live_github_plugin_skills=142
live_github_removed=11
live_github_final_plugins=0
```

## UI Contract

The AMA app should expose:

- `Install from GitHub URL`
- `Update from source`
- `Uninstall source`
- per-pack install/uninstall controls for category packs

For the current repository, entering `https://github.com/AxiomOrient/skillsPlugin` should install the whole pack set. Entering a tree URL under `plugins/` should install only that category.
