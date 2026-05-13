# Synthesis — Minecraft Challenge Solution-Space Map

> 최종 합성 보고서. 6개 핵심 챌린지(C1~C6) · 5개 축(D1~D5) · 12개 경로(P01~P12) · 29개 검증(V01~V29) 기반.
> 모든 사실 주장은 `state/verification.md`의 검증 ID로 추적한다.

**Status**: PATCHED (iter#62, strict-intent premise)

---

## 0. Executive Summary

**문제는 반드시 의도한 대로 풀어야 한다.** 최종 답은 `Minecraft 26.1.x + Fabric + VulkanMod + Beryl + Cobblemon + label fix`를 유지해야 한다. `1.21.11`, `1.21.1`, `1.20.1` 경로는 데모 fallback 또는 비교군일 뿐, 최종 합격 경로가 아니다.

2026-05-12 재검증으로 기존 판단이 바뀌었다. **Beryl 26.1.x 공식 Fabric 빌드가 존재한다**[V28]. VulkanMod도 26.1.2용 0.6.5 jar가 확인되었다[V29]. 따라서 기존 C1(Beryl 26.1 미지원)은 해소되었고, strict 풀이의 핵심 병목은 **Cobblemon을 1.21.1 공식 코드/빌드 라인에서 26.1.x로 포팅하는 작업**이다[V04·V14].

현재 결론:

1. **P01 — 26.1 strict + Beryl native**: 유일한 의도 충족 경로. ★ 1순위.
2. **P03 — 1.21.11 Beryl-native**: strict 실패 시 비교 데모. 최종 답으로는 26.1 미충족.
3. **P07/P10 — Iris/Sodium 공식 Cobblemon 경로**: 시연 안전망. VulkanMod+Beryl 지정 스택 미준수.

---

## 1. Top Recommendations

### P01 — 26.1 Strict + Beryl Native ★ 의도한 풀이

- **Tuple**: `(v1=26.1.x, l1=Fabric, s1=Beryl, f1=source/mixin label fix, c0=Skip Create)`
- **Core jars**: `VulkanMod_26.1.2-0.6.5.jar`[V29], `beryl_26.1.2-0.1.3-alpha+1.jar`[V28]
- **Predicted FPS (M-chip)**: 45–75, 실측 필요[V07·V16·V29]
- **Effort**: 8–16h
- **Risk**: HIGH

근거:

- 문제 텍스트의 핵심 4요소인 `26.1`, `VulkanMod`, `Beryl`, `Cobblemon`을 완화하지 않는다.
- VulkanMod+Beryl은 26.1.2 공식 jar 페어가 있다[V28·V29].
- Cobblemon 공식 26.1.x 빌드는 없으므로 자체 포팅이 필요하다[V04·V14].
- 라벨 버그는 Cobblemon `PokemonRenderer.renderNameTag`에서 `Font.DisplayMode.SEE_THROUGH`를 사용하는 구조로 좁혀졌다[V09·V22]. 포팅본 source patch가 가장 단순하고, 외부 mixin은 보조 경로다.

Falsification:

- 30분 안에 `26.1.2 + Fabric + VulkanMod + Beryl` 빈 인스턴스가 60FPS 베이스라인을 못 넘기면 P01 성능 위험으로 기록한다.
- 6h 안에 Cobblemon 26.1 포팅본이 main menu + Pokémon 1마리 spawn까지 도달하지 못하면 strict 완성 실패로 기록한다.
- 이 경우에도 fallback 데모는 별도 산출물일 뿐 P01 대체 합격이 아니다.

### P03 — 1.21.11 Beryl-native, 비교 fallback

- **Tuple**: `(v2=1.21.11, l1=Fabric, s1=Beryl, f1=label fix, c0=Skip Create)`
- **Status**: DRAFT fallback
- **Risk**: MEDIUM

역할:

- Beryl/VulkanMod alpha 페어와 label fix 검증을 분리하는 비교군이다.
- 1.21.11도 Cobblemon 공식 빌드가 없으므로 포팅은 여전히 필요하다[V04·V14].
- 26.1 요건을 만족하지 않으므로 최종 답으로 제출하면 안 된다.

### P07/P10 — 시연 안전망

- **P07**: 1.21.1 + Sodium/Iris + Cobblemon official
- **P10**: 1.20.1 + Sodium/Iris + Cobblemon official + Create Fabric official

역할:

- Cobblemon 공식 빌드와 일반 셰이더팩으로 빠르게 데모를 만들 수 있다[V04·V05].
- VulkanMod+Beryl+26.1 지정 스택을 벗어나므로 의도한 풀이가 아니다.
- strict 실패 시 FPS 기준, label fix 효과, 보고서용 대비 자료로만 사용한다.

---

## 2. Eliminated / Demoted Paths

| ID | 결정 | 사유 |
|---|---|---|
| **P02** | 비의도 기준선 | 26.1 + 셰이더 OFF라서 "Beryl/셰이더로" 요건 미충족. 성능 기준선으로만 사용. |
| **P03** | fallback | 1.21.11이라 26.1 strict 미충족. |
| **P04** | fallback 변형 | P03 + raycast label fix. f1/source patch보다 복잡하고 strict 아님. |
| **P05** | optional fallback | 1.21.11 + Create-Fly는 strict 아님. Create-Fly 26.1-pre 계열은 PoC로만 다룬다[V20·V25]. |
| **P06/P08** | blocked | Beryl 1.21.1 부재와 Connector 제약으로 지정 스택 구성 불가[V13·V21]. |
| **P09** | 저우선 | Beryl 1.20.1 backport는 strict 문제와 무관하고 P10보다 ROI 낮음. |
| **P11** | deprioritized | Quilt 호환 공개 데이터 부족, Fabric strict보다 우위 없음[V19·V26]. |
| **P12** | 실험 | custom SPIR-V 셰이더는 Beryl 지정 요건을 약화하고 구현 리스크가 큼[V12]. |

---

## 3. Remaining Questions

strict premise 때문에 더 이상 "26.1을 완화할 수 있는가"는 핵심 질문이 아니다. 남은 질문은 구현 방식과 채점 세부다.

| ID | 질문 | 기본 판단 |
|---|---|---|
| Q1 | "셰이더"는 Beryl 통합 파이프라인으로 충분한가? | 문제에 Beryl이 명시되어 있으므로 Yes를 기본값으로 둔다. |
| Q2 | 60FPS는 평균 / 1% low / 최저값 중 무엇인가? | 평균 FPS를 기본 합격선으로 두고 1% low를 보조 지표로 기록한다. |
| Q3 | label fix는 Cobblemon 본체 patch가 필요한가, 외부 mixin도 되는가? | 포팅본 source patch 우선, 외부 mixin은 배포 분리용 fallback. |
| Q4 | 심화 Create는 필수인가 optional인가? | strict 본문보다 후순위. 26.1 대응 빌드 확인 없이는 optional PoC. |
| Q5 | (iter#65) Java 21 ARM64 + Prism Launcher 시스템 설치를 brew cask로 진행해도 되는가? | 기본 판단 = 사용자 승인 대기. `brew install --cask temurin@21 prismlauncher`. 대안: Adoptium/Prism Launcher 공식 다운로드. |

---

## 4. 24-Hour Execution Timeline

**P01 strict 추진 시나리오**:

| 시간 | 작업 | 결과물 | 실패 시 기록 |
|---|---|---|---|
| 0–1h | 26.1.2 + Fabric + VulkanMod 0.6.5 + Beryl 0.1.3-alpha+1 빈 인스턴스 | 60FPS baseline, `latest.log`, modlist | 성능 병목 기록, P02 기준선 측정 |
| 1–7h | Cobblemon 1.21.1/main → 26.1.x 포팅 | `cobblemon-fabric-*-26.1.x.jar`, main menu, Pokémon 1마리 spawn | strict 실패 원인 로그, P03/P07 비교 데모 분리 |
| 5–8h | label fix를 Cobblemon 포팅본에 source patch로 적용 | `SEE_THROUGH` 제거 또는 `NORMAL` 강제, 벽 뒤 라벨 숨김 | 외부 mixin 또는 config OFF는 fallback으로만 표기 |
| 8–12h | 통합 FPS 측정: shader ON + Cobblemon 5마리 | FPS CSV, screenshot/video | Beryl 옵션 하향, RD 조정 |
| 12–16h | 회귀 테스트: 엔티티 렌더, battle prompt, name label | before/after 스크린샷 | 회귀 범위 문서화 |
| 16–20h | optional Create 26.1 PoC 여부 판단 | 가능하면 별도 optional 영상 | 실패해도 core pass에는 영향 없음 |
| 20–24h | 보고서, modlist, SHA, 영상 정리 | 최종 제출 패키지 | fallback은 "비의도 산출물"로 분리 |

---

## 5. Risk Register

| Risk ID | 경로 | 확률 | 영향 | 완화책 | 검증 |
|---|---|---|---|---|---|
| R-Beryl-alpha-26.1 | P01 | MEDIUM | FPS/렌더 회귀 | 26.1.2 공식 페어 고정, Beryl 옵션 보수화 | V28·V29 |
| R-Cobblemon-26.1-port | P01 | HIGH | BLOCKING | RenderState/registry/data codec부터 컴파일 오류 triage | V04·V08·V14 |
| R-Label-source-patch | P01 | MEDIUM | 라벨 fix 미완 | `SEE_THROUGH` 호출을 source patch, 실패 시 외부 mixin | V09·V22 |
| R-MoltenVK-overhead | P01/P03 | LOW | FPS 하락 | RD 12–16, Beryl low preset, vsync OFF | V07·V16 |
| R-Iris-VulkanMod-incompat | VulkanMod 경로 | CERTAIN | Iris/OptiFine 셰이더팩 차단 | Beryl 사용, Iris는 fallback으로만 분리 | V06·V18 |
| R-Create-26.1 | optional | HIGH | optional 심화 실패 | core P01과 분리, Create-Fly 26.1-pre는 PoC 취급 | V20·V25 |
| R-EntityCulling-VulkanMod | label 대체 | CERTAIN | 대체 경로 차단 | EntityCulling 사용 금지, f1/source patch 사용 | V06·V24 |

---

## 6. Solution Space Matrix

| 경로 | v | l | s | f | c | Status | Risk | 결정 |
|---|---|---|---|---|---|---|---|---|
| **P01** | v1 26.1.x | l1 Fabric | s1 Beryl native | f1 source/mixin | c0 | **OPTIMAL_CANDIDATE** | HIGH | **★ 의도한 풀이** |
| P03 | v2 1.21.11 | l1 Fabric | s1 Beryl | f1 | c0 | DRAFT | MEDIUM | 비교 fallback |
| P07 | v3 1.21.1 | l1 Fabric | s2 Iris | f1 | c0 | DRAFT | LOW | 시연 안전망 |
| P10 | v4 1.20.1 | l1 Fabric | s2 Iris | f1 | c1 Create | DRAFT | LOW | 시연 안전망 + Create |
| P02 | v1 26.1.x | l1 Fabric | s4 OFF | f1 | c0 | DRAFT | MEDIUM | 성능 기준선, 셰이더 요건 미충족 |
| P05 | v2/future v1 | l1 | s1 | f1 | c1 | DRAFT | HIGH | optional Create PoC |
| P06/P08 | v3 | mixed | s1 | f1 | mixed | BLOCKED | — | Beryl/Connector 제약 |
| P09/P11/P12 | mixed | mixed | mixed | f1 | c0 | DEPRIORITIZED | HIGH | strict보다 열등 |

---

## 7. Final Stance

- 최종 답은 **P01만**이다.
- P03/P07/P10이 성공해도 strict 문제를 "의도한 대로" 푼 것으로 간주하지 않는다.
- 24h 실행은 `P01 baseline → Cobblemon 26.1 port → source label fix → FPS tuning` 순서로 진행한다.
- fallback은 제출물의 신뢰도를 높이는 비교 자료로만 붙인다.

---

## Sources

- 검증 원장: `state/verification.md` V01–V29
- 챌린지: `challenges/C1~C6-*.md`
- 경로 상세: `solutions/P01~P12-*.md`
- 실행서: `playbook/00-manifest.md` ~ `playbook/07-acceptance.md`
