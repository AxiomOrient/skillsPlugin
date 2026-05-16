---
name: analyze-architecture-integrity
description: "[analyze] 정해진 코드 범위에서 모듈 경계, 이름, 책임, 의존 방향이 흐려졌는지 근거로 확인합니다. 구조가 유지보수와 확장을 막는지 먼저 판단해야 할 때 사용합니다."
---

# 아키텍처 건전성 분석

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

## 맞지 않는 요청 처리

요청이 구현, 버그 수정, API 계약 설계, 또는 구조 질문이 없는 일반 리뷰라면 바로 멈춥니다.

- 구현 요청이면:
  - 범위 불일치: implementation requested
  - 더 맞는 스킬이나 조건: execute-architecture-realignment 또는 관련 실행 스킬
- 호출자 대상 API 계약 설계만 하는 요청이면:
  - 범위 불일치: caller-visible contract design
  - 더 맞는 스킬이나 조건: design-api-contract
- 일반 품질 리뷰면:
  - 범위 불일치: broad quality review
  - 더 맞는 스킬이나 조건: review-quality-check
- 저장소 전체 reverse engineering이나 brownfield 문서화 요청이면:
  - 범위 불일치: whole-repo brownfield analysis
  - 더 맞는 스킬이나 조건: analyze-repo-brownfield
## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:
- `Verdict: healthy | drifted | critical | inconclusive`
- `Score: .../14`
- `Boundary map: ...`
- `Boundary failures: ...`
- `Naming failures: ...`
- `Extension blockers: ...`
- `Smallest redesign slice: ...`
- `Recommended execute lane: ...`
- `Evidence: ...`
- `Next proof: ...`

## 작업 순서

1. 먼저 분석 범위와 정확한 구조 질문을 고정합니다.
2. 구조 주장 전에 manifest, 모듈 또는 패키지 레이아웃, import, 공개 진입점, 그리고 소량의 소스를 읽습니다.
   - 기본 증거 예산은 구체적인 파일이나 심볼 3개에서 6개입니다.
   - 구현 비중이 큰 파일보다 문서, manifest, 패키지 문서, import 경계, 공개 진입점을 먼저 봅니다.
   - README나 긴 설명 문서는 의도한 경계나 공개 구조를 정의할 때만 읽습니다. 설명성 문서가 증거 예산 대부분을 먹지 않게 합니다.
   - 경계 질문이 특별히 요구하지 않는 한 build, test, compile, `go list`, 패키지 설치, 전체 인덱스 명령은 실행하지 않습니다.
   - 아래 경로는 기본적으로 무시합니다.
     - `.git`
     - `node_modules`
     - `dist`
     - `build`
     - `.next`
     - `.svelte-kit`
     - `target`
     - `vendor`
     - `__pycache__`
     - `.venv`
     - `DerivedData`
     - `generated`
     단, 구조 질문이 패키징, 생성 코드 소유권, 빌드 표면 자체를 다룰 때만 예외로 봅니다.
3. 간결한 경계 지도를 만듭니다.
   - owners
   - incoming dependencies
   - outgoing dependencies
   - effect boundaries
   - public seams
4. [references/scorecard.md](references/scorecard.md) 기준으로 점수를 매깁니다.
5. 핵심 문제만 분류합니다.
   - ownership drift
   - dependency inversion failure
   - naming dishonesty
   - boundary leak
   - extension blockage
   - over-abstraction
   - shared-state or effect pollution
6. 의도된 결합과 우발적 오염을 구분합니다.
7. 점수를 실제로 올릴 수 있는 가장 작은 재설계 단위를 제안합니다.
8. 다음 실행 레인을 명확히 추천합니다.
   - 이름, 패키지, 모듈, 레이어, 의존 방향 정리면 `execute-architecture-realignment`
   - 이미 정직한 경계 안에서 언어 수준 재구성이 중심이면 언어별 `execute-refactor-*`
9. 구현으로 넘어가기 전에 멈춥니다.

## 분석 규칙

- 추측하지 않습니다. 패키지 소유권, 런타임 방향, 공개 표면 의도가 증거로 뒷받침되지 않으면 `inconclusive`를 반환합니다.
- 미적 취향보다 저장소 사실을 우선합니다.
- 사용자가 지정한 범위를 문자 그대로 존중합니다. 상위 레이아웃만 보라고 했으면, 그 증거가 부족하다는 설명 없이 내부 구현으로 깊게 들어가지 않습니다.
- 큰 파일이라고 해서 곧바로 나쁜 경계라고 보지 않습니다. 여전히 하나의 지배적인 변경 이유가 있으면 그 자체로는 문제가 아닙니다.
- 추상화 수를 높게 평가하지 않습니다. 정직한 소유권, 명확한 방향, 쉬운 확장을 더 높게 평가합니다.
- 지배적인 실패는 최대 두 개까지만 말합니다. 범위 전체가 정말 망가진 경우만 예외입니다.
- 이름 드리프트가 핵심이면 다음 중 무엇인지 밝힙니다.
  - misleading package or module name
  - catch-all package
  - layer name that hides responsibility
  - public type or folder that encodes mechanism instead of role

## 증거 규칙

- 다음 증거를 우선합니다.
  - package 또는 module manifest
  - import와 dependency edge
  - public constructor, interface, export
  - 경계를 증명하거나 흐리는 테스트
  - shell, HTTP, DB, filesystem, queue, LLM call site
- 동적 탐색 명령보다 읽기 전용 파일 확인을 우선합니다.
- 검토 대상 경계가 아닌 한 runtime artifact, vendor, generated, cache, build-output 트리는 일반 증거에서 제외합니다.
- `Evidence`에는 정확한 파일이나 심볼을 적습니다.
- 어떤 주장에 저장소 대부분을 읽어야 한다면, 조용히 범위를 넓히지 말고 부족한 증거를 그대로 반환합니다.

## 참고 문서

- [references/scorecard.md](references/scorecard.md)
- [references/naming-guidelines.md](references/naming-guidelines.md) 이름 드리프트가 핵심일 때
- [references/eval.md](references/eval.md)
- [references/research-loop.md](references/research-loop.md)
