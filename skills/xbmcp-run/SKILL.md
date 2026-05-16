---
name: xbmcp-run
description: "[xbmcp] iOS 앱을 시뮬레이터에서 실행해 볼 때 사용합니다. `xcodebuildmcp simulator build-and-run`으로 build, install, launch를 한 번에 확인해야 할 때 사용합니다."
---

# XcodeBuildMCP Simulator Run

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

`build-and-run`으로 빌드 성공뿐 아니라 simulator 설치와 앱 launch까지 확인합니다.

## 명령 선택

설정 파일이 있으면:

```bash
xcodebuildmcp simulator build-and-run
```

설정 파일이 없으면:

```bash
xcodebuildmcp simulator build-and-run \
  --scheme MyApp \
  --project-path ./MyApp.xcodeproj \
  --simulator-name "iPhone 17 Pro"
```

workspace 프로젝트:

```bash
xcodebuildmcp simulator build-and-run \
  --scheme MyApp \
  --workspace-path ./MyApp.xcworkspace \
  --simulator-name "iPhone 17 Pro"
```

## 출력 모드

- 일반 확인은 기본 `text`를 사용합니다.
- agent가 긴 실행 흐름의 live progress를 읽어야 하면 `--output jsonl`을 사용합니다.
- launch 실패 원인이 불명확하면 같은 입력으로 `--output raw`를 붙여 재실행합니다.

## 실패 처리

1. build 실패는 먼저 컴파일 오류로 처리합니다. run 단계 추측으로 넘어가지 않습니다.
2. install/launch/log capture 실패가 daemon과 관련되어 보이면 `xbmcp-daemon` 범위로 상태와 로그를 확인합니다.
3. simulator 이름이나 boot 상태가 의심되면 `xcodebuildmcp simulator list`로 현재 상태를 확인합니다.
4. launch 로그 경로가 출력되면 최종 보고에 포함합니다.

## 완료 기준

- `xcodebuildmcp simulator build-and-run` 또는 같은 의미의 명시 플래그 명령이 exit 0으로 끝났을 때만 실행 검증 성공으로 보고합니다.
- 실행하지 않았으면 `검증 미실행. 완료 선언 불가.`라고 보고합니다.
- 이 스킬은 UI 조작 성공을 증명하지 않습니다. 화면 상호작용이 필요하면 별도 UI automation 또는 simulator 조작 검증을 수행합니다.
