---
name: simplify
description: "[simplify] 동작을 바꾸지 않고 코드를 더 단순하게 만듭니다. 중복, 약한 래퍼, 불필요한 추상화, 숨은 복잡도를 한 번에 하나씩 줄일 때 사용합니다."
---

# 단순화 실행

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

## 이 스킬을 쓰는 경우
- 사용자가 simplify, dedupe, clean up, reduce noise, remove unnecessary complexity를 요구할 때
- 원하는 변경이 동작 보존형이고 아키텍처 재설계보다 작은 범위일 때
- 중복 helper, 약한 wrapper, TOCTOU 정리, 오래된 주석, 반복 codec 생성, 로그와 실제 동작 불일치 정리가 주요 이득일 때

## 이 스킬을 쓰면 안 되는 경우
- 핵심 작업이 새 기능 개발일 때
- 먼저 원인 분석이 필요한 상태일 때
- 작업 중심이 아키텍처 탐색이나 패키지 경계 재설계일 때
- 승인된 단순화 대상 없이 넓은 범위 리뷰만 요청됐을 때

## 맞지 않는 요청 처리

작고 제한된 단순화 작업이 아니라면 바로 멈춥니다.

- 아키텍처 경계 작업이면:
  - 범위 불일치: architecture realignment requested
  - 더 맞는 스킬이나 조건: analyze-architecture-integrity 또는 `execute-architecture-realignment`
- 버그 진단이면:
  - 범위 불일치: root-cause work requested
  - 더 맞는 스킬이나 조건: analyze-root-cause
- 일반 구현이면:
  - 범위 불일치: feature or bug implementation requested
  - 더 맞는 스킬이나 조건: execute-bounded-change 또는 관련 실행 스킬

