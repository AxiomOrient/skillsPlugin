---
name: analyze-product-identity
description: "[analyze] 현재 저장소가 실제로 무엇을 제공하고 누구에게 가치가 있는지 코드, 설정, 문서, 테스트 근거로 파악합니다. README 주장과 실제 구현이 맞는지 확인할 때 사용합니다."
---

# Analyze Product Identity

Use this skill to diagnose an existing project's implemented, documented, or packaged value. Do not assume every repository is an app, codebase, or runtime product. Here, "product identity" means the real delivered value of the project or artifact, not commercial positioning. Do not use it to choose a future product direction; use `analyze-product-direction` for that.

## 최종 답변 우선 규칙

이 문서 아래에 고정 라벨, 표, JSON, 예시가 있어도 사용자에게 보이는 최종 답변은 이 규칙을 먼저 따른다.

- 결론, 판정, 변경사항을 첫 문장에 둔다.
- 기본 답변은 쉬운 한국어 2~4문장으로 끝낸다.
- 세부 근거, 명령, 파일 목록은 결과를 이해하거나 검증하는 데 꼭 필요할 때만 넣는다.
- 필수 출력 형식, JSON 계약, 사용자 요청 형식은 보존한다.
- 내부 정리용 라벨과 템플릿 문구는 그대로 노출하지 않는다.
- 불확실하면 추측하지 말고 확인해야 할 사실만 짧게 말한다.
- 사용자가 묻지 않은 다음 작업 추천은 넣지 않는다.

## 원자성 원칙

- 이 스킬은 이 `SKILL.md`와 같은 폴더의 `references/`, `scripts/`, `assets/`만으로 이해되고 실행되어야 한다.
- sibling skill, 전역 context 파일, 외부 설치 스킬에 의존하지 않는다.
- 한 번에 이 스킬이 맡은 일 하나만 수행한다. 범위를 벗어나면 다른 스킬 이름을 짧게 말하고 중지한다.

## 품질 기준

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.

## Scope Boundary

- This skill answers: "What is this project or artifact actually, based on evidence?"
- `analyze-product-direction` answers: "Which future direction should we choose next?"
- `analyze-repo-brownfield` answers: "What is in this repository technically?"
- `review-project-completion` answers: "Is the project complete against a known scope?"

Use this skill for requests like:

- "What is this repo actually trying to be?"
- "Is this an app, library, skill pack, spec package, static site, or artifact bundle?"
- "Who is the real user or consumer, based on evidence?"
- "Does the implementation, package, or documentation deliver the claimed value?"
- "Where does the current project make users lose trust?"
- "What should be repaired first inside the current identity?"

Do not use this skill for requests like:

- "Should we build feature X?"
- "Should this project pivot?"
- "Which market, audience, or future direction should we choose?"
- "Plan the implementation of this chosen change."

If the request mainly asks for code changes, stop after naming the better implementation or review workflow.

## Non-Match Handling

If the main request is a future direction choice, stop and route to `analyze-product-direction`.

If the request is mixed, first diagnose the current identity only when that diagnosis is needed; mark future choices as out of scope unless the user asks for a separate direction pass.

If the request is already implementation-ready or only about mutation, stop and route to the relevant implementation or planning skill.

When not matching, answer briefly:

- why this skill is not the right lane
- which skill or missing condition should come first

## Accuracy Gates

Before making the verdict, first classify the repository's artifact type. Common types:

- app/runtime service
- CLI or developer tool
- library or SDK
- UI/static site
- spec, method, or contract package
- skill pack, plugin, or prompt package
- adapter, extension, or integration package
- archive, generated bundle, or artifact delivery package
- mixed repository with more than one first-class surface

Then gather the smallest evidence set that can prove the current identity:

- file tree shape and dominant source/test/config/docs surfaces
- manifest, package, schema, or index files that define the public surface
- primary entrypoints, public APIs, install path, validation path, or consumption path
- one core path that creates the visible value: run, compile, validate, install, export, serve, or read
- representative tests, scripts, schemas, examples, or execution evidence when feasible

Choose evidence that matches the artifact type:

