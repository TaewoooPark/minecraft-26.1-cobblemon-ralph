# Ralph Loop: Strict Implementation for Minecraft Challenge

매 반복마다 부트스트랩 프롬프트가 본 파일을 읽도록 지시한다. 본 파일이 실제 반복 지시서다. 너의 이전 작업물은 파일에 남아 있다.

**작업 디렉토리**: `/Users/taewoopark/Desktop/Obsidian-Sync/Mincraft-Challenge`
**현재 활성 단계**: Phase 3 — Strict Implementation
**완료 promise tag**: `<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>` (C1~C15 전부 PASS 시)

---

## 0. Always-Read Order

1. `question.md` (캐노니컬 문제, §4 Path A가 strict 진실)
2. `.ralph/CLAUDE.md` (Mission · File Map · C1~C15)
3. `.ralph/ralph-rule.md` (R1–R18 불가침 규칙)
4. `state/coverage.md`의 **마지막 5줄**
5. `state/impl-progress.md`의 §1 Checkpoint Status 표 + §6 Iter Log 마지막 5줄
6. 다음 행동이 의존하는 단위의 상세 섹션(§2 빌드 / §3 측정 / §4 패치 / §5 실패)
7. 필요 시 `playbook/NN-*.md` 해당 단계 (참조 전용, 수정 금지)

---

## 1. Decide ONE Unit of Work (우선순위 순)

반드시 아래 우선순위로 **첫 번째 진행 가능한 항목 하나만** 실행한다. 상위 항목이 자기 단계에서 BLOCKED이면 R9에 따라 차상위로 내려간다.

### H) Checkpoint Advance (최우선)

- 조건: `state/impl-progress.md` §1에서 `TODO` 또는 `IN_PROGRESS`인 가장 낮은 ID의 H## 존재
- 행동:
  1. 해당 H##의 합격 정의를 다시 읽는다.
  2. **단 하나의 외부 효과**(명령 실행/파일 작성/측정)를 일으킨다.
  3. 결과에 따라 상태를 `IN_PROGRESS` → `PASS`/`FAIL`/`BLOCKED`/`DEFERRED`로 갱신.
  4. 실패면 곧바로 F### 등록(다음 우선순위 자동 진입 대신 같은 반복 내에서 가설을 1개 기록하고 다음 반복으로 넘어간다).
  5. `state/coverage.md` `impl:H{##}`, `state/impl-progress.md` §6에 1행 append.

