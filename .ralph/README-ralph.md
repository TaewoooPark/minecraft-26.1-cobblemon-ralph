# Minecraft Challenge — Ralph Loop Workspace

[question.md](./question.md)에 정의된 Minecraft Challenge의 **솔루션 공간을 망라적으로 매핑**하는 Ralph 루프 워크스페이스.

---

## Start

Claude Code 슬래시 커맨드 파서는 `$(...)` shell substitution을 처리하지 않는다. 짧은 부트스트랩 프롬프트를 넣고, 실제 반복 지시는 `PROMPT.md`에서 읽게 한다.

**복사용 단일 라인:**
```
/ralph-loop Read PROMPT.md and execute exactly one Ralph iteration following CLAUDE.md and ralph-rule.md. Workdir is /Users/taewoopark/Desktop/Obsidian-Sync/Mincraft-Challenge . --completion-promise SOLUTION-SPACE-MAPPED --max-iterations 160
```

> 슬래시 커맨드는 위치 인자를 공백으로 모아 부트스트랩 프롬프트로 저장한다. 따옴표는 필요 없다.
> `--completion-promise`의 값(`SOLUTION-SPACE-MAPPED`)은 단일 토큰이므로 따옴표 불필요.

## Cancel
```
/cancel-ralph
```

## Inspect progress
- `state/coverage.md` — 매 반복 1줄 로그
- `state/challenges.md` — 챌린지 인덱스
- `state/solutions.md` — 경로 인덱스
- `state/verification.md` — 검증 원장
- `state/synthesis.md` — 최종 합성 (마지막 단계에 채워짐)

---

## Architecture

```
Mincraft-Challenge/
├── question.md             # 원본 문제 (read-only)
├── CLAUDE.md               # 영속 컨텍스트 (auto-load)
├── PROMPT.md               # 반복 프롬프트 본문
├── ralph-rule.md           # R1~R10 불가침 규칙
├── README-ralph.md         # 본 파일
│
├── state/                  # 누적 상태 (Ralph 읽기·쓰기)
│   ├── coverage.md         # append-only 진행 로그
│   ├── challenges.md       # 챌린지 인덱스
│   ├── dimensions.md       # 솔루션 축 D1~D5
│   ├── solutions.md        # 경로 인덱스
│   ├── verification.md     # 사실 검증 원장
│   └── synthesis.md        # 최종 합성 (running)
│
├── challenges/             # 챌린지 상세 (1 file / challenge)
├── solutions/              # 경로 상세 (1 file / path)
└── verification/           # 검증 노트 (옵션)
```

## How the loop converges

Ralph 기법은 **같은 프롬프트가 반복되며 누적 파일 상태가 자기참조**로 작동한다.

1. **Phase 1 (iter 1~6)**: 핵심 챌린지 식별 — `discovery queue` 소진
2. **Phase 2 (iter 7~10)**: 차원 축 D1~D5 정제 (TODO 항목 해소)
3. **Phase 3 (iter 11~22)**: 12개 경로(Cartesian) 생성
4. **Phase 4 (iter 23~38)**: 검증 원장 항목 1차 출처로 확인
5. **Phase 5 (iter ~39)**: 합성 + `<promise>` 발행

각 반복은 R1에 따라 단 1개의 원자적 진전만 한다. 정지 훅은 `<promise>SOLUTION-SPACE-MAPPED</promise>`를 보면 종료한다.

## Tuning knobs

- 더 깊은 탐색: `--max-iterations 60`으로 늘리기
- 더 빠른 마감: PROMPT.md의 C3(경로 ≥ 12)를 ≥ 6으로 축소
- 더 엄격한 검증: ralph-rule.md R4를 "출처 ≥ 2개" 로 강화

## Anti-patterns to watch
- 한 반복에서 여러 파일 신규 생성 (→ R1 위반, 다음 반복이 혼란)
- 검증 없는 단정 (→ R4 위반)
- `state/coverage.md` 갱신 누락 (→ R5 위반, 다음 반복이 직전 진척 모름)
- 조기 `<promise>` 발행 (→ R7 위반, 임무 미완료로 종료)
