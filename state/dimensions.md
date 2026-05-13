# Solution-Space Dimensions

각 솔루션 경로 = 5-튜플 `(version, loader, shader, labelfix, create)`.
빈 항목은 Ralph 반복(우선순위 B)에서 채운다.

---

## D1. Minecraft Version
| code | value | rationale |
|---|---|---|
| v1 | **26.1** | 문제 텍스트 엄격 해석 |
| v2 | **1.21.11** | Beryl-native fallback. 26.1 strict 전제가 적용되면 최종 답이 아니라 비교/탈출 경로 |
| v3 | **1.21.1** | Cobblemon 공식 지원 라인 |
| v4 | **1.20.1** | Create Fabric 가용 라인 |
| v5 | **1.21.9** | Beryl 지원 창의 **하단 경계** — Cobblemon 1.21.1과의 Fabric API gap이 최소, mixin 표적 재작성량 적음. C1 mitigation M1과 결합 시 가장 작은 호환 거리 ([UNVERIFIED] V13/V14) |

## D2. Loader
| code | value | rationale |
|---|---|---|
| l1 | **Fabric** | VulkanMod/Beryl/Cobblemon 모두 Fabric 지원 |
| l2 | **NeoForge + Sinytra Connector** | Fabric→NeoForge 브릿지, Create 호환에 유리 |
| l3 | **Quilt** | Fabric 호환 fork, VulkanMod 지원 |
| l4 | **Forge (legacy, 1.20.1)** | Create 공식·Cobblemon 1.20.1·PixelMon 같은 Forge 진영 모드를 단일 로더에 모을 수 있는 유일 경로. 단 **VulkanMod·Beryl은 Fabric-only** ([UNVERIFIED] V19)이므로 셰이더 축 충족 불가 → 본 챌린지의 60FPS+셰이더 요구와는 trade-off. 1.20.1 legacy 풀스택용 폴백 옵션. |

## D3. Shader Strategy
| code | value | rationale |
|---|---|---|
| s1 | **Beryl integrated pipeline** | VulkanMod 위 표준 |
| s2 | **Iris/OptiFine shader pack** | Sodium 필요, VulkanMod와 상호배타 |
| s3 | **Custom SPIR-V (VulkanModShader fork)** | 실험적 |
| s4 | **No shader (baseline)** | FPS 우선, "셰이더로" 요구 미충족 가능 |
| s5 | **Beryl을 타깃 버전으로 직접 포팅** | V28 이후 26.1에는 불필요. 1.20.1 back-port 같은 역포팅 실험용 축으로 강등 |

## D4. Label Bug Fix
| code | value | rationale |
|---|---|---|
| f1 | **nameplate render mixin에 depthTest 활성화** | 가장 표준적인 패치 |
| f2 | **렌더 전 raycast 가시성 체크** | 더 정확하나 비용 |
| f3 | **NameplateRenderer 자체 교체** | 침습적 |
| f4 | **외부 Fabric bugfix 모드 1종** | 빠르나 의존성 늘림 |
| f5 | **Cobblemon 업스트림 PR** | 24h 내 비현실적 |
| f6 | **EntityCulling 류 기존 모드의 라벨 culling 옵션 활성화** | EntityCulling (tr7zw)·Sodium의 entity-shadow/label-distance 옵션은 occlusion·distance 기반으로 nameplate 렌더를 억제할 수 있음 ([UNVERIFIED] V24). VulkanMod와의 호환은 별도 확인 필요. **벽 투과 자체를 픽스하지 않고 가려진 nameplate를 culling으로 숨기는 우회**라 "버그 픽스"의 정의에 따라 부분 인정/불인정 가능 (synthesis Q4와 연결). 코드 작성 0, 24h budget에 가장 가벼움. |

## D5. Create Integration (Optional)
| code | value | rationale |
|---|---|---|
| c0 | **Skip** | 핵심 목표에 집중 |
| c1 | **ZurrTum 비공식 Fabric 포트** | 1.21+ 시도, 26.1 미확정 |
| c2 | **Create Fly fork** | 일부 기능만 |
| c3 | **NeoForge 공식 Create + Sinytra Connector** | 가장 안정적, 단 로더 전환 비용 |
| c4 | **대체 모드(Industrial Revolution 등)** | 의미 차이 큼 |
| c5 | **Create 6.x 비공식 Fabric 포팅 추적 (대기)** | 공식 Create 6.x는 NeoForge 우선 — Fabric 측은 PR/branch 단위 실험만 산발적 ([UNVERIFIED] V25). 본 챌린지의 24h 윈도 내 안정 빌드 가능성 LOW. 추적 가치는 있으나 **수동 watch**로 분류 (c0=Skip의 한 변형). 의사결정 트리거: 1.21.x 안정 빌드가 modrinth에 게시되면 c1으로 격상. |
