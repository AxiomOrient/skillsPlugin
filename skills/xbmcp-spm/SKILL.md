---
name: xbmcp-spm
description: "[xbmcp] Swift Package를 빌드하거나 테스트할 때 사용합니다. `Package.swift` 기반 프로젝트에서 `xcodebuildmcp swift-package build`, `test`, `clean`을 실행해야 할 때 사용합니다."
---

# XcodeBuildMCP Swift Package

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

Swift Package를 Xcode project 생성 없이 `xcodebuildmcp swift-package` workflow로 검증합니다.

## 기본 명령

```bash
xcodebuildmcp swift-package build
xcodebuildmcp swift-package test
xcodebuildmcp swift-package clean
```

코드 변경 완료 근거가 필요하면 기본값은 `test`입니다. 테스트가 없는 package라면 `build` 성공만 보고하고 테스트 부재를 명시합니다.

## 설정 파일

필요한 경우 프로젝트 루트에 최소 설정을 둡니다.

```yaml
schemaVersion: 1

sessionDefaults:
  configuration: "Debug"

sentryDisabled: true
debug: false
```

## 출력 모드

- 사람이 직접 읽으면 기본 `text`를 사용합니다.
- agent/CI에서 진행 이벤트가 필요하면 `--output jsonl`을 사용합니다.
- 스크립트가 최종 결과만 파싱하면 `--output json`을 사용합니다.
- SwiftPM 또는 compiler 원본 로그가 필요하면 실패 후 `--output raw`로 재실행합니다.

## 실패 처리

1. `Package.swift`가 없으면 이 스킬을 사용하지 말고 Xcode project/workspace 탐색으로 전환합니다.
2. build 실패와 test assertion 실패를 구분합니다.
3. 플랫폼 조건부 실패는 실행 환경, destination, package manifest 조건을 함께 보고합니다.
4. dependency resolution 문제가 있으면 원본 오류와 재현 명령을 남깁니다.

## 완료 기준

- `xcodebuildmcp swift-package test`가 exit 0이면 package 테스트 검증 성공으로 보고합니다.
- 테스트가 없어 `xcodebuildmcp swift-package build`만 실행했다면 빌드 검증 성공이라고만 보고합니다.
- 실행하지 않았으면 `검증 미실행. 완료 선언 불가.`라고 보고합니다.
