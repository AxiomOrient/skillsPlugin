# Goal-Based Swift Refactor Prompt

Use this prompt when the user wants a `/goal`-driven cleanup loop for a Swift repository.

```text
/goal 이 Swift 프로젝트를 동작 보존형으로 반복 리팩터링한다. 거대 오브젝트는 실제 책임 경계가 있을 때만 분리하고, 파일이 큰 편이 더 명확하면 유지한다. simplify 렌즈(reuse/quality/efficiency)와 Swift 렌즈(value/isolation/boundary)를 사용해 한 번에 하나의 슬라이스만 수정한다. 각 슬라이스마다 Goal, Non-goals, Done when, Verification을 고정하고 좁은 테스트 후 전체 테스트로 검증한다. 검증이 약하거나 남은 작업이 스타일성 churn이면 멈춘다.
```

## Candidate Report

For each candidate, write:

- File or type
- Evidence
- Proposed slice
- Why it preserves behavior
- Narrow verification
- Full verification
- Reason to defer, if deferred

## Slice Header

Use this before editing:

```text
Goal:
Non-goals:
Done when:
Verification:
```

## Good Slices

- Extract a small value type from repeated parameter groups when it clarifies ownership.
- Move a public facade into an extension file when it separates public API from core mechanics.
- Fold duplicated conversion logic into a private helper.
- Reduce unnecessary visibility.
- Remove stale comments or misleading names after tests already protect the behavior.

## Bad Slices

- Split a cohesive algorithm only because the file is long.
- Add protocols without a second implementation or testing need.
- Change behavior while claiming cleanup.
- Broaden public API to make a refactor easier.
- Keep looping after the remaining work is cosmetic churn.
