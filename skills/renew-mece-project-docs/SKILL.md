---
name: renew-mece-project-docs
description: "[execute] 여러 하위 프로젝트, 어댑터, 패키지, 도구, vendored capability를 가진 폴더의 README 계층을 MECE하게 갱신합니다. parent README는 summary-and-link index로 만들고, direct child README는 실제 manifest, build file, source entrypoint, test 근거로 상세 프로젝트 설명과 검증 방법을 써야 할 때 사용합니다."
---

# MECE 프로젝트 문서 갱신

## 최종 답변 우선 규칙

이 문서 아래에 고정 라벨, 표, JSON, 예시가 있어도 사용자에게 보이는 최종 답변은 이 규칙을 먼저 따른다.

- 결론, 판정, 변경사항을 첫 문장에 둔다.
- 기본 답변은 쉬운 한국어 2~4문장으로 끝낸다.
- 세부 근거, 명령, 파일 목록은 결과를 이해하거나 검증하는 데 꼭 필요할 때만 넣는다.
- 필수 출력 형식, JSON 계약, 사용자 요청 형식은 보존한다.
- 내부 정리용 라벨과 템플릿 문구는 그대로 노출하지 않는다.
- 불확실하면 추측하지 말고 확인해야 할 사실만 짧게 말한다.
- 사용자가 묻지 않은 다음 작업 추천은 넣지 않는다.

## 이 스킬을 쓰는 경우

- 하나의 폴더 아래에 여러 child project가 있고, parent README가 탐색 index 역할을 해야 할 때
- `adapters/`, `packages/`, `tools/`, `integrations/`, `plugins/` 같은 collection folder를 문서화할 때
- 각 direct child README가 무엇을 하는 프로젝트인지, 무엇을 하지 않는지, 어떻게 검증하는지 자세히 설명해야 할 때
- manifest, package file, source entrypoint, test와 README 설명을 맞춰야 할 때
- child project 간 역할 경계를 겹치지 않게 정리해야 할 때

## 이 스킬을 쓰면 안 되는 경우

- 저장소 전체를 처음부터 넓게 역공학해야 하는 경우
- release notes, changelog, migration note만 필요한 경우
- 문서가 아니라 코드 동작, 빌드 설정, 파일 삭제가 주요 작업인 경우
- child project 구성이 아직 확정되지 않아 설계나 제품 방향 판단이 먼저 필요한 경우

맞지 않는 요청이면 첫 문장에서 `renew-mece-project-docs` 범위가 아니라고 말하고 더 맞는 작업 lane만 짧게 덧붙입니다. 문서 갱신 중 코드 변경, 삭제, 빌드 시스템 전환이 필요해 보이면 문서 근거와 불일치만 기록하고 중지합니다.

## 입력

- 하나의 bounded parent folder
- direct child project로 볼 기준
- 선택적 source-of-truth manifest
- 선택적 검증 명령 또는 문서 QA 스크립트
- 사용자가 명시한 제외 범위

## 내부 정리 기준

최종 답변에는 아래 뜻만 짧게 담습니다:

- `Scope: ...`
- `Parent index: ...`
- `Child READMEs: ...`
- `Truth sources: ...`
- `Verification: ...`
- `Open unknowns: ...`

## 작업 순서

1. parent folder 범위를 고정합니다.
   - direct child directory를 child project 후보로 봅니다.
   - manifest가 direct child 경계를 다르게 정의하면 manifest를 우선합니다.
   - `.build`, `target`, `dist`, `build`, `node_modules`, cache, run artifact, generated output은 source authority로 보지 않습니다.
2. 문서 편집 전에 truth source를 읽습니다.
   - collection manifest: id, provider, path, runtime, required status, capability
   - package manifest: product, target, binary, script, feature flag
   - source entrypoint: 실제 API, CLI, server, adapter wiring
   - tests: 검증 가능한 동작과 실패 경계
   - existing README: 위 근거와 맞을 때만 신뢰
3. child project 목록을 MECE하게 분류합니다.
   - 모든 direct child는 정확히 하나의 역할 bucket에 들어갑니다.
   - 두 child가 비슷하면 runtime이 아니라 책임, 입력, 출력, 호출 주체, public surface 기준으로 경계를 씁니다.
   - external, vendored, reference, optional project는 숨기지 말고 그 상태를 명시합니다.
