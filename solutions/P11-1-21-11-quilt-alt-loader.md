# P11: 1.21.11 Quilt Alternative — (v2, l3, s1, f1, c0)

- **Tuple**: version=v2 (1.21.11), loader=l3 (Quilt), shader=s1 (Beryl integrated), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 45 / high 75 (P03와 동등 추정 — Quilt 자체 오버헤드는 미세)
- **Effort (24h budget)**: 8–14h (P03 + Quilt-Fabric 호환 검증)
- **Risk**: MEDIUM

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.11 | <https://minecraft.wiki> |
| Quilt Loader | 1.21.11 호환 | <https://quiltmc.org/> |
| QSL + QFAPI | 1.21.11 | <https://quiltmc.org/en/qsl/> |
| VulkanMod | 1.21.11 Fabric jar (Quilt가 Fabric 호환 — [UNVERIFIED] V26) | <https://modrinth.com/mod/vulkanmod> |
| Beryl | 1.21.11 Fabric jar | <https://modrinth.com/mod/beryl> |
| Cobblemon | 1.21.11 호환 빌드 ([UNVERIFIED] V04/V14) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 | — |

## Dependency Graph
```
MC 1.21.11 → Quilt Loader
              ├── QFAPI (Fabric API 호환 레이어)
              │    ├── VulkanMod (Fabric jar 그대로 동작 기대)
              │    │    └── Beryl
              │    └── Cobblemon (Fabric jar)
              └── Label-fix mixin
```
충돌·관문:
- Quilt는 Fabric의 superset을 표방 — Fabric jar이 대부분 동작한다고 알려져 있으나 **VulkanMod 같은 저수준 렌더 모드의 Quilt 호환은 사례별** ([UNVERIFIED] V26)
- 잠재적 이점: Quilt의 강화된 mixin 호환·entrypoint 메커니즘이 라벨 mixin 작성에서 약간의 도구상 이점

## Steps to Build (high-level, no code)
1. 1.21.11 + Quilt + QFAPI 베이스 부팅
2. VulkanMod Fabric jar 그대로 추가 → 부팅·렌더 회귀 확인
3. Beryl 추가 → P03와 동일 측정
4. Cobblemon 추가 → P03와 동일 측정
5. 라벨 mixin (Quilt mixin 진입점 시그니처)
6. 회귀 비교: P03와의 FPS·1% low 차이 측정

## Risks & Unknowns
- [UNVERIFIED] V26 — Quilt 위에서 VulkanMod·Beryl이 회귀 없이 동작?
- Cobblemon Quilt 진입점 호환 — 단순 Fabric jar 재사용 가능 여부
- "지정 스택" 정의에서 Quilt가 Fabric의 한 변종으로 인정되는지 (synthesis Q1)

## Falsification Test
**"VulkanMod·Beryl이 Quilt에서 부팅 자체에 실패하거나 P03 대비 5% 이상 FPS 손실 발생 시, 본 경로는 폐기 — P03 권장."**

## Sources
- <https://quiltmc.org/>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/cobblemon>
