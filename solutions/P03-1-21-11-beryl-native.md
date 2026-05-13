# P03: 1.21.11 Beryl-Native — (v2, l1, s1, f1, c0)

- **Tuple**: version=v2 (1.21.11), loader=l1 (Fabric), shader=s1 (Beryl integrated), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 45 / high 75 (M3+ 기준 추정, [UNVERIFIED])
- **Effort (24h budget)**: 8–12h (Cobblemon 1.21.11 호환이 가장 큰 변수)
- **Risk**: MEDIUM

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.11 | <https://minecraft.wiki> |
| Fabric Loader | 1.21.11 호환 최신 | <https://fabricmc.net/> |
| Fabric API | 1.21.11 빌드 | <https://modrinth.com/mod/fabric-api> |
| VulkanMod | 1.21.11 빌드 | <https://modrinth.com/mod/vulkanmod> |
| Beryl | 1.21.11 빌드 | <https://modrinth.com/mod/beryl> |
| Cobblemon | 최신 + 1.21.11 호환 빌드 ([UNVERIFIED] V04/V14) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin mod | 자체 작성 | — |

## Dependency Graph
```
Fabric Loader → Fabric API
                ├── VulkanMod (Sodium 대체 — Sodium 동시 설치 금지 [UNVERIFIED] V10)
                │    └── Beryl (VulkanMod 필요)
                ├── Cobblemon (Fabric API 필요)
                └── Label-fix mixin (Cobblemon target)
```
충돌 지점:
- VulkanMod ↔ Sodium/Indium/Embeddium 상호배타 ([UNVERIFIED] V10/V18)
- VulkanMod ↔ Iris 셰이더팩 ([UNVERIFIED] V06) → 본 경로는 Beryl만 사용하므로 회피
- Cobblemon 1.21.11 빌드 부재 시 → 자체 포팅 또는 P02/P06으로 전환

## Steps to Build (high-level, no code)
1. Vanilla 1.21.11 인스턴스 → Fabric Loader 설치 → 베이스라인 FPS 측정
2. VulkanMod 단독 추가 → MoltenVK 경로 확인, FPS 재측정
3. Beryl 추가 → 셰이더 ON FPS 측정 (목표 60FPS 마진 평가)
4. Cobblemon 1.21.11 호환 빌드 탐색 → 미존재 시 1.21.1 → 1.21.11 포팅 (entity registry · data fixer · KMP 의존성 매핑)
5. 라벨 mixin 모드 작성: `PokemonRenderer#renderLabel`에 `RenderSystem.enableDepthTest()` 강제
6. 포켓몬 다수 스폰 + 실내/외 씬에서 FPS·1% low 측정, 4 단계로 회귀

## Risks & Unknowns
- [UNVERIFIED] Cobblemon 1.21.11 빌드 자체 존재 여부 (V04/V14) — 부재 시 본 경로 effort 2배
- [UNVERIFIED] Beryl 1.21.11에서 macOS/MoltenVK 안정성 (V11/V15)
- [UNVERIFIED] VulkanMod ↔ Beryl 최신 버전 페어링이 1.21.11에서 회귀 없는지 (V03/V02)
- MoltenVK 오버헤드 (C3) — 셰이더 ON 60FPS 마진 잠식

## Falsification Test
**"30분 안에 vanilla 1.21.11 + Fabric + VulkanMod + Beryl 빈 월드에서 60FPS 미달이면 경로 폐기"** — Cobblemon 미설치 베이스라인이 60FPS 못 넘기면 Cobblemon·라벨픽스 추가 후엔 더더욱 불가능.

## Sources
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/cobblemon>
- <https://github.com/xCollateral/VulkanMod/discussions/389>