4. parent README를 summary-and-link index로 갱신합니다.
   - 첫 문단에 이 폴더가 무엇이고 어떤 파일이 source of truth인지 씁니다.
   - direct child만 요약하고 링크합니다.
   - 표에는 가능한 한 bucket, child link, runtime, required/optional, public surface, summary를 넣습니다.
   - 읽는 순서, ownership rule, boundary rule을 짧게 둡니다.
   - grandchild docs는 parent에서 중복 설명하지 않고 필요한 경우 policy note로만 언급합니다.
5. 각 direct child README를 상세 프로젝트 페이지로 갱신합니다.
   - host repo 안에서의 역할을 첫 문단에 씁니다.
   - manifest field가 있으면 id, provider, runtime, required status, capability를 표로 씁니다.
   - `What It Does`와 `What It Does Not Do`를 분리합니다.
   - local structure를 책임 단위로 설명합니다.
   - public API, CLI, binary, package target, integration point를 실제 코드 기준으로 씁니다.
   - verification command는 package manifest나 실제 CLI usage가 뒷받침할 때만 씁니다.
6. 문서 깊이를 통제합니다.
   - direct child README는 `docs/`, `Docs/`, `Sources/`, `Tests/`의 상세 문서로 링크할 수 있습니다.
   - parent README는 deeper docs의 내용을 복제하지 않습니다.
   - 존재하지 않거나 generated-only인 문서 링크는 실제 파일로 고치거나 링크 없이 사실만 씁니다.
7. 편집 후 검증합니다.
   - 모든 상대 Markdown 링크가 실제 파일이나 디렉터리로 해석되는지 확인합니다.
   - parent README의 child link coverage가 intended child project set과 같은지 확인합니다.
   - manifest id와 parent index의 child row가 맞는지 확인합니다.
   - 문서화한 명령이 manifest, package script, source entrypoint와 맞는지 확인합니다.
   - repo에 문서 QA 스크립트가 있으면 가장 좁은 범위로 실행합니다. 없으면 `rg`, `find`, manifest read, 작은 link check로 대체합니다.

## README 작성 규칙

child README는 맞을 때만 아래 형태를 씁니다. 적용되지 않는 section은 빼도 됩니다.

```markdown
# Project Name

현재 저장소가 이 프로젝트를 왜 가지고 있는지 설명하는 한 문단.

## Host Role

| Field | Value |
|---|---|
| Manifest id | `...` |
| Provider | `...` |
| Runtime mode | `...` |
| Required | yes/no |
| Capability | `...` |

## What It Does

## What It Does Not Do

## Package Surface

## Local Structure

## Primary Flow

## Verification
```

API, 명령, build step, ownership, runtime은 추측해서 쓰지 않습니다. code/config/test와 README가 다르면 code/config/test를 우선하고, 남은 불일치는 unknown으로 남깁니다.

## 검증

- `rg -n`으로 오래된 경로, 삭제된 script, 잘못된 runtime 이름이 남았는지 확인합니다.
- parent index에 direct child가 빠지거나 두 번 등장하지 않는지 확인합니다.
- child README가 목적, 경계, 구조, public surface, 검증 방법을 설명하는지 확인합니다.
- external/reference/vendored project는 일반 first-party project처럼 꾸미지 않았는지 확인합니다.
- generated/cache/dependency directory를 문서 근거로 삼지 않았는지 확인합니다.

## 원자성 원칙

- 이 스킬은 이 `SKILL.md`와 같은 폴더의 `references/`, `scripts/`, `assets/`만으로 이해되고 실행되어야 한다.
- sibling skill, 전역 context 파일, 외부 설치 스킬에 의존하지 않는다.
- 한 번에 이 스킬이 맡은 일 하나만 수행한다. 범위를 벗어나면 다른 스킬 이름을 짧게 말하고 중지한다.

## 품질 기준

- 출력량보다 명확성, 깊이, 건전한 판단, 오래가는 실질 기여를 봅니다.
- parent README는 prose dump가 아니라 navigation node처럼 동작해야 합니다.
- child README는 독자가 해당 프로젝트를 실행, 검증, 교체, 제외할 수 있을 정도로 상세해야 합니다.
- MECE는 표 형식이 아니라 coverage와 non-overlap이 증명될 때 성립합니다.
- 문서의 모든 명령과 링크는 현재 저장소에서 근거가 있어야 합니다.
- 중요한 unknown이 남아 있으면 꾸며 쓰지 말고 그대로 적습니다.