맞지 않는 요청이면 아래처럼 짧게 설명합니다:
- 왜 이 스킬이 맞지 않는지 한두 문장으로 말합니다.
- 더 맞는 스킬이나 먼저 필요한 조건이 있으면 한 줄만 덧붙입니다.

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Target: ...`
- `Lens findings: ...`
- `Chosen slice: ...`
- `Verify: ...`
- `Deferred: ...`

## 핵심 렌즈

편집 전에 항상 같은 세 렌즈를 보고, 최종 합치기 전까지는 결과를 섞지 않습니다.

1. `reuse`
- 반복되는 decode, parse, normalize, map, cache-key, compatibility conversion 로직
- 반복되는 error 생성이나 작은 helper 로직
- 공통 경로에서 반복되는 serializer, parser, encoder, decoder, formatter, regex, path-builder 생성

2. `quality`
- 오래된 "bug fix"류 주석이나 시점성 주석
- 뻔한 코드를 설명하거나 enum/case 이름만 다시 말하는 주석
- 비어 있거나 약한 catch block
- 실제 소유권을 숨기지 못하는 얇은 wrapper
- 실제 제어 흐름과 wording이 맞지 않는 log, warning, message

3. `efficiency`
- `exists` 다음 `read/remove/create` 같은 TOCTOU 패턴
- 하나의 안전한 경로로 합칠 수 있는 반복 작업
- hot path나 common path에서 피할 수 있는 branch나 wrapper
- 의미를 바꾸지 않고 인스턴스 재사용으로 줄일 수 있는 반복 객체 생성

## 오토리서치와 서브 에이전트

사용자가 서브 에이전트 활용, 오토리서치, 깊은 후보 탐색을 요구했거나, 범위가 넓어서 메인 컨텍스트에 검색 결과가 과도하게 쌓일 때만 서브 에이전트를 씁니다. 빠르고 좁은 단일 파일 수정이면 로컬에서 세 렌즈를 직접 실행합니다.

오토리서치를 쓰면 먼저 [references/auto-research.md](references/auto-research.md)를 읽고 그 프롬프트 계약을 그대로 넘깁니다. 목적은 후보를 많이 모으는 것이 아니라, 증거가 충분한 동작 보존형 첫 슬라이스 하나로 수렴하는 것입니다.

서브 에이전트는 후보 조사만 담당합니다. 파일 수정, 최종 슬라이스 선택, proof 실행, 여러 후보 일괄 적용은 메인 흐름의 책임입니다.

서브 에이전트를 쓰기 전에 메인 흐름에서 하나의 `scope manifest`를 만듭니다.
- repo root 또는 명시된 path set
- 포함할 파일/디렉터리
- 제외할 표면: vendor, generated, build output, resource bundle, 외부 dependency, architecture move가 필요한 패키지 경계
- 관련 manifest와 proof surface: 예를 들어 SwiftPM은 `Package.swift`의 target/testTarget 매핑, Node는 `package.json` scripts, Python은 `pyproject.toml`/test config
- 허용된 읽기 예산과 금지 사항: read-only, no edits, no deletes, no broad redesign

병렬 조사는 아래처럼 쪼갭니다.
- `reuse reviewer`: 반복 codec, parser, formatter, mapper, regex, path builder, compatibility conversion만 찾습니다.
- `quality reviewer`: 오래된 주석, 약한 catch, 로그/동작 불일치, 의미 없는 wrapper만 찾습니다.
- `efficiency reviewer`: TOCTOU, 반복 객체 생성, common path의 불필요한 branch나 wrapper만 찾습니다.
- `proof mapper`: 변경 후보의 owner target, 가장 좁은 test/build/static proof, proof가 약한 후보를 찾습니다.

각 reviewer 출력은 후보마다 같은 형식이어야 합니다.
- candidate: 한 문장
- evidence: 파일 경로와 줄 번호
- lens: `reuse`, `quality`, `efficiency`, 또는 `proof`
- behavior-preserving rationale: 왜 동작 보존형인지
- risk: 낮음/중간/높음과 이유
- proof suggestion: 가장 좁은 정직한 명령
- defer reason: 이번 패스에서 고르지 말아야 할 이유가 있으면 명시

fan-in은 메인 흐름에서만 합니다. reviewer 결과를 중복 제거하고, 같은 코드 경로를 가리키는 cross-lens 후보는 하나의 후보로 합친 뒤, 현재 패스에서는 정확히 하나만 선택합니다. 나머지는 `Deferred`로 남기고 다음 패스에서 다시 우선순위화합니다.

## 작업 순서

1. 먼저 하나의 제한된 범위를 고정합니다.
2. 그 범위를 이해하는 데 필요한 파일만 읽습니다.
3. manifest, target/test mapping, repo-local helper, 기존 proof 명령을 먼저 확인합니다.
4. 세 렌즈를 실행합니다.
   - `reuse`
   - `quality`
   - `efficiency`
5. 범위가 넓고 delegation이 허용되면 위 `오토리서치와 서브 에이전트` 계약대로 read-only reviewer를 병렬 실행합니다.
6. 아래 기준으로 finding 우선순위를 매깁니다.
   - 동작 위험도
   - 단순화 효과
   - 증거 강도
7. 현재 패스에서 단순화 슬라이스는 정확히 하나만 고릅니다.
8. 새 추상화 추가보다 삭제, 병합, inline, extraction, 직접적인 error handling, 안전한 object 재사용을 우선합니다.
9. 바뀐 표면은 가장 값싼 정직한 proof부터 검증합니다.
10. 표면이 공유될 때만 검증 범위를 넓힙니다.
11. 검증이 끝나면 남은 finding을 다시 우선순위화하고, 아직 동작 보존형이며 proof가 충분한 후보가 남아 있으면 같은 절차를 다음 패스로 반복합니다.

## 단순화 규칙

- 한 번의 패스에는 하나의 분명한 단순화 목적만 둡니다.
- 전체 실행에서는 여러 패스를 돌릴 수 있지만, 각 패스는 독립적으로 선택, 수정, 검증을 끝낸 뒤 다음 패스로 넘어갑니다.
- 아주 작은 seam이 강제하지 않는 한 duplication cleanup, naming cleanup, architecture move를 한 번에 묶지 않습니다.
- 새 protocol보다 구체적인 local helper를 우선합니다.
- 추측성 pre-check보다 직접 effect를 실행하고 좁게 error handling하는 방식을 우선합니다.
- 과거 이력이나 구현 잡설만 설명하는 오래된 주석은 지웁니다.
- 주석은 invariant, compatibility constraint, non-obvious boundary를 지켜 줄 때만 남깁니다.
- 같은 코드가 두 번 보여도 ownership이 다르면 미관만 위해 강제로 재사용하지 않습니다.
- 반복 객체가 stateful, non-thread-safe, configuration-sensitive라면 가볍게 cache/share하지 않습니다.
- "단순화"가 중요한 effect boundary를 가리게 되면 멈춥니다.

## 언어 공통 지침

- "codec"는 JSON, XML, YAML, protobuf, serializer, decoder, regex parser, URL builder, query builder, mapper, formatter까지 넓게 봅니다.
- TOCTOU는 filesystem, database, cache, network resource existence check, 그리고 mutable state에서의 모든 "check then act" 패턴까지 넓게 봅니다.
- 약한 주석은 historical note, self-evident what-comment, mismatched operational comment까지 넓게 봅니다.
- 검증은 저장소의 기본 proof 도구를 쓰고, 스킬 본문이 특정 언어의 build 명령으로 기울지 않게 합니다.

## 저장소별 범위 고정

후보를 고르기 전에 기존 repo-local 유틸과 proof surface를 먼저 찾습니다. 이미 있는 serializer, parser, path helper, test helper를 재사용할 수 있는지 확인하되, 출력 포맷, key strategy, newline, error contract가 다르면 자동으로 바꾸지 않습니다.

SwiftPM 저장소에서는 `Package.swift`의 target/testTarget 매핑을 먼저 읽고, 변경 파일이 속한 target과 직접 관련된 testTarget 또는 `swift build --target <target>`을 proof 후보로 둡니다. 파일시스템, persistence, rollback, missing-file nil 계약을 건드리는 후보는 path-specific 테스트가 없으면 선택하지 않습니다.

리소스 번들, vendor 디렉터리, generated output, build artifact, 외부 dependency 안의 반복 코드는 기본 후보에서 제외합니다. 사용자가 그 표면을 명시했거나 repo가 그 코드를 직접 소유한다는 증거가 있을 때만 다룹니다.

## 검증

- 검증은 필수입니다.
- 이미 현재 패스에서 선택한 슬라이스를 덮는 기존 proof 명령이 있으면 먼저 씁니다.
- 동작 보존형 단순화에서는 아래 순서를 우선합니다.
  - 집중된 unit test
  - 집중된 integration test
  - compile 또는 build proof
  - 실제 경계 검사가 그것이라면 lint 또는 static proof
- 변경이 filesystem, persistence, runtime timing behavior를 건드리면 더 넓은 suite 전에 path-specific proof 하나를 추가합니다.
- 여러 패스를 수행할 때는 각 패스마다 가장 싼 정직한 proof를 먼저 통과시키고, 마지막에 누적 영향이 있는 표면만 묶어서 한 번 더 검증합니다.
- 검증을 실행할 수 없으면 완료처럼 말하지 말고, 실행하지 못한 이유와 다음으로 가장 정직한 확인 방법만 남깁니다.

## 멈추는 조건

- 다음 단순화가 behavior나 policy를 바꾸게 될 때
- 남은 정리가 대부분 스타일 churn일 때
- 더 진행하려면 아키텍처 판단이 필요할 때
- simplification risk보다 proof가 더 약할 때
- 남은 후보가 있어도 각 후보의 증거가 약하거나 검증 비용이 과도하면 그 지점에서 멈추고 보류 이유를 남깁니다.

## 참고 문서

- `references/lenses.md`
- `references/checklist.md`
- `references/eval.md`
- `references/research-loop.md`
- `references/auto-research.md`
