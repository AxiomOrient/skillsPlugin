---
name: xbmcp-build
description: "[xbmcp] iOS 시뮬레이터 빌드를 확인할 때 사용합니다. 코드 변경 후 `xcodebuildmcp simulator build`로 컴파일 성공을 증명해야 할 때 사용합니다."
---

# XcodeBuildMCP Simulator Build

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

XcodeBuildMCP CLI로 iOS simulator build를 실행하고, 성공한 명령만 완료 근거로 사용합니다.

## 명령 선택

`.xcodebuildmcp/config.yaml`에 `sessionDefaults`가 있으면 플래그 없이 실행합니다.

```bash
xcodebuildmcp simulator build
```

설정 파일이 없으면 명시적으로 넘깁니다.

```bash
xcodebuildmcp simulator build \
  --scheme MyApp \
  --project-path ./MyApp.xcodeproj \
  --simulator-name "iPhone 17 Pro"
```

workspace 프로젝트:

```bash
xcodebuildmcp simulator build \
  --scheme MyApp \
  --workspace-path ./MyApp.xcworkspace \
  --simulator-name "iPhone 17 Pro"
```

## 출력 모드

- 사람이 읽고 있으면 기본 `text`를 사용합니다.
- agent/CI에서 진행 상태를 읽어야 하면 `--output jsonl`을 사용합니다.
- 최종 구조화 결과만 필요하면 `--output json`을 사용합니다.
- 원본 `xcodebuild` 진단이 필요할 때만 실패 후 `--output raw`로 재실행합니다.

## 실패 처리

1. 첫 실패에서는 핵심 에러와 실패한 명령을 보존합니다.
2. 출력이 가공되어 원인을 알기 어렵다면 같은 입력으로 `--output raw`를 붙여 재실행합니다.
3. scheme, project/workspace path, simulator name이 의심되면 build를 반복하지 말고 `xbmcp-find` 범위로 되돌립니다.
4. 설치나 환경 문제가 의심되면 `xcodebuildmcp doctor`를 실행합니다.

## 완료 기준

- `xcodebuildmcp simulator build` 또는 같은 의미의 명시 플래그 명령이 exit 0으로 끝났을 때만 빌드 검증 성공으로 보고합니다.
- 실행하지 않았으면 `검증 미실행. 완료 선언 불가.`라고 보고합니다.
- 빌드 성공은 런타임 동작이나 테스트 성공을 증명하지 않습니다. 필요한 경우 `xbmcp-run` 또는 `xbmcp-test`를 별도로 사용합니다.
