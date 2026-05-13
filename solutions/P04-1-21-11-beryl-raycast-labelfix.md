# P04: 1.21.11 Beryl + Raycast Labelfix — (v2, l1, s1, f2, c0)

- **Tuple**: version=v2 (1.21.11), loader=l1 (Fabric), shader=s1 (Beryl integrated), labelfix=f2 (렌더 전 raycast 가시성 체크), create=c0 (Skip)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 40 / high 70 (raycast 비용으로 P03 대비 약간 하향)
- **Effort (24h budget)**: 10–14h (raycast mixin 구현 + 회귀 테스트)
- **Risk**: MEDIUM

## Stack
P03와 동일. 단 라벨 mixin 구현 방식만 변경.

| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.11 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.21.11 | <https://fabricmc.net/> |
| VulkanMod | 1.21.11 | <https://modrinth.com/mod/vulkanmod> |
| Beryl | 1.21.11 | <https://modrinth.com/mod/beryl> |
| Cobblemon | 1.21.11 호환 빌드 ([UNVERIFIED] V04/V14) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin (raycast 방식) | 자체 작성 | — |

## Dependency Graph
P03와 동일.
충돌·관문 차이: depth test 강제(f1)는 1차 광원 차폐만 처리하나, **반투명 블록(유리·물·잎)에서도 라벨이 가려져야 함**을 raycast(f2)로 충족 가능 → "벽 너머로 보이는 현상" 정의에 따라 f2가 더 엄격한 해석.

## Steps to Build (high-level, no code)
1. P03와 동일하게 1–4 단계 진행 (베이스라인·VulkanMod·Beryl·Cobblemon)
2. 라벨 mixin: `PokemonRenderer#renderLabel` 진입 시 player camera ↔ pokemon eye position 사이 `Level#clip(ClipContext)` 호출
3. `BlockHitResult.MISS`이면 vanilla 경로(또는 `enableDepthTest`), 그렇지 않으면 라벨 렌더 skip
4. 다수 포켓몬 환경에서 raycast 비용 측정 — 60FPS 마진 잠식이 의미 있으면 거리 컬링 추가
5. P03와 동일하게 회귀 측정

## Risks & Unknowns
- raycast가 매 프레임 N마리에 대해 호출되면 CPU 사이드 비용 증가 — 거리·시야각 컬링 필요
- 반투명 블록 통과 처리에서 vanilla 동작과 일관성 유지 필요
- [UNVERIFIED] Cobblemon 1.21.11 빌드 존재 (V04/V14)

## Falsification Test
**"P03 베이스라인 대비 FPS 하락이 15% 초과면 컬링 미적용 raycast는 비용 과다 — f1로 회귀."**

## Sources
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/cobblemon>
- <https://wiki.fabricmc.net/tutorial:mixin_introduction>