체크포인트별 표준 명령(참고):
- **H0**: `java -version`, `which prismlauncher`, `git --version`, `./gradlew --version` (없으면 설치 단계로)
- **H1**: Prism CLI로 `cobblemon-p01-26.1` 인스턴스 부팅 → 메뉴 진입 스크린샷
- **H2**: VulkanMod+Beryl만 추가한 인스턴스에서 S1/S2/S3 시나리오 측정 (각각 M### 1건)
- **H3**: `git clone https://gitlab.com/cable-mc/cobblemon.git impl/cobblemon-port && cd impl/cobblemon-port && git checkout -b port/26.1.x`
- **H4**: `gradle.properties` 편집 + PT### 패치 기록
- **H5**: `./gradlew :fabric:build 2>&1 | tee impl/build-logs/B{NNN}.log` — exit 0이면 PASS
- **H6**: 빌드된 jar를 Prism 인스턴스에 설치 + 부팅 시도
- **H7**: 메인 메뉴 → 단일 플레이어 → `/pokespawn pikachu`
- **H8**: PT### 라벨 패치 적용 → 재빌드 → 벽 뒤/앞 시야 비교 스크린샷
- **H9~H11**: M### FPS 측정 (R15 준수)
- **H12**: 미달 시 Beryl/VulkanMod 설정 1개 delta → 재측정
- **H13**: ffmpeg 또는 OBS로 60s demo 녹화 → `impl/demo/demo.mp4`
- **H14**: `impl/artifacts/`에 8종 산출물 모음
- **H15**: `report.md` 작성 + premise 자가 진술 + sha512 일치 검증

### B) Build Attempt

- 조건: H4/H5 진행 중 또는 H8/H12 이후 코드 변경 발생, 그리고 R13(중복 빌드 금지) 위반 없음
- 행동:
  1. `git rev-parse HEAD` + gradle args 기록
  2. `./gradlew {args} 2>&1 | tee impl/build-logs/B{NNN}.log`
  3. 종료 코드, BUILD SUCCESSFUL/FAILED 줄 추출
  4. 실패 시 첫 에러 5줄과 에러 클래스(EC-...) 식별 → F### 등록
  5. `state/impl-progress.md` §2 표 1행 추가 + §6 Iter Log 추가
  6. `state/coverage.md` `impl:B{NNN}` 추가

### M) Measurement

- 조건: H1/H2/H9/H10/H11/H12 단계에서 미측정 시나리오 존재 또는 R14 위반 없는 신규 설정 delta 적용 직후
- 행동:
  1. R15 고정 조건 적용 (`/tp`·`/time`·`/weather`·entity count)
  2. ≥5s 워밍업 후 60s 측정 → CSV로 `impl/measurements/M{NNN}.csv`
  3. 평균·1% low 산출 → §3 표 1행 추가
  4. 결과를 시나리오 합격선(T1≥75 / T2≥60 / T3≥45)과 대조해 PASS/FAIL 판정
  5. FAIL이면 H12 튜닝 후보 1개 식별(다음 반복 PT### 또는 설정 delta)
  6. `state/coverage.md` `impl:M{NNN}` 추가

### PT) Patch Application

- 조건: H4/H8/H12에서 패치 1건이 식별됨, R13/R14 충돌 없음
- 행동:
  1. 패치 대상 파일 read → 변경 의도 1줄 명시
  2. `git diff` 또는 `Edit` tool로 변경 적용
  3. `git diff > impl/patches/PT{NNN}-{slug}.patch`
  4. 회귀 검증 명령 1개 즉시 실행 (예: `./gradlew :common:compileKotlin`)
  5. §4 표 1행 + §6 Iter Log 1행
  6. `state/coverage.md` `impl:PT{NNN}` 추가

### F) Failure Triage

- 조건: 직전 반복이 FAIL이고 §5 F### 가설이 미해소
- 행동:
  1. 에러 클래스(EC-...) 재확인
  2. 단일 hypothesis 작성 ("X 때문이라면 Y가 참일 것이다")
  3. 1단계 검증 명령 또는 코드 inspection 수행
  4. 결과: CONFIRMED → 다음 반복은 PT### / REFUTED → 새 hypothesis / INCONCLUSIVE → 외부 출처 검색
  5. R14의 "3회 연속 동일 EC" 조건 충족 시 §1 H## 상태를 `BLOCKED`로 갱신하고 audit 단위로 전환

### A) Audit & Self-Check

- 조건: 다음 중 하나
  - 마지막 5 반복이 모두 FAIL/INCONCLUSIVE
  - `iter % 5 == 0` (R16 premise re-statement)
  - 8h/18h/24h budget 게이트 침범 (R17)
  - Checkpoint 표에 `BLOCKED` ≥ 2개 누적
- 행동:
  1. R16 premise 자가 진술 1행 추가
  2. `state/impl-progress.md` §8 self-audit 항목 4가지 점검
  3. 위반 발견 시 `state/synthesis.md`의 `## Open Questions for User`에 1줄 + 다음 우선순위 단위 재산정
  4. `state/coverage.md` `impl:audit` 추가

### P) Packaging

- 조건: C11(H8) 이후, `impl/artifacts/`의 8종 중 ≥1개 미존재
- 행동:
  1. 한 산출물 종류 1개를 작성/복사
     - `modlist.txt`: 설치된 mod jar 목록 + 버전
     - `shasum-512.txt`: 모든 jar의 sha512
     - `fps-results.csv`: M### 결과 통합
     - `screenshots/label-before-after/`: H8 스크린샷 복사
     - `cobblemon-26.1-port.diff`: fork HEAD vs upstream `1.21.1` 브랜치 diff
     - `label-fix.patch`: PT### 라벨 패치 통합본
     - `demo.mp4`: H13 결과 복사
     - `report.md`: H15 작성 결과
  2. `state/coverage.md` `impl:pkg-{slug}` 추가

### G) Final Promise

- 조건: C1~C15 **모두 충족**
- 행동:
  1. CLAUDE.md C1~C15 한 줄씩 인용하며 체크
  2. 각 C에 근거 (파일·H##·B###·M###·PT###) 인용
  3. `state/coverage.md`에 `impl:final + promise emitted` 추가
  4. 응답 마지막 줄에 `<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>` 출력

---

## 2. Hard Constraints (위반 시 즉시 중단)

- 한 반복 = 한 단위(H/B/M/PT/F/A/P/G 중 1) (R1)
- 새 파일 작성 ≤ 1개/반복 (R1·R3)
- 사실 주장에는 URL 또는 `[UNVERIFIED]` 또는 재현 명령 (R4)
- 매 반복 `state/coverage.md` + `state/impl-progress.md` §6 둘 다 1행 append (R5·R18)
- 동일 `(코드 SHA, gradle args)` 재빌드 금지 (R13)
- 동일 hypothesis로 동일 에러 재시도 금지 (R14)
- non-negotiable premise 우회 결과를 최종 답으로 채택 금지 (R8·R16)
- 외부 시스템 임의 push 금지 (`git push origin`, `gh release`, 외부 호스트 업로드) — 사용자 명시 승인 시에만 (R8)
- 동일 설정·시나리오 측정 4회 이상 금지 (R15)

---

## 3. Stop Condition

CLAUDE.md의 C1~C15가 모두 참이면, 그리고 오직 그 경우에만, 응답 마지막 줄:

```
<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>
```

> Phase 2 종결 시 같은 태그가 발행된 적이 있다(iter#61, iter#64) — 그 발행은 C1~C8 기준이며, 현재는 C9~C15가 새로 추가되어 자동으로 false 상태가 되었다. 재발행은 C9~C15까지 모두 PASS일 때.

---

## 4. Anti-Patterns

- 한 반복에 여러 단위(H+B+M)를 동시 처리
- 검증 없이 "동작한다/안 한다" 단정
- `question.md` 수정
- 빌드 로그를 첨부하지 않고 "BUILD SUCCESSFUL" 자가 진술
- 측정값을 raw CSV 없이 본문에만 기재
- 라벨 fix를 config OFF로 회피한 채 PASS 선언
- 26.1.x 빌드가 어려워졌다고 1.21.11/1.21.1로 강등한 결과를 최종 답으로 기록
- 같은 에러를 다른 hypothesis 없이 재빌드로 우회 시도

---

## 5. Iteration Counter

매 반복 시작 시 `state/coverage.md`의 `## Log`에서 마지막 `iter#N`을 읽고 `N+1`로 새 줄을 시작한다.

Phase 3 활성 시점의 최근 마커: iter#64(Phase 2 promise re-emit). 다음 Phase 3 첫 반복은 `iter#65`.

---

## 6. Resume Semantics (무한반복 보장)

매 반복 시작 시 다음을 자동 수행:

1. **마지막 반복 코드 읽기** (`state/coverage.md` 마지막 줄의 `action-code`):
   - `impl:H##` → 해당 H##가 아직 `IN_PROGRESS`/`FAIL`이면 §1.H 우선
   - `impl:B###` → 빌드 결과가 FAIL이면 §1.F (triage), PASS면 다음 H## 진입
   - `impl:M###` → 측정이 합격선 미달이면 §1.PT (튜닝), 합격이면 다음 H##
   - `impl:PT###` → 회귀 검증이 안 끝났으면 §1.B (재빌드), 끝났으면 다음 H##
   - `impl:F###` → hypothesis 결과에 따라 §1.PT 또는 §1.F 재진입
   - `impl:audit` → 점검 결과에 따라 우선순위 재산정
   - `impl:pkg-*` → 다른 산출물 종류 1개 추가
   - `impl:final + promise emitted` → 후행 반복은 promise를 다시 검토하지 말고 immediate exit (이미 종결)

2. **충돌 감지**: 마지막 5 반복의 action-code가 모두 동일 H##/EC면 §1.A (Audit) 강제 진입.

3. **Budget 게이트 검사**: `state/impl-progress.md` §7의 누적 시간이 8h/18h/24h 경계를 넘었으면 §1.A 진입 후 우선순위 재정렬.

이 6단계 resume 로직이 "어떤 상태에서 깨어나도 다음 한 단계가 결정된다"는 무한반복 진전 불변량을 보장한다.

---

## 7. Templates

### 7.1 Iter Log 1행 형식

```
- iter#{N} {YYYY-MM-DD} {action-code} {RESULT} :: {요약 ≤120자}
```

### 7.2 B### 표 행

```
| B003 | iter#71 | ./gradlew :fabric:build | FAILED | EC-render-RenderType.create | RenderType.create 시그니처 변경, 14개 호출지점 |
```

### 7.3 F### 분석 블록

```markdown
#### F002 (iter#73, from B003)

- **증상**: `error: type mismatch: inferred type is RenderType but RenderType.CompositeState was expected`
- **에러 클래스**: EC-render-RenderType.create
- **가설**: 26.1.x에서 `RenderType.create`의 4번째 인자 타입이 변경되었을 것이다 (mojang/yarn unobf).
- **검증 절차**: net.minecraft.client.renderer.RenderType 디컴파일 + 호출지점 1개 수동 수정 후 부분 빌드
- **결과**: CONFIRMED — `RenderType.CompositeState.builder()`를 통한 빌더 패턴 필요
- **다음 행동**: PT004 — 14 호출지점 일괄 변환
```

### 7.4 M### CSV 헤더

```csv
sample_idx,timestamp_ms,fps_instant,fps_1s_avg,frame_time_ms,entities_visible,gpu_pct,cpu_pct
```

### 7.5 R16 premise re-statement

```
[Premise Re-Statement at iter#{N}]
MC=26.1.x, Fabric, VulkanMod 26.1.2-0.6.5, Beryl 26.1.2-0.1.3-alpha+1,
Cobblemon (self-port 26.1.x), Label fix=source patch primary,
Target: M-chip Mac, Cobblemon 5 spawn + shader ON, avg FPS ≥ 60.
Bypass count since last audit: 0 detected.
```
