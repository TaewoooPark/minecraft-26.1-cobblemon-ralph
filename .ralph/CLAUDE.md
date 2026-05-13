# Minecraft Challenge — Ralph Loop Context

> 이 파일은 매 Ralph 반복에서 자동 로드되는 영속 컨텍스트다.
> 임무·파일 맵·완료 조건만 담는다. 한 번의 반복에서 할 행동은 `PROMPT.md`에, 불가침 규칙은 `ralph-rule.md`에 있다.

---

## Mission (Phase 3 — Strict Implementation, activated 2026-05-12)

[question.md](../question.md)의 **Minecraft Challenge**를 **명세가 아니라 동작하는 산출물**로 실현한다.

**Phase 1 (완료, iter#1~47)**: 솔루션 공간 망라적 매핑.
**Phase 2 (완료, iter#48~63)**: P01 strict 경로의 구현 직전까지의 명세 (`playbook/00~07 + README`).
**Phase 3 (현재)**: P01 strict 경로의 **실제 구현·빌드·실행·측정·녹화·패키징**.

Phase 3의 단일 진실은 [`question.md` §4 Path A — 26.1 strict](../question.md)다. 우회 금지:

```
Minecraft 26.1.x · Fabric · VulkanMod 26.1.2-0.6.5 · Beryl 26.1.2-0.1.3-alpha+1
Cobblemon (26.1.x self-port) · Label fix (source patch 우선)
Target: M-chip Mac · Cobblemon 5마리 + shader ON · 평균 ≥ 60 FPS
```

`1.21.11`·`1.21.1`·`1.20.1`로의 강등은 Phase 3에서 **최종 답으로 인정되지 않는다**. fallback은 비교·분석 자료로만 남긴다.

각 반복은 **단 하나의 원자적 진전(atomic step)**만 수행한다. Ralph 루프의 자기참조 메커니즘은 누적된 파일 상태(`state/impl-progress.md`)로 작동한다.

---

## File Map

| 경로 | 역할 | 변경 가능 여부 |
|---|---|---|
| `question.md` | 원본 문제 (canonical) | **읽기 전용** |
| `.ralph/CLAUDE.md` | 본 파일. 영속 컨텍스트 | 메타 정의 변경 시에만 |
| `.ralph/PROMPT.md` | 매 반복 실행 프롬프트 | 프롬프트 튜닝 시에만 |
| `.ralph/ralph-rule.md` | 불가침 반복 규칙 | 메타 정의 변경 시에만 |
| `state/coverage.md` | 전체 진행 원장(append-only) | **매 반복 1줄 추가** |
| `state/impl-progress.md` | **Phase 3 구현 원장** — checkpoints/B###/M###/PT###/F###/iter log | **매 반복 1행 이상 갱신** |
| `state/challenges.md` | 핵심 챌린지 인덱스 | Phase 1 종료 — 변경 거의 없음 |
| `state/dimensions.md` | 솔루션 공간 축 정의 | Phase 1 종료 — 변경 거의 없음 |
| `state/solutions.md` | 경로 카탈로그(인덱스) | Phase 1 종료 — 변경 거의 없음 |
| `state/verification.md` | 사실 검증 원장(append-only) | 신규 외부 사실 확인 시 |
| `state/synthesis.md` | 최종 합성 보고서(running) | Phase 1 종료, Open Questions 갱신만 |
| `challenges/Cn-*.md` | 챌린지 상세 1개당 1파일 | 신규 추가만 |
| `solutions/Pnn-*.md` | 솔루션 경로 상세 1개당 1파일 | 신규 추가만 |
| `verification/Vnn-*.md` | 검증 작업의 상세 노트 | 신규 추가만 |
| `playbook/NN-*.md` | Phase 2 구현 명세 (참조 전용) | Phase 3에서 변경 금지 (오류 발견 시 errata 표로만 추가) |
| `impl/` | **Phase 3 산출물 루트** — fork 체크아웃·패치·빌드 로그·jar | 매 반복 ≤1 신규 파일 |
| `impl/cobblemon-port/` | Cobblemon 26.1.x 포팅 작업트리 (git 서브모듈 또는 clone) | 동일 |
| `impl/build-logs/B###.log` | 빌드 시도별 raw 로그 | 신규 추가만 |
| `impl/patches/PT###-*.patch` | 적용된 소스 패치 unified diff | 신규 추가만 |
| `impl/measurements/M###.csv` | FPS 측정 raw 데이터 | 신규 추가만 |
| `impl/screenshots/` | 라벨 before/after 등 시각 증거 | 신규 추가만 |
| `impl/demo/demo.mp4` | 최종 데모 영상 | 단일 파일 |
| `impl/artifacts/` | 제출 패키지 (modlist, sha512, fps-results.csv, report.md 등) | playbook/07 §4 8종 |

---

## Completion Criteria (모두 만족 시 `<promise>` 발행)

### Phase 1 (✅ iter#47 완료, R11 audit·V28/V29 갱신 반영)
1. **C1**. `state/challenges.md` ≥ 6 챌린지(각 detail). ✅
2. **C2**. `state/dimensions.md`의 5축 채움. ✅
3. **C3**. `state/solutions.md` ≥ 12 경로. ✅
4. **C4**. `state/verification.md` 전 항목 마감(V01~V29). ✅
5. **C5**. `state/synthesis.md` 순위 ≥ 3 추천 + 트레이드오프 + 미해결 질문 + 24h 타임라인. ✅

### Phase 2 (✅ iter#63 완료)
6. **C6**. `playbook/00~06` 7파일 존재. ✅
7. **C7**. `playbook/07-acceptance.md` 시나리오 매트릭스. ✅
8. **C8**. `playbook/README.md` index + 24h budget. ✅

### Phase 3 (현재 목표 — Strict Implementation)
9. **C9 — Tooling & Baseline**. `state/impl-progress.md`의 **H0 · H1 · H2** 모두 `PASS`로 마감 + 각 단계의 증거 로그(B### or M###) 존재.
10. **C10 — Cobblemon 26.1.x Port Compile Clean**. **H3 · H4 · H5** 모두 `PASS`. `impl/cobblemon-port/` 작업트리 존재, `B###.log`에 exit 0 빌드 ≥1건, 산출 jar 경로 기재.
11. **C11 — Cobblemon Runtime Pass**. **H6 · H7 · H8** 모두 `PASS`. 메인 메뉴 도달 스크린샷, Pokémon 1마리 이상 spawn 스크린샷, 라벨 before/after 스크린샷이 `impl/screenshots/`에 존재. label patch는 `impl/patches/PT###-label-*.patch`로 분리 기록.
12. **C12 — Performance Targets**. **H9 · H10 · H11** 모두 `PASS`. `impl/measurements/`에 T1 ≥75, T2 ≥60, T3 ≥45 평균 FPS 입증 데이터(각 시나리오 3회 평균) + 1% low 기록.
13. **C13 — Demo Recording**. **H13** `PASS`. `impl/demo/demo.mp4` 존재, 60s, T2 시나리오 + 라벨 before/after 포함.
14. **C14 — Artifact Packaging**. **H14** `PASS`. `impl/artifacts/`에 `playbook/07-acceptance.md §4`가 요구하는 8종 모두 존재:
    `modlist.txt`, `shasum-512.txt`, `fps-results.csv`, `demo.mp4`(symlink 또는 copy), `screenshots/label-before-after/`, `cobblemon-26.1-port.diff` 또는 fork URL, `label-fix.patch` 또는 `label-fix-mixin/`, `report.md`.
15. **C15 — Self-Audit Pass**. **H15** `PASS`. `report.md`가 다음을 명시:
    - 사용한 MC/Fabric/VulkanMod/Beryl/Cobblemon 정확 버전 + SHA512
    - Cobblemon 26.1 포팅 범위(변경 모듈·매핑 채널)
    - label fix 방식(source patch / mixin)
    - FPS 측정 조건(좌표·동시 엔티티·날씨)
    - non-negotiable premise 우회 0건 자가 진술

모두 참 → 응답 마지막에 `<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>` 출력.

> **Note**: Phase 2의 promise tag(`COMPLETE-SOLUTION-DELIVERABLE`)는 유지하되 트리거 조건이 C1~C15 전체로 확장되었다. Phase 3 시작 시점에서는 C9~C15가 모두 `TODO`이므로 promise는 자동으로 미발행 상태가 된다. iter#61 / iter#64 발행분은 Phase 2 마감 표지로만 의미가 있으며, Phase 3 활성 이후 동일 태그의 재발행은 **C9~C15가 모두 PASS일 때**에 한한다.

---

## Out of Scope (이 루프에서 하지 않을 일)

- `question.md` 수정
- non-negotiable premise 우회 (버전 강등을 최종 답으로 채택)
- 1회 반복에서 2개 이상의 **신규 파일** 생성 (R1 위반)
- 출처 없는 단정적 사실 주장 (R4 위반)
- 같은 `(코드 상태, gradle args)` 빌드 재실행 (R13 위반)
- 같은 hypothesis로 동일 에러 재시도 (R14 위반)

> Phase 2의 "Minecraft 모드 코드 작성·빌드·실행" 금지 조항은 **Phase 3 활성과 동시에 해제**되었다. R8 갱신 참조.

---

## Operating Mode

- 모델: Opus 4.7 (max effort)
- 검색 도구: WebSearch, WebFetch — R10 한도 내 사용
- 빌드/실행 도구: Bash (gradle, git, Prism Launcher CLI, ffmpeg for demo packaging)
- 작업 디렉토리: `/Users/taewoopark/Desktop/Obsidian-Sync/Mincraft-Challenge`
- 산출물 루트: `impl/`
- 본 디렉토리는 Obsidian vault — 마크다운 링크 호환성 유지

---

## Phase 3 Loop Health Invariants (매 반복 자동 점검)

1. **Monotonic Progress**: 매 반복은 H##/B###/M###/PT###/F### 중 **정확히 하나**를 advance 또는 close.
2. **No Silent Failure**: 빌드/측정/실행 실패도 `state/impl-progress.md`에 1행 + raw 로그 첨부.
3. **Hypothesis Discipline**: 동일 에러 클래스 3회 연속 미해소 → 자동 fallback-tree 검토 단위로 전환.
4. **Budget Awareness**: 8h/18h/24h 게이트 침범 시 `state/synthesis.md`의 Open Questions에 1줄 추가하고 즉시 우선순위 재산정.
5. **Premise Lock**: 매 5번째 반복마다 non-negotiable premise 자가 재진술 (impl-progress §8 self-audit).
