---
name: xbmcp-setup
description: "[xbmcp] XcodeBuildMCP를 설치하고 프로젝트 기본 설정을 만들 때 사용합니다. `xcodebuildmcp setup`, `xcodebuildmcp doctor`, `.xcodebuildmcp/config.yaml`, sessionDefaults 설정이 필요할 때 사용합니다."
---

# XcodeBuildMCP Setup

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

XcodeBuildMCP를 MCP 서버가 아니라 직접 CLI로 쓰도록 준비합니다.
기본 호출 형태는 `xcodebuildmcp <workflow> <tool> [options]`입니다.

## 설치 확인

1. 먼저 기존 설치를 확인합니다.

```bash
xcodebuildmcp --help
xcodebuildmcp doctor
```

2. 없으면 Homebrew를 우선 사용합니다.

```bash
brew tap getsentry/xcodebuildmcp
brew install xcodebuildmcp
```

3. Homebrew를 쓸 수 없을 때만 npm을 사용합니다.

```bash
npm install -g xcodebuildmcp@latest
```

공식 요구사항을 벗어난 환경이면 설치 성공을 단정하지 않습니다. npm 설치는 Node.js 18.x 이상이 필요합니다.

## 프로젝트 설정

프로젝트 루트에서 실행합니다.

```bash
xcodebuildmcp setup
```

생성 또는 수정 대상은 repo-local 설정 파일입니다.

```text
.xcodebuildmcp/config.yaml
```

이 파일은 버전 관리 가능한 프로젝트 설정입니다. `schemaVersion: 1`을 반드시 둡니다.

## 최소 설정

`.xcodeproj` 프로젝트:

```yaml
schemaVersion: 1

sessionDefaults:
  projectPath: "./MyApp.xcodeproj"
  scheme: "MyApp"
  configuration: "Debug"
  simulatorName: "iPhone 17 Pro"

sentryDisabled: true
debug: false
```

워크스페이스 프로젝트:

```yaml
schemaVersion: 1

sessionDefaults:
  workspacePath: "./MyApp.xcworkspace"
  scheme: "MyApp"
  configuration: "Debug"
  simulatorName: "iPhone 17 Pro"

sentryDisabled: true
debug: false
```

Swift Package:

```yaml
schemaVersion: 1

sessionDefaults:
  configuration: "Debug"

sentryDisabled: true
debug: false
```

## 운영 규칙

- `workspacePath`와 `projectPath`를 동시에 넣지 않습니다. 둘 다 있으면 일반적으로 `.xcworkspace`를 우선합니다.
- scheme, simulatorName, project/workspace 경로를 모르면 추측하지 말고 `xbmcp-find` 범위의 탐색을 먼저 수행합니다.
- 설정 후 `xcodebuildmcp doctor`를 다시 실행합니다.
- 설정 파일이 준비되면 이후 build/test/run 스킬에서는 반복 플래그 대신 `xcodebuildmcp simulator build`, `xcodebuildmcp simulator test`, `xcodebuildmcp simulator build-and-run` 형태를 우선합니다.
- 설치나 설정만 끝난 상태를 앱 작업 완료로 선언하지 않습니다. 완료 선언에는 별도 build/test/run 성공이 필요합니다.
