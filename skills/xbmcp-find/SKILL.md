---
name: xbmcp-find
description: "[xbmcp] XcodeBuildMCP로 빌드 전에 프로젝트, 워크스페이스, scheme, simulator를 찾을 때 사용합니다. `--project-path`, `--workspace-path`, `--scheme`, `--simulator-name` 값을 모를 때 사용합니다."
---

# XcodeBuildMCP Discover

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

## 목적

빌드나 테스트 전에 필요한 CLI 입력값을 증거로 고정합니다. 추측한 scheme이나 simulator 이름으로 build/test를 시작하지 않습니다.

## 기본 순서

1. CLI와 tool 목록을 확인합니다.

```bash
xcodebuildmcp --help
xcodebuildmcp tools
```

2. 프로젝트 후보를 찾습니다.

```bash
xcodebuildmcp simulator discover-projects
```

필요하면 파일 시스템도 확인합니다.

```bash
rg --files -g '*.xcworkspace' -g '*.xcodeproj' -g 'Package.swift'
```

3. scheme 목록을 확인합니다.

`.xcodeproj`:

```bash
xcodebuildmcp simulator list-schemes \
  --project-path ./MyApp.xcodeproj
```

`.xcworkspace`:

```bash
xcodebuildmcp simulator list-schemes \
  --workspace-path ./MyApp.xcworkspace
```

4. simulator 이름이 필요하면 simulator 목록을 확인합니다.

```bash
xcodebuildmcp simulator list
```

## 선택 규칙

- `.xcworkspace`와 `.xcodeproj`가 함께 있으면 workspace를 우선합니다.
- 여러 scheme이 있으면 앱 scheme과 테스트 대상 scheme의 관계를 확인하고, 이름만 보고 임의 선택하지 않습니다.
- `.xcodebuildmcp/config.yaml`에 `sessionDefaults`가 이미 있으면 그 값을 우선 확인합니다.
- `xcodebuildmcp tools`에 원하는 tool이 없으면 설치 버전이나 workflow enablement 문제로 보고 setup/doctor로 되돌립니다.

## 결과 정리

탐색이 끝나면 다음 값을 짧게 남깁니다.

- project/workspace path
- scheme
- simulator name
- whether `.xcodebuildmcp/config.yaml` can remove repeated flags
- next command to run: build, test, build-and-run, or swift-package
