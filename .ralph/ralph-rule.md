# Ralph Iteration Rules (R1–R18)

> 본 파일은 매 반복에서 PROMPT가 참조하는 **불가침 규칙**이다.
> 규칙이 충돌하면 더 낮은 번호 규칙이 우선한다.
> R13~R18은 Phase 3(Strict Implementation) 활성과 함께 추가되었다.

---

## R1. One Atomic Action Per Iteration

한 반복은 단 하나의 지식·산출물 단위만 변경한다. 허용 단위:

**Phase 1 단위 (참조 전용 — 종결됨)**
- 신규 챌린지 1건 등록 + 인덱스 + coverage 로그
- 신규 솔루션 경로 1건 등록 + 인덱스 + coverage 로그
- 미검증 사실 1건 검증 → 상태 갱신 + coverage 로그
- 합성(synthesis) 1회 갱신 + coverage 로그
- 차원(dimension) 1개 축 1회 채움 + coverage 로그

**Phase 2 단위 (참조 전용 — 종결됨)**
- playbook/NN-*.md 1파일 신규 작성 + coverage 로그

**Phase 3 단위 (현재 활성)**
- 1 checkpoint(H##) 1단계 진행 (TODO→IN_PROGRESS→PASS/FAIL/BLOCKED) + impl-progress 갱신 + coverage 로그
- 1 build attempt(B###) 실행 + 로그 첨부 + 에러 클래스 분류
- 1 measurement(M###) 실행 + raw CSV 저장 + 평균/1% low 산출
- 1 patch(PT###) 작성·적용 + 회귀 검증 1건
- 1 failure/hypothesis(F###) 분석 + 다음 행동 결정
- 1 산출물 packaging 단계 (modlist/shasum/report 중 1개)

**왜:** Ralph 루프의 자기참조는 누적된 파일 상태로 동작한다. 한 반복이 여러 변경을 누적하면 다음 반복이 무엇을 보았는지 추적 불가능해진다. 한 반복이 빈손으로 끝나면 무한 반복은 진전을 잃는다.

## R2. State-First Read

어떤 쓰기 작업이든 시작 전에 다음을 순서대로 읽는다:
1. `state/coverage.md`의 마지막 5줄
2. `state/impl-progress.md`의 §1 Checkpoint Status + 마지막 5 iter log
3. 직전 반복이 다룬 H##/B###/M###/PT###/F### 단위의 상세

**왜:** 직전 반복의 진척을 인식하지 못하면 같은 일을 반복한다. R13(빌드 중복 금지)과 R14(가설 중복 금지)가 이 위에 얹힌다.

## R3. No Duplicates

신규 파일을 만들기 전 항상 다음을 수행한다:
1. `state/*.md` 및 `impl/**` 트리에서 slug/번호/주제로 grep
2. 동일 주제가 있으면 → 신규 생성 대신 기존 항목 정제로 우회
3. 변형(variant)으로 분리할 가치가 있는 경우에만 신규 생성

## R4. Source-Cited Facts

모드 버전, 호환성, 의존성, 성능 수치, 빌드 시스템 동작 등 **모든 사실 주장**에는:
- **인라인 URL**, 또는
- `[UNVERIFIED]` 태그 + `state/verification.md` 1행 추가, 또는
- Phase 3에서는 추가로 **재현 가능한 명령**(예: `./gradlew :fabric:dependencies | grep fabric-api`)을 인용할 수 있다.

태그·출처 없는 단정 진술은 위반.

## R5. Coverage Bookkeeping

매 반복 종료 시 `state/coverage.md`의 `## Log`에 **정확히 1줄** append.

형식:
```
- iter#{N} {YYYY-MM-DD} {action-code} :: {요약 ≤ 80자}
```

`action-code`는:
- Phase 1/2 코드: `+challenge:C{n}` · `+dim:D{n}` · `+path:P{nn}` · `verify:V{nn}` · `synthesis:rev{m}` · `synthesis:final` · `+playbook:NN-{slug}`
- **Phase 3 추가 코드**: `impl:H{##}` · `impl:B{###}` · `impl:M{###}` · `impl:PT{###}` · `impl:F{###}` · `impl:pkg-{slug}` · `impl:audit`

## R6. Verification Ledger Discipline

`state/verification.md`는 **append-only 원장**이다. 항목 상태 변경 시 새 행을 추가하지 않고 기존 행의 `Outcome`을 갱신한다. 결과는 `VERIFIED` · `INFEASIBLE` · `STALE` 중 하나. Phase 3에서 외부 사실(예: 새로 발견된 mod 호환 정보)이 필요할 때만 V## 신규 추가.

## R7. Promise Discipline

`<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>`는 CLAUDE.md의 **C1~C15가 모두 참**일 때만 발행한다.

발행 직전에 반드시:
1. C1~C15를 한 줄씩 인용하며 체크
2. 각 항목의 근거 파일/줄/B###/M###/PT### 인용
3. `state/impl-progress.md` §1 Checkpoint Status 표가 모두 `PASS`임을 확인

> Phase 2 종료 시점에 동일 태그가 발행된 적이 있다(iter#61, iter#64). Phase 3 활성 이후의 재발행은 C9~C15 추가 충족이 전제다.

## R8. Code Implementation Permission (Phase 3)

**Phase 1·2 동안 R8은 코드/빌드/실행을 금지했다. Phase 3 활성과 함께 다음으로 갱신됨**:

허용 행위:
- Cobblemon fork clone (`git clone`)
- gradle 빌드 (`./gradlew build`, `:fabric:build`, etc.)
- 소스 파일 편집 (포팅 패치, 라벨 패치)
- Minecraft 클라이언트 실행 (Prism Launcher CLI / `java -jar`)
- FPS 측정 도구 실행 (Spark, Sodium FPS overlay, MC built-in F3)
- 영상 녹화·인코딩(ffmpeg, OBS)
- sha512 계산, modlist 생성

금지(여전히):
- Mojang 비공개 매핑 추출 시도
- 라이선스 위반 재배포 (Cobblemon MPL 2.0 준수)
- `question.md` 수정
- non-negotiable premise 우회 결과를 최종 답으로 채택
- 외부 시스템에 임의 push (`git push` to non-fork remote, `gh release` 등) — 사용자 명시 승인 필수

## R9. Stop on Hard Block

사용자 판단을 요구하는 막힘 발생 시:
1. `state/synthesis.md`의 `## Open Questions for User` 섹션에 질문 1줄 추가
2. 해당 반복은 **다른 우선순위 단위**로 전환 (impl-progress의 다른 H##/B###/M### 후보 검사)
3. 막힘이 strict 자체를 흔드는 경우(예: 26.1.x SDK 부재 확정)에도 즉시 fallback을 최종 답으로 채택하지 않는다 — 사용자 확인 대기 + 우회 가능한 다른 단위 진행

## R10. Token Frugality

- 한 반복당 WebSearch ≤ 3회, WebFetch ≤ 2회.
- 동일 URL 반복 fetch 금지 (15분 캐시 활용).
- Bash 명령은 결과를 `impl/build-logs/` 등 파일로 떨궈 다음 반복이 재실행 없이 참조 가능하게 한다.
- 대형 로그는 `head -200` / `tail -200` / `grep -E '(error|FAILED|BUILD SUCCESSFUL)'`로 요약해 컨텍스트에 싣는다.

## R11. INFEASIBLE 증거 기준 (Anti-Capitulation)

`INFEASIBLE` 판정은 **적극적 증거**를 요구한다. 불충분 근거:
- 검색 UI/홈 화면 반환
- 공식 문서 미명시 사실
- 부정 진술 인용 실패

INFEASIBLE 발행 전 다음 중 ≥1 충족:
1. 1차 출처의 부정 진술 인용
2. ≥1년 stale OPEN 이슈 링크
3. 독립 출처 ≥2개의 동일 실패 보고
4. 기술적 모순의 명시적 명세

조건 미충족 시 `[UNVERIFIED]` 유지하거나 `VERIFIED (partial/negative)`로 마감해 양면 가능성 보존.

**왜:** 24h budget 압박 하에 "찾지 못함"을 "존재하지 않음"으로 격하시키면 솔루션 공간이 인위적으로 좁아진다.

## R12. Status 어휘 잠금

`state/solutions.md`의 Status 컬럼은 enum 4종만 사용: `DRAFT` · `VIABLE` · `BLOCKED` · `OPTIMAL_CANDIDATE`.

`state/impl-progress.md`의 Checkpoint Status는 enum 6종만: `TODO` · `IN_PROGRESS` · `PASS` · `FAIL` · `BLOCKED` · `DEFERRED`.

신규 어휘 도입 금지. 약한 판단은 Detail/비고 컬럼으로 표현.

---

## R13. No Redundant Build (Phase 3)

동일 `(code state SHA, gradle args)` 조합으로 빌드 재실행 금지. B### 실행 전:
1. `impl/build-logs/`에서 같은 args 검색
2. 직전 빌드 이후 코드 변경 SHA 비교 (`git rev-parse HEAD`)
3. 둘 다 동일이면 재빌드 대신 직전 결과 인용

**왜:** 빌드는 1~10분 단위로 비싸다. 무한반복 루프에서 결정적(deterministic) 결과 재실행은 진전 없이 budget만 소모한다.

## R14. Hypothesis Discipline (Phase 3)

각 실패(F###)는 단일 hypothesis와 검증 결과를 가진다. 같은 hypothesis로 동일 에러 재시도 금지.

매 F### 작성 시:
- **증상(symptom)**: 정확한 에러 메시지 1~3줄
- **에러 클래스(EC-...)**: 모듈·심볼 기반 라벨
- **가설(hypothesis)**: "X 때문일 것이다"의 검증 가능 명제
- **검증 절차**: 1단계 명령 또는 코드 변경
- **결과**: CONFIRMED · REFUTED · INCONCLUSIVE
- **다음 행동**: PT###, 다른 hypothesis, fallback 분기 중 1택

3회 연속 동일 에러 클래스 미해소 → **자동 fallback-tree 검토 단위로 전환**(impl:F### → impl:audit).

## R15. Measurement Reproducibility (Phase 3)

모든 M### FPS 측정은 다음을 고정한다:
- 좌표 (`/tp` 명령 기록)
- 시각(in-game time `/time set`)
- 날씨(`/weather clear`)
- 동시 엔티티 수
- render distance · simulation distance
- shader 설정 hash

raw 데이터는 `impl/measurements/M###.csv`로 저장하고 최소 60초·≥5초 워밍업 후 수집. 평균과 1% low를 함께 기록.

같은 설정·시나리오 재측정은 **3회 평균까지만**. 4회 이상이면 신규 setting delta 필요(R14와 같은 정신).

## R16. Premise Lock (Phase 3)

매 5번째 Phase 3 반복(`iter%5==0`)에 다음을 자가 진술하고 `state/impl-progress.md`의 §8 self-audit에 기록:

```
[Premise Re-Statement at iter#N]
MC=26.1.x, Fabric, VulkanMod 26.1.2-0.6.5, Beryl 26.1.2-0.1.3-alpha+1,
Cobblemon (self-port 26.1.x), Label fix=source patch primary,
Target: M-chip Mac, Cobblemon 5 spawn + shader ON, avg FPS ≥ 60.
Bypass count since last audit: 0 | N detected.
```

bypass count > 0이면 즉시 우선순위를 audit/회복 단위로 전환.

**왜:** 무한반복 + budget 압박은 strict 조건을 무의식적으로 완화시키는 압력을 만든다. 명시적 자가 진술로 잠금.

## R17. Cumulative Budget Gate (Phase 3)

`state/impl-progress.md` §7에 누적 실행 시간을 분 단위로 갱신. 게이트:
- **8h 게이트**: H5(compile clean) 미도달 → fallback-tree §B1 검토(P03/P07 비교 데모 추가) + Cobblemon 포팅 범위 축소 결정
- **18h 게이트**: H10(T2 ≥60) 미도달 → Beryl/VulkanMod 설정 하한선 검토 또는 Cobblemon 엔티티 LOD 패치 검토
- **24h 게이트**: H14(packaging) 미완 → 부분 산출물 제출 + `report.md`에 strict pass 여부 자가 진술

각 게이트는 자동 멈춤이 아니라 **우선순위 재산정 트리거**. fallback 전환이 곧 strict 포기를 뜻하지 않는다.

## R18. Iter Log Append Discipline (Phase 3)

매 반복은 `state/impl-progress.md` §6 Iter Log에 형식 엄수 1행 append + `state/coverage.md` 1행 append. 둘 다 빠지면 그 반복은 **무효**로 간주하고 다음 반복이 보정 책임을 진다.

```
- iter#{N} {YYYY-MM-DD} {H##|B###|M###|PT###|F###|pkg-{slug}|audit} {PASS|FAIL|PARTIAL|DEFERRED} :: {≤120자 요약}
```

**왜:** 두 원장이 분기하면 자기참조가 깨진다. 단일 진실의 원장(state/impl-progress.md)을 coverage.md가 인덱싱하는 구조를 유지.
