# AMA Skills Plugin

Documentation-only skill pack for AMA.

This repository is intentionally limited to skills that can run as instructions and reference material inside AMA. Skills that require scripts, shell commands, Python/Node helpers, or external programs should be implemented as native Swift AMA capabilities and exposed through AMA host/runtime surfaces instead of shipping executable files in this pack.

## Layout

```text
.codex-plugin/plugin.json   # AMA plugin manifest for local clone installs
catalog.json                 # machine-readable list of web-installable skills
skills/<skill-name>/         # one complete documentation-only skill package
  SKILL.md
  references/                # optional supporting docs
  agents/                    # optional non-executable role guidance
  assets/                    # optional static reference assets
```

## Install

Install one skill by GitHub directory URL:

```text
https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-release-readiness
```

Install the whole pack after cloning this repository by pointing AMA at the repository root. The pack manifest is `.codex-plugin/plugin.json`.

## Execution Policy

- `executionSupport: available`: skill is documentation-only and can be loaded directly by AMA.
- Script-backed or external-program-backed workflows are not included here.
- If a workflow needs execution on iOS, implement the executable part in Swift inside AMA, then keep only the instruction/reference layer in this repository.

## Skills

| Skill | Description | Install URL |
| --- | --- | --- |
| `analyze-architecture-integrity` | [analyze] 정해진 코드 범위에서 모듈 경계, 이름, 책임, 의존 방향이 흐려졌는지 근거로 확인합니다. 구조가 유지보수와 확장을 막는지 먼저 판단해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-architecture-integrity) |
| `analyze-build-constraints` | [analyze] 제품, 기능, 앱, CLI, 라이브러리, 스킬, 플러그인을 만들기 전에 1-page north star, 고객 job, 분리 가능한 core tech/IP, 사용자에게 보이는 defining constraint, feature creep 위험, 검증 증거로 빌드/보류/축소/폐기 여부를 판정합니다. 사용자가 '만들어도 되나', '빌드 전 검토', 'one pager', '원페이지', '핵심 제약', '제품 정체성', 'feature creep 방지', '이 아이디어를 구현해도 되는지'를 요청할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-build-constraints) |
| `analyze-failure-reproduction` | [analyze] 흐릿한 버그 제보를 다시 실행할 수 있는 실패 절차로 바꿉니다. 증상은 있지만 재현 단계가 없거나 불안정해서 원인 분석이나 수정을 시작하기 전에 최소 재현 방법을 먼저 고정해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-failure-reproduction) |
| `analyze-product-direction` | [analyze] 제품, 기능, 문서, 패키지, 도구를 만들지 말지 또는 어느 방향으로 좁힐지 판단합니다. 구현 전에 사용자 가치, 가장 큰 위험, 확인 방법을 정해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-product-direction) |
| `analyze-product-identity` | [analyze] 현재 저장소가 실제로 무엇을 제공하고 누구에게 가치가 있는지 코드, 설정, 문서, 테스트 근거로 파악합니다. README 주장과 실제 구현이 맞는지 확인할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-product-identity) |
| `analyze-refactor-target` | [analyze] 코드를 바로 바꾸기 전에 리팩터링 대상과 가장 작은 안전 범위를 찾습니다. 큰 정리 작업을 작게 자르거나 과한 분리를 피해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-refactor-target) |
| `analyze-release-readiness` | [analyze] 정해진 릴리스 범위가 지금 배포 가능한지 판단합니다. 호환성, 위험, 테스트 상태, 롤백 준비를 근거로 go/no-go 결정을 내려야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-release-readiness) |
| `analyze-request-routing` | [analyze] 사용자 요청을 보고 다음에 어떤 작업 방식이 맞는지 분류합니다. 분석할지, 계획할지, 구현할지, 리뷰할지, 검증할지 애매할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-request-routing) |
| `analyze-root-cause` | [analyze] 이미 재현되거나 일부 재현되는 실패를 코드와 실행 결과로 추적합니다. 바로 고치기 전에 왜 실패하는지 원인과 수정 지점을 분명히 해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-root-cause) |
| `analyze-test-contract` | [analyze] 테스트가 중요한 동작을 제대로 증명하는지 확인합니다. 테스트가 약하거나 불안정하거나 너무 세부 구현에 묶였는지 판단해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-test-contract) |
| `analyze-ux-ui-improvement` | [analyze] UX 법칙, 사용성 휴리스틱, 접근성 기준, 플랫폼 가이드, 대상 제품 증거를 근거로 UX/UI 개선 룰을 만들고 화면, 앱, 웹, 도구의 개선 가능성을 분석할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/analyze-ux-ui-improvement) |
| `author-traceable-delivery-pack` | [author] 토론과 질의응답으로 추적 가능한 개발 운영 문서 패키지를 작성합니다. 제품 의도, 요구사항, 실행 표면, 에이전트 자동화 경계, 어댑터, QA, 릴리스 조건을 하나의 정합적인 문서 계약으로 고정해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/author-traceable-delivery-pack) |
| `author-work-spec` | [author] 구현자가 바로 쓸 수 있는 요구사항, 범위, 검증 기준 문서를 씁니다. 가벼운 메모나 코드 구현이 아니라, 현재 요청을 실행 가능한 작업 명세로 고정해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/author-work-spec) |
| `design-api-contract` | [design] API, 스키마, 모듈 경계에서 외부 사용자가 믿고 쓸 최소 약속을 정합니다. 구현보다 입력, 출력, 오류, 호환성 같은 공개 규칙을 먼저 정해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/design-api-contract) |
| `execute-architecture-realignment` | [execute] 이미 정해진 구조 문제를 실제 코드 변경으로 바로잡습니다. 동작은 유지하면서 패키지, 모듈, 이름, 책임, 의존 방향을 작은 범위에서 정리할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-architecture-realignment) |
| `execute-bounded-change` | [execute] 이미 할 일이 명확한 작은 코드 변경을 구현합니다. 범위가 정해진 기능 수정, 유지보수 변경, 재현 가능한 버그 수정을 바로 적용할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-bounded-change) |
| `execute-product-completion` | [execute] 구현 계획과 현재 코드 상태를 근거로 남은 제품 구현을 끝까지 처리합니다. 문서화된 요구사항, 검증된 실패, 핵심 사용자 경로를 막는 문제만 작은 단계로 구현하고 검증하며, 블로커는 먼저 해결을 시도하고 해결 불가하면 백로그로 남기거나 치명적이면 사용자에게 확인할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-product-completion) |
| `execute-refactor-go` | [execute] 이미 선택된 Go 리팩터링 범위를 구현합니다. 동작은 유지하면서 이름, 구조, 중복, 책임 분리를 작게 정리할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-refactor-go) |
| `execute-refactor-python` | [execute] 이미 선택된 Python 리팩터링 범위를 구현합니다. 동작은 유지하면서 이름, 구조, 중복, 책임 분리를 작게 정리할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-refactor-python) |
| `execute-refactor-rust` | [execute] 이미 선택된 Rust 리팩터링 범위를 구현합니다. 동작은 유지하면서 모듈, 타입, 이름, 책임 분리를 작게 정리할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-refactor-rust) |
| `execute-refactor-swift` | [execute] 이미 선택된 Swift 리팩터링 범위를 구현합니다. 동작은 유지하면서 파일, 타입, 뷰, 책임 분리를 작게 정리할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-refactor-swift) |
| `execute-release-notes` | [execute] 릴리스에 포함된 실제 변경 근거를 바탕으로 독자가 읽을 노트를 작성합니다. release notes, changelog, upgrade note, migration note, rollback note가 필요할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-release-notes) |
| `execute-test-guards` | [execute] 변경이나 위험을 테스트로 보호합니다. 실제 사용자 동작이나 버그 재발을 막는 최소 테스트를 추가하거나 기존 테스트를 더 믿을 수 있게 만들 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-test-guards) |
| `execute-ux-ui-improvement` | [execute] 이미 수락된 UX/UI 분석 결과나 개선 룰을 실제 코드와 화면에 적용합니다. 접근성, 반응형 레이아웃, 상태 처리, 내비게이션, 폼, 시각 계층을 동작 보존 범위에서 개선할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/execute-ux-ui-improvement) |
| `goal-refactor-swift` | Use when the user wants /goal-guided, iterative Swift refactoring or project cleanup: split real large objects only when it improves ownership, apply simplify-style reuse/quality/efficiency lenses, preserve behavior, verify each slice, and stop before overengineering or stylistic churn. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/goal-refactor-swift) |
| `meta-consensus` | [meta] 여러 분석 결과에서 일치점, 충돌점, 남은 확인 사항만 보수적으로 정리합니다. 하나의 분석을 새로 하는 일이 아니라, 이미 나온 둘 이상의 분석을 비교해 안전한 합의만 남겨야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/meta-consensus) |
| `meta-skill-chain` | [meta] 여러 스킬이 필요한 일을 순서와 넘길 값을 드러내어 묶습니다. 하나의 스킬로는 부족하고, 분석→계획→구현→검증처럼 명명된 단계와 스킬 경계가 보여야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/meta-skill-chain) |
| `orchestrate-essential-ux-refactor` | [meta] 핵심 사용자 결과 중심 UX 리팩터링을 분석, 계획, 실행, 검증 스킬로 라우팅합니다. 사용자가 핵심 흐름, 일반 사용자용 단순화, progressive disclosure, reduced clutter처럼 제품 표면을 핵심 작업 중심으로 재구성하길 원할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/orchestrate-essential-ux-refactor) |
| `plan-implementation-scope` | [plan] 이미 할 방향이 정해진 요청을 구현 가능한 작은 범위로 바꿉니다. 바로 코딩하기 전에 가정, 제외 범위, 완료 기준, 검증 방법을 분명히 해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/plan-implementation-scope) |
| `qa-boundary-proof` | [qa] 정해진 변경 후 경계 규칙이 지켜졌는지 확인합니다. 레이어, 모듈 의존 방향, 공개 API, 저장소 규칙을 증거로 검증해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-boundary-proof) |
| `qa-bug-fix-proof` | [qa] 구체적인 버그 수정 후보가 원래 재현을 없앴고 회귀 보호가 실제인지 확인합니다. 원인 찾기나 넓은 변경 리뷰가 아니라, 수정 후 같은 버그가 다시 나지 않는다는 증거가 필요할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-bug-fix-proof) |
| `qa-refactor-go` | [qa] 완료된 Go 리팩터링을 검증합니다. 동작 보존, 계약 유지, 응집도, 과분리 여부를 확인해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-refactor-go) |
| `qa-refactor-python` | [qa] 완료된 Python 리팩터링을 검증합니다. 동작 보존, 계약 유지, 응집도, 과분리 여부를 확인해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-refactor-python) |
| `qa-refactor-rust` | [qa] 완료된 Rust 리팩터링을 검증합니다. 동작 보존, 계약 유지, 응집도, 과분리 여부를 확인해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-refactor-rust) |
| `qa-refactor-swift` | [qa] 완료된 Swift 리팩터링을 검증합니다. 동작 보존, 계약 유지, 응집도, 과분리 여부를 확인해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/qa-refactor-swift) |
| `release-publish-package` | [release] 이미 승인되고 준비된 패키지 릴리스를 실제로 게시합니다. push나 publish 전에 명시적으로 확인하고, 배포와 되돌리기 기준이 준비됐을 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/release-publish-package) |
| `renew-mece-project-docs` | [execute] 여러 하위 프로젝트, 어댑터, 패키지, 도구, vendored capability를 가진 폴더의 README 계층을 MECE하게 갱신합니다. parent README는 summary-and-link index로 만들고, direct child README는 실제 manifest, build file, source entrypoint, test 근거로 상세 프로젝트 설명과 검증 방법을 써야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/renew-mece-project-docs) |
| `resolve-root-cause-prevent-recurrence` | [execute] 재현된 실패, 깨진 게이트, 스테일 아티팩트, 누락된 의존성, 불안정한 테스트, 회귀를 실제 근본 원인까지 추적하고 내구성 있게 수정하며 재발을 막습니다. '근본 원인 찾아줘', '남은 갭 해결해줘', '다시는 이 일이 없도록 해줘', '가드 추가해줘' 같은 요청에 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/resolve-root-cause-prevent-recurrence) |
| `review-change-verdict` | [review] 이미 바뀐 코드의 실제 결함, 테스트 공백, 통합 가능 여부를 findings-first로 리뷰합니다. 직접 구현, 체크리스트만 실행, 보안/실패경로 같은 좁은 전문 리뷰가 아니라 최종 integrate/hold 판단이 필요할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/review-change-verdict) |
| `review-failure-paths` | [review] 정해진 범위의 실패 상황만 리뷰합니다. 예외 처리, fallback, cleanup, 부분 실패, 재시도 흐름이 안전한지 확인할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/review-failure-paths) |
| `review-project-completion` | [review] 프로젝트가 정해진 목표를 실제로 만족하는지 검토합니다. 요구사항, 구현, 테스트, 문서가 서로 맞는지 보고 완료/미완료/차단 상태를 판단할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/review-project-completion) |
| `review-quality-check` | [review] 정해진 범위의 품질을 리뷰합니다. 버그 위험, 테스트 약점, 유지보수 문제, 변경 여파를 표준 체크리스트로 확인할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/review-quality-check) |
| `review-security-check` | [review] 정해진 범위의 보안 위험을 리뷰합니다. 인증, 권한, 입력 검증, 비밀정보, 데이터 노출처럼 실제 문제가 될 수 있는 위험을 찾을 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/review-security-check) |
| `simplify` | [simplify] 동작을 바꾸지 않고 코드를 더 단순하게 만듭니다. 중복, 약한 래퍼, 불필요한 추상화, 숨은 복잡도를 한 번에 하나씩 줄일 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/simplify) |
| `xbmcp-build` | [xbmcp] iOS 시뮬레이터 빌드를 확인할 때 사용합니다. 코드 변경 후 `xcodebuildmcp simulator build`로 컴파일 성공을 증명해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-build) |
| `xbmcp-daemon` | [xbmcp] XcodeBuildMCP 데몬 상태와 로그를 확인할 때 사용합니다. log capture, video recording, LLDB/debugging, build-and-run 로그 문제가 의심될 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-daemon) |
| `xbmcp-find` | [xbmcp] XcodeBuildMCP로 빌드 전에 프로젝트, 워크스페이스, scheme, simulator를 찾을 때 사용합니다. `--project-path`, `--workspace-path`, `--scheme`, `--simulator-name` 값을 모를 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-find) |
| `xbmcp-run` | [xbmcp] iOS 앱을 시뮬레이터에서 실행해 볼 때 사용합니다. `xcodebuildmcp simulator build-and-run`으로 build, install, launch를 한 번에 확인해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-run) |
| `xbmcp-setup` | [xbmcp] XcodeBuildMCP를 설치하고 프로젝트 기본 설정을 만들 때 사용합니다. `xcodebuildmcp setup`, `xcodebuildmcp doctor`, `.xcodebuildmcp/config.yaml`, sessionDefaults 설정이 필요할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-setup) |
| `xbmcp-spm` | [xbmcp] Swift Package를 빌드하거나 테스트할 때 사용합니다. `Package.swift` 기반 프로젝트에서 `xcodebuildmcp swift-package build`, `test`, `clean`을 실행해야 할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-spm) |
| `xbmcp-test` | [xbmcp] iOS 시뮬레이터에서 테스트를 실행할 때 사용합니다. `xcodebuildmcp simulator test`, XCTest, 전체 테스트, 특정 테스트, `-only-testing` 검증이 필요할 때 사용합니다. | [GitHub](https://github.com/AxiomOrient/skillsPlugin/tree/main/skills/xbmcp-test) |

## Excluded Script-Backed Skills

See `EXCLUDED_EXECUTABLE_SKILLS.json`. Those workflows should either remain local to Codex/desktop environments or be backed by Swift implementations in AMA before being exposed to iOS users.
