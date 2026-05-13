# Playbook 03 — Label Fix (Cobblemon Nameplate Depth)

> Phase 2 / Step 3. 포켓몬 이름표가 벽 너머로 보이는 현상을 수정한다.
> strict 경로에서는 Cobblemon 26.1.x 포팅본에 **source patch**를 적용하는 것을 1순위로 둔다.

---

## 0. Target

파일:

```text
common/src/main/kotlin/com/cobblemon/mod/common/client/render/pokemon/PokemonRenderer.kt
```

핵심 메서드:

| 메서드 | 역할 | 수정 여부 |
|---|---|---|
| `shouldShowName(entity)` | vanilla nameplate 우회 | 비대상 |
| `shouldRenderLabel(entity)` | crouch, line-of-sight, config 검사 | 보조 |
| `renderNameTag(...)` | 실제 Cobblemon 라벨 렌더 | **주 대상** |

확인된 원인:

- Cobblemon은 vanilla nameplate를 쓰지 않고 자체 `renderNameTag`를 그린다[V09].
- `Font#drawInBatch` 호출에서 `Font.DisplayMode.SEE_THROUGH`를 사용하면 depth test를 우회해 벽 뒤 라벨이 보인다.
- 따라서 단순 `RenderSystem.enableDepthTest()`보다 **`SEE_THROUGH -> NORMAL` 변경**이 더 정확하다.

---

## 1. Strategy

| 옵션 | 방법 | strict 적합도 | 비고 |
|---|---|---|---|
| **f1a source patch** | Cobblemon 포팅본에서 `SEE_THROUGH`를 `NORMAL`로 변경 | **최상** | P01 기본값 |
| **f1b external mixin** | 포팅본을 건드리지 않고 `Font.DisplayMode` 인자만 `NORMAL` 강제 | 높음 | 배포 분리용 fallback |
| f2 raycast | label render 전에 block occlusion 검사 | 보조 | 비용·회귀 가능성 증가 |
| f-fallback config OFF | `displayEntityNameLabel=false` | 낮음 | fix가 아니라 회피[V22] |

---

## 2. Source Patch

Cobblemon 26.1.x 포팅 과정에서 `PokemonRenderer.kt`의 `renderNameTag`를 찾는다.

패치 방향:

```diff
-Font.DisplayMode.SEE_THROUGH
+Font.DisplayMode.NORMAL
```

main label과 battle prompt label 모두 같은 원칙을 적용한다. 기존 코드가 두 번 그리는 구조라면 `SEE_THROUGH` pass를 제거하거나 `NORMAL`로 바꿔 한 가지 depth-aware path만 남긴다.

통과 기준:

- 시야가 열려 있으면 라벨이 정상 표시된다.
- 3블록 흙벽 뒤에서는 라벨이 보이지 않는다.
- level label과 challenge prompt도 동일하게 depth-aware다.

---

## 3. External Mixin Fallback

source patch를 분리해야 할 때만 별도 mod를 만든다.

`fabric.mod.json`의 Minecraft 범위는 strict에 맞춘다.

```json
{
  "schemaVersion": 1,
  "id": "cobblemon_label_fix",
  "version": "0.1.0",
  "name": "Cobblemon Label Fix",
  "depends": {
    "fabricloader": ">=0.17.0",
    "minecraft": "~26.1",
    "cobblemon": ">=1.8.0"
  },
  "mixins": ["cobblemon-label-fix.mixins.json"],
  "license": "MIT"
}
```

Mixin 의사 코드:

```java
@Mixin(targets = "com.cobblemon.mod.common.client.render.pokemon.PokemonRenderer", remap = false)
public abstract class PokemonRendererMixin {
    @ModifyArg(
        method = "renderNameTag*",
        at = @At(
            value = "INVOKE",
            target = "Lnet/minecraft/client/gui/Font;drawInBatch(...)I"
        ),
        index = 7
    )
    private Font.DisplayMode forceDepthTest(Font.DisplayMode original) {
        return Font.DisplayMode.NORMAL;
    }
}
```

실제 target descriptor와 index는 26.1.x 포팅본 bytecode에서 `javap -p -s`로 확인한다.

---

## 4. Visual Verification

1. 26.1.x + VulkanMod + Beryl + Cobblemon 포팅본 + label fix로 부팅
2. 평지 월드 진입
3. Pokémon 1마리 spawn
4. 플레이어와 Pokémon 사이에 3블록 두께 흙벽 배치
5. 벽 뒤에서 라벨이 보이지 않는지 캡처
6. 벽을 치우거나 모서리로 이동했을 때 라벨이 다시 보이는지 캡처

회귀 체크:

- battle prompt label
- level label
- vanilla player nameplate에는 영향 없음

---

## 5. PASS Conditions

1. source patch 또는 mixin build 성공
2. critical mixin failure 0건
3. 벽 뒤 라벨 미노출
4. 정상 시야 라벨 노출
5. before/after screenshot 2장 이상

---

## 6. Failure Handling

| 실패 | 처리 |
|---|---|
| `drawInBatch` descriptor 불일치 | 26.1.x bytecode에서 descriptor 재추출 |
| 라벨이 완전히 사라짐 | `SEE_THROUGH` pass 제거 범위가 과도한지 확인 |
| source patch가 다른 렌더 경로를 깨뜨림 | 외부 mixin fallback으로 분리 |
| 60분 내 fix 실패 | config OFF를 비의도 fallback으로 기록하고 strict 미완으로 표기 |

---

## Sources

- Cobblemon `PokemonRenderer.kt`: <https://gitlab.com/cable-mc/cobblemon>
- Cobblemon config nameplate options: V22
- Globox/Nameplate issue context: V09·V23
- 본 playbook: `02-cobblemon-port.md`, `04-shader-tuning.md`, `05-fallback-tree.md`
