# P07: 1.21.1 + Iris (No VulkanMod) — (v3, l1, s2, f1, c0)

- **Tuple**: version=v3 (1.21.1), loader=l1 (Fabric), shader=s2 (Iris/OptiFine 셰이더팩), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 55 / high 90 (Sodium+Iris의 OpenGL→Metal 직행 — MoltenVK 우회로 셰이더 ON에서 가장 안정적 FPS 후보)
- **Effort (24h budget)**: 4–8h (모드 모두 공식 1.21.1 빌드 존재, 포팅 불필요)
- **Risk**: LOW (단 "지정 스택 미준수" 페널티 가능)

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.1 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.21.1 | <https://fabricmc.net/> |
| Sodium | 1.21.1 (MC 1.21.1 latest) | <https://modrinth.com/mod/sodium> |
| Iris Shaders | 1.21.1 | <https://modrinth.com/mod/iris> |
| 셰이더팩 | Complementary Reimagined / BSL / MakeUp-UltraFast 중 1 | <https://modrinth.com/shaders> |
| Cobblemon | 1.21.1 공식 | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 | — |

## Dependency Graph
```
1.21.1 Fabric → Fabric API
                ├── Sodium ─── Iris (Sodium 필요)
                │              └── 셰이더팩 (.zip)
                ├── Cobblemon 1.21.1 (안정)
                └── Label-fix mixin
```
충돌·관문:
- **본 문제 스택의 VulkanMod·Beryl을 사용하지 않음** → 출제 지정 스택 미준수 (synthesis Q1·Q2와 결합 평가 필요)
- 다만 Sodium+Iris 경로는 macOS에서 **MoltenVK 우회**가 가능 → C3(MoltenVK 오버헤드) 완전 회피, M-chip Mac에서 셰이더 ON 60FPS 도달 가능성 가장 높음

## Steps to Build (high-level, no code)
1. 1.21.1 + Fabric + Sodium 베이스라인 측정
2. Iris + 가벼운 셰이더팩(MakeUp-UltraFast / Complementary Unbound) 추가 → 60FPS 마진 확인
3. Cobblemon 1.21.1 추가 → 포켓몬 다수 스폰 부하 측정
4. 라벨 mixin (1.21.1 매핑)
5. 무거운 셰이더팩(Complementary Reimagined, BSL)로 상한 평가

## Risks & Unknowns
- 출제 지정 "VulkanMod + Beryl" 미준수 → **점수 페널티 가능성** (synthesis Q1로 확인 필요)
- Cobblemon 엔티티 다수 + 셰이더 → entity shadow 비용 → "Shadow distance" 조절 필요
- Sodium의 entity_shadow culling이 nameplate 가시성과 상호작용 가능 ([UNVERIFIED] V24와 부분 중복)

## Falsification Test
**"본 경로의 비교 가치는 P03와의 60FPS 마진 차이. P03가 60FPS를 안정적으로 못 넘기는 경우의 fallback 추천 경로로 보고에 포함."**

## Sources
- <https://modrinth.com/mod/sodium>
- <https://modrinth.com/mod/iris>
- <https://modrinth.com/mod/cobblemon>
- <https://modrinth.com/shaders>