- apps and services: entrypoint, route/UI/API surface, runtime path, tests or smoke command
- CLIs and developer tools: command list, first success path, output contract, tests or examples
- libraries and SDKs: public API, package metadata, examples, compatibility contract, tests
- specs and method packages: canonical index, schema/contract shape, validation command, downstream consumption path
- skill/plugin/prompt packs: manifest or index, install path, representative skill/plugin contract, validation or sync script
- static sites and docs: source vs generated boundary, build command, published entrypoint, content contract
- archives/bundles: manifest, provenance, unpack/use path, verification or readiness evidence

For large repositories, do not claim exhaustive file understanding unless you performed an exhaustive inventory. Use `analyze-repo-brownfield` when the user needs complete repository inventory documentation.

In the final answer, state the evidence level briefly:

- commands, tests, validation scripts, or schema checks run
- commands that could not run and why
- important areas not inspected

## Accuracy Guardrails

- Do not infer a primary user from branding or README alone; confirm through entrypoints, commands, UI, API routes, or tests.
- Treat "product" as delivered value for a consumer or operator, not as a requirement that the target be a commercial app.
- Stay language- and platform-neutral. Do not assume Go, Rust, Node, web, mobile, CLI, or server architecture unless evidence requires it.
- Do not treat implemented auxiliary tooling as core value unless it is on the primary user path.
- Do not turn "repair priorities" into future strategy choices. Keep them inside the current product identity.
- For spec, skill, docs, and artifact-bundle repositories, judge value by whether a downstream user can consume, validate, install, or apply the package. Do not force a runtime user path where none exists.
- For mixed repositories, identify the dominant surface and secondary surfaces separately instead of flattening everything into one user path.
- For multi-project requests, keep identities, users, trust gaps, and repair priorities separate per project.
- Prefer `[UNKNOWN]` over a polished but unproven product story.

## Evidence Rules

- Use only repository files, code, docs, tests, configs, schemas, scripts, package metadata, examples, and execution or validation evidence.
- Prefer actual entrypoints, install paths, validation paths, schemas, or published artifacts over README claims.
- Prefer observed behavior, declared contracts, and verifiable package shape over intended design language.
- Exclude runtime artifacts from file-tree evidence by default: build output, caches, coverage output, compiled output, dependency install directories, editor/tool local state, and archive metadata. Inspect one only when the user explicitly scopes it or a manifest/script/test makes that exact artifact the subject.
- Do not exclude source-controlled generated code, vendored source, media assets, or test fixtures merely because they are non-standard files.
- Tag important claims as `[FACT]`, `[INFERENCE]`, `[JUDGMENT]`, or `[UNKNOWN]`.
- Attach file-path evidence to core claims.
- If runtime evidence is possible and low-risk, run the smallest command that proves the primary path.

## Workflow

1. Scan the file tree and classify source, tests, config/build scripts, docs/specs, assets/testdata, and packaged artifacts; exclude runtime artifacts from default evidence and note excluded artifact noise only if it affects trust.
2. Classify the artifact type before naming the user or value.
3. Find the primary user surface: CLI, UI, API, SDK, agent runtime, docs/spec package, skill pack, plugin bundle, static site, or archive.
4. Find real entrypoints or consumption paths and reconstruct the primary flow.
5. Identify the user's before-to-after change and the visible success condition.
6. Compare docs and claims against implemented or packaged behavior.
7. Diagnose where the user gets blocked, confused, or loses trust.
8. Separate core, auxiliary, risky, wasteful, and missing parts.
9. Produce identity repair priorities inside the current identity, not a future strategy roadmap.

## Output

Default to concise Korean unless the user requests another language.

For short answers, use:

- verdict: what it is, who it is for, current state, biggest weakness
- evidence: only the strongest file, package, execution, or validation facts
- identity repair priorities: what to fix, remove, or strengthen inside the current identity

For detailed audits, include these sections:

1. Verdict
2. Evidence Map
3. Project / Artifact Identity
4. Primary Flow Reconstruction
5. Surface Diagnosis
6. Architecture Diagnosis
7. Test Meaning
8. Truth vs Illusion
9. Identity Repair Priorities
10. Final Blunt Conclusion

Keep the final conclusion plain: what it is, what it is not, what is weak, what to remove, and what to make excellent next inside the current identity.
