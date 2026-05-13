# Playbook — Minecraft Cobblemon Challenge 완전 솔루션

> Phase 2 산출물. 전제는 하나다: **반드시 문제를 의도한 대로 푼다.**
> 코어 트랙은 P01, 즉 `MC 26.1.x + Fabric + VulkanMod + Beryl + Cobblemon + label fix`다.

---

## 0. 본 디렉토리 목적

`question.md`의 챌린지를 실제 24h 실행 절차로 변환한다. `state/`가 솔루션 공간과 검증 원장이라면, `playbook/`은 strict 풀이의 작업 순서, jar 매니페스트, 실패 기록 방식을 정의한다.

P03/P07/P10은 fallback 데모 또는 비교군이다. **최종 합격 경로는 P01뿐이다.**

---

## 1. Step Index

| Step | 파일 | 역할 | 24h 슬롯 | 의존 |
|---|---|---|---|---|
| **00** | [00-manifest.md](./00-manifest.md) | P01 strict jar 버전·SHA·호환 매트릭스 | T-1h | — |
| **01** | [01-environment.md](./01-environment.md) | Java 21 ARM64, Fabric 26.1.x, VulkanMod+Beryl baseline FPS | 0–1h | 00 |
| **02** | [02-cobblemon-port.md](./02-cobblemon-port.md) | Cobblemon 1.21.1/main → 26.1.x 포팅 | 1–7h | 01 |
| **03** | [03-label-fix.md](./03-label-fix.md) | Cobblemon `PokemonRenderer.renderNameTag` source patch 또는 mixin | 5–8h | 02 |
| **04** | [04-shader-tuning.md](./04-shader-tuning.md) | Beryl·VulkanMod 튜닝으로 shader ON + Cobblemon 60FPS | 8–12h | 02, 03 |
| **05** | [05-fallback-tree.md](./05-fallback-tree.md) | strict 실패 시 기록·비교 데모 분기 | 발동 시 | 모두 |
| **06** | [06-create-optional.md](./06-create-optional.md) | optional Create/비공식 포트 PoC | 16–20h | 04 |
| **07** | [07-acceptance.md](./07-acceptance.md) | strict acceptance 기준과 제출 패키지 | 종료 | 모두 |

---

## 2. 24-Hour Time Budget

| 누적 시간 | Step | 핵심 산출물 | 실패 시 처리 |
|---|---|---|---|
| **T-1h** | 00 | 26.1.x jar 다운로드, SHA 확인 | 버전 불일치 기록 |
| **0–1h** | 01 | VulkanMod+Beryl 26.1.2 baseline ≥ 60FPS | P01 성능 위험 기록, P02 기준선 측정 |
| **1–7h** | 02 | Cobblemon 26.1.x 포팅본 build + main menu + Pokémon 1마리 | strict 실패 사유 로그, fallback 데모 분리 |
| **5–8h** | 03 | 라벨이 벽 뒤에서 보이지 않는 source patch/mixin | config OFF는 비의도 fallback으로만 표기 |
| **8–12h** | 04 | shader ON + Cobblemon 5마리 평균 ≥ 60FPS | 옵션 하향, RD 조정, 실패 기록 |
| **12–16h** | — | 통합 회귀 테스트, before/after 캡처 | 회귀 범위 문서화 |
| **16–20h** | 06 | optional Create PoC 여부 결정 | core pass와 분리 |
| **20–24h** | 07 | 보고서, modlist, SHA, 영상 정리 | fallback은 별첨 |

---

## 3. 핵심 검증 참조

| V## | 사실 | 활용 Step |
|---|---|---|
| V04 | Cobblemon 공식 26.1.x 빌드 부재 | 02 |
| V06/V18 | VulkanMod은 Iris/Sodium/OptiFine/EntityCulling과 비호환 | 00, 05 |
| V07/V16 | macOS M-chip에서 VulkanMod/MoltenVK 동작 근거 | 01, 04 |
| V08 | 26.1은 unobfuscated, pre-26.1 mod는 재컴파일 필요 | 02 |
| V09/V22 | Cobblemon label renderer와 config fallback | 03 |
| V14 | Cobblemon 1.21.9+/26.1 공개 포팅 브랜치 부재 | 02 |
| V28 | Beryl 26.1.2 official jar 확인 | 00, 01, 04 |
| V29 | VulkanMod 26.1.2 official jar 확인 | 00, 01, 04 |

---

## 4. 제출 산출물

1. **modlist.txt** — 26.1.x jar 버전·SHA512
2. **fps-results.csv** — baseline / shader ON / Cobblemon spawn 측정값
3. **demo.mp4** — Beryl shader ON + Cobblemon + 벽 뒤 라벨 숨김
4. **cobblemon-26.1-port/** — 포팅 diff 또는 fork URL, MPL 2.0 준수
5. **label-fix.patch** 또는 **label-fix-mixin/** — 라벨 수정 구현
6. **report.md** — strict 성공/실패 근거, fallback 비교 자료 분리

---

## 5. 본 playbook이 다루지 않는 것

- 버전 완화로 합격 처리하는 전략. strict premise에서는 허용하지 않는다.
- P03/P07/P10의 상세 환경 구축. 해당 경로는 비교 데모가 필요할 때 `solutions/` 문서만 참조한다.
- 실제 Cobblemon 대규모 포팅 코드 작성. 본 문서는 24h 실행 절차와 게이트를 정의한다.

---

## Sources

- 본 챌린지 정의: `../question.md`
- 솔루션 공간 매핑: `../state/synthesis.md`, `../state/verification.md`
- 의사결정 규칙: `../.ralph/ralph-rule.md`
- 1차 외부 출처: Modrinth API, GitLab `cable-mc/cobblemon`, GitHub `xCollateral/VulkanMod`, Fabric docs
