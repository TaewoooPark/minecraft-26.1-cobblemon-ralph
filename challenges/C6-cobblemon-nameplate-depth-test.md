# C6: Cobblemon Nameplate Depth-Test (Label-Through-Wall Bug)

- **Severity**: HIGH
- **Discovered**: iter#6
- **Status**: OPEN
- **Related Paths**: P01–P12 (labelfix 축 D4 전반)

## What

Cobblemon은 vanilla nameplate 렌더 경로를 그대로 쓰지 않고 `PokemonRenderer.renderNameTag`에서 자체 라벨을 그린다[V09]. 재검증 결과 핵심 원인은 `RenderSystem.disableDepthTest()` 호출보다 **`Font.DisplayMode.SEE_THROUGH` 라벨 draw path**일 가능성이 높다. 이 display mode는 벽 뒤 라벨을 보이게 만드는 vanilla nameplate 계열 동작과 맞물린다.

## Why it matters

- "Label Bug Fix"는 문제의 명시 요건이다.
- strict 경로에서는 Cobblemon을 26.1.x로 포팅하므로, 라벨 fix도 같은 포팅본 source에 넣는 것이 가장 단순하다.
- config로 라벨을 끄는 것은 회피이지 intended fix가 아니다[V22].

## Evidence

- Cobblemon source: `common/src/main/kotlin/com/cobblemon/mod/common/client/render/pokemon/PokemonRenderer.kt`
- V09: Cobblemon default level renderer가 vanilla/nameplate mod 경로를 우회함
- V22: `displayEntityNameLabel=false` 같은 config fallback은 존재하지만 depth fix 옵션은 아님

## Possible Mitigations

- **M1 — source patch (권장)**: `renderNameTag`의 `Font.DisplayMode.SEE_THROUGH` 호출을 제거하거나 `NORMAL`로 변경.
- **M2 — external mixin**: source patch를 분리해야 하면 `Font#drawInBatch`의 `DisplayMode` 인자를 `NORMAL`로 강제.
- **M3 — raycast guard**: 라벨 렌더 전 block occlusion 검사. 정확하지만 중복/회귀 위험이 있다.
- **M4 — config OFF**: `displayEntityNameLabel=false`. strict fix가 아니라 fallback 기록용.

## Open Questions

- 26.1.x 포팅 후 `Font#drawInBatch` descriptor와 `DisplayMode` 인자 index가 그대로 유지되는가?
- level label과 battle prompt label이 모두 같은 patch path를 통과하는가?
- source patch와 external mixin 중 제출/배포 형식상 어느 쪽을 요구받는가?

## Sources

- <https://gitlab.com/cable-mc/cobblemon>
- `state/verification.md` V09, V22, V23
- `playbook/03-label-fix.md`
