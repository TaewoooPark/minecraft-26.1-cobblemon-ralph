# P01: 26.1 Strict + Beryl Native — (v1, l1, s1, f1, c0)

- **Tuple**: version=v1 (MC 26.1.x), loader=l1 (Fabric), shader=s1 (Beryl integrated native 26.1.x), labelfix=f1 (Cobblemon source patch 또는 외부 mixin), create=c0 (Skip)
- **Status**: OPTIMAL_CANDIDATE
- **Predicted FPS (M-chip)**: 45–75 (Beryl alpha + Cobblemon entity load 실측 필요)
- **Effort (24h budget)**: 8–16h
- **Risk**: HIGH

## Stack

| Mod | Version | Source / 검증 |
|---|---|---|
| Minecraft | 26.1.x, 권장 26.1.2 | <https://minecraft.wiki/w/Java_Edition_26.1> |
| Fabric Loader | 26.1.x 호환 최신 | <https://fabricmc.net/use/installer/> |
| Fabric API | 26.1.x 호환 최신 | <https://modrinth.com/mod/fabric-api> |
| VulkanMod | `VulkanMod_26.1.2-0.6.5.jar`, SHA512 prefix `437bb0e4ba7d5873` | V29 |
| Beryl | `beryl_26.1.2-0.1.3-alpha+1.jar`, SHA512 prefix `584f2cf5783ee5e5a` | V28 |
| Cobblemon | 1.21.1/main 기반 → 26.1.x 자체 포팅 | V04·V14 |
| Label fix | Cobblemon 포팅본 source patch 우선, 외부 mixin fallback | V09·V22 |

## Dependency Graph

```text
MC 26.1.x unobfuscated -> Fabric 26.1.x
  ├─ VulkanMod 0.6.5 native 26.1.2
  │   └─ Beryl 0.1.3-alpha+1 native 26.1.2
  ├─ Cobblemon 26.1.x self-port
  │   └─ source label fix: SEE_THROUGH -> NORMAL
  └─ optional label-fix mixin if source patch is kept separate
```

결정적 변화:

- Beryl 26.1 포팅은 더 이상 필요하지 않다[V28].
- strict 병목은 Cobblemon 포팅과 라벨 렌더 경로 patch다[V04·V14·V09].
- Iris/Sodium/OptiFine/EntityCulling은 VulkanMod 공식 비호환 목록 때문에 제외한다[V06·V18·V24].

## Build Gates

1. **Baseline**: 26.1.2 + Fabric + VulkanMod + Beryl만 설치해 빈 월드 60FPS 이상.
2. **Cobblemon port**: `./gradlew :fabric:build` 성공, main menu 진입, Pokémon 1마리 spawn.
3. **Label fix**: `PokemonRenderer.renderNameTag`에서 `Font.DisplayMode.SEE_THROUGH` 호출을 제거하거나 `NORMAL`로 강제.
4. **Integration**: shader ON + Cobblemon 5마리 + 벽 뒤 라벨 미노출 + 평균 60FPS.

## Risks & Unknowns

- Cobblemon `1.21.1 → 26.1.x` 포팅은 RenderState, registry, data codec 차이가 크다[V08·V14].
- Beryl은 alpha라 Cobblemon 커스텀 모델/텍스처와의 렌더 회귀가 있을 수 있다[V28].
- label fix를 외부 mixin으로 분리하면 26.1.x 매핑과 Cobblemon 포팅본 클래스명에 맞춰 재타겟해야 한다.

## Falsification Test

30분 안에 Beryl/VulkanMod 26.1.2 baseline이 60FPS를 못 넘기거나, 6시간 안에 Cobblemon 26.1.x 포팅본이 Pokémon 1마리 spawn까지 못 가면 strict 완성 실패로 기록한다. 이 경우 P03/P07/P10은 비교 데모로만 산출하고, P01의 대체 합격으로 쓰지 않는다.

## Sources

- <https://minecraft.wiki/w/Java_Edition_26.1>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/cobblemon>
- <https://docs.fabricmc.net/develop/porting/>
- `state/verification.md` V04, V08, V09, V14, V28, V29
