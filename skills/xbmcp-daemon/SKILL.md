---
name: xbmcp-daemon
description: "[xbmcp] XcodeBuildMCP 데몬 상태와 로그를 확인할 때 사용합니다. log capture, video recording, LLDB/debugging, build-and-run 로그 문제가 의심될 때 사용합니다."
---

# XcodeBuildMCP Daemon

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

stateful XcodeBuildMCP tool이 실패할 때 per-workspace daemon 상태를 확인하고 원래 명령을 다시 검증합니다.

일반 build/test 실패에는 먼저 build/test 오류를 봅니다. daemon은 log capture, video recording, LLDB/debugging, launch/log 계열 문제가 의심될 때만 봅니다.

## 점검 명령

```bash
xcodebuildmcp daemon status
xcodebuildmcp daemon list
xcodebuildmcp daemon logs
xcodebuildmcp doctor
```

수동 관리가 필요할 때:

```bash
xcodebuildmcp daemon restart
xcodebuildmcp daemon stop
```

foreground 로그가 필요할 때:

```bash
xcodebuildmcp daemon start --foreground
```

## 처리 순서

1. 실패한 원래 명령과 에러를 먼저 기록합니다.
2. `xcodebuildmcp daemon status`와 `xcodebuildmcp daemon logs`를 확인합니다.
3. daemon crash, stale socket, startup timeout, log capture 실패가 보이면 `xcodebuildmcp daemon restart`를 실행합니다.
4. 같은 원래 명령을 다시 실행해 문제가 사라졌는지 확인합니다.
5. socket permission 문제가 명확하면 `~/.xcodebuildmcp` 권한을 확인하고 필요한 최소 권한 변경만 적용합니다.

```bash
chmod 700 ~/.xcodebuildmcp
chmod -R 700 ~/.xcodebuildmcp/daemons
```

## 운영 규칙

- daemon은 필요할 때 자동 시작되고 idle 후 종료될 수 있으므로, daemon이 떠 있지 않다는 사실만으로 오류라고 단정하지 않습니다.
- `.xcodebuildmcp/config.yaml`이 있으면 workspace identity는 그 프로젝트 위치와 연결될 수 있습니다. 다른 디렉터리에서 daemon을 확인하고 있지 않은지 점검합니다.
- daemon 재시작만으로 작업 완료를 선언하지 않습니다. 반드시 실패했던 build/run/test/debug/log 명령을 다시 실행합니다.
- 재실행하지 않았으면 `검증 미실행. 완료 선언 불가.`라고 보고합니다.
