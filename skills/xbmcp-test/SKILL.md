---
name: xbmcp-test
description: "[xbmcp] iOS 시뮬레이터에서 테스트를 실행할 때 사용합니다. `xcodebuildmcp simulator test`, XCTest, 전체 테스트, 특정 테스트, `-only-testing` 검증이 필요할 때 사용합니다."
---

# XcodeBuildMCP Simulator Test

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

XcodeBuildMCP CLI로 simulator 테스트를 실행하고, 테스트 성공 여부를 완료 기준으로 삼습니다.

## 전체 테스트

설정 파일이 있으면:

```bash
xcodebuildmcp simulator test
```

설정 파일이 없으면:

```bash
xcodebuildmcp simulator test \
  --scheme MyApp \
  --project-path ./MyApp.xcodeproj \
  --simulator-name "iPhone 17 Pro"
```

workspace 프로젝트:

```bash
xcodebuildmcp simulator test \
  --scheme MyApp \
  --workspace-path ./MyApp.xcworkspace \
  --simulator-name "iPhone 17 Pro"
```

## 특정 테스트

복잡한 옵션은 `--json`으로 넘깁니다.

```bash
xcodebuildmcp simulator test --json '{
  "projectPath": "./MyApp.xcodeproj",
  "scheme": "MyApp",
  "simulatorName": "iPhone 17 Pro",
  "progress": true,
  "extraArgs": ["-only-testing:MyAppTests"]
}'
```

workspace 프로젝트:

```bash
xcodebuildmcp simulator test --json '{
  "workspacePath": "./MyApp.xcworkspace",
  "scheme": "MyApp",
  "simulatorName": "iPhone 17 Pro",
  "progress": true,
  "extraArgs": ["-only-testing:MyAppTests"]
}'
```

## 출력 모드

- 사람이 직접 읽으면 기본 `text`를 사용합니다.
- agent/CI에서 테스트 진행을 실시간 처리하려면 `--output jsonl`을 사용합니다.
- 스크립트가 최종 결과만 파싱하면 `--output json`을 사용합니다.
- 원본 XCTest/xcodebuild 진단이 필요하면 실패 후 `--output raw`로 재실행합니다.

## 실패 처리

1. 실패한 테스트 identifier와 첫 관련 assertion/error를 보존합니다.
2. build 단계 실패와 test assertion 실패를 구분합니다.
3. 특정 테스트 재실행이 필요하면 `extraArgs`에 `-only-testing:<target-or-test>`를 넣어 범위를 좁힙니다.
4. 테스트가 전혀 발견되지 않으면 scheme/test plan 설정 문제로 보고하고 탐색 단계로 돌아갑니다.

## 완료 기준

- `xcodebuildmcp simulator test` 또는 같은 의미의 명시 플래그/JSON 명령이 exit 0으로 끝났을 때만 테스트 성공으로 보고합니다.
- 실행하지 않았으면 `검증 미실행. 완료 선언 불가.`라고 보고합니다.
- 일부 테스트만 실행했다면 전체 테스트 성공처럼 말하지 않고 실행 범위를 명시합니다.
