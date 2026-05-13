# C2: Cobblemon Supported-Version Ceiling

- **Severity**: BLOCKING
- **Discovered**: iter#2
- **Status**: OPEN
- **Related Paths**: P01, P02, P03

## What

Cobblemon의 공식 Fabric 배포는 2026-05-12 재검증 기준 26.1.x를 제공하지 않는다[V04·V14]. strict 풀이에서 Beryl/VulkanMod 26.1.x 페어는 성립하지만[V28·V29], Cobblemon은 `1.21.1/main` 기반 코드를 26.1.x로 자체 포팅해야 한다.

## Why it matters

- 문제를 의도대로 풀려면 Cobblemon을 빼거나 버전을 낮출 수 없다.
- 26.1은 unobfuscated 전환 이후라 pre-26.1 mod는 최소 재컴파일과 mapping migration이 필요하다[V08].
- 따라서 현재 strict 경로의 1차 blocking은 C1이 아니라 C2다.

## Evidence

- Cobblemon Modrinth versions: <https://modrinth.com/mod/cobblemon/versions> [V04]
- Cobblemon GitLab branch/source 조사: <https://gitlab.com/cable-mc/cobblemon> [V14]
- Fabric/Minecraft 26.1 porting context [V08]

## Possible Mitigations

- **M1 — 자체 26.1.x mini-port**: main menu + Pokémon 1마리 spawn + renderer 정상까지 scope를 줄인다. P01 기본 경로.
- **M2 — 포팅 범위 축소**: worldgen, multiplayer, 부수 기능을 24h core 밖으로 둔다.
- **M3 — P03/P07 fallback 데모**: strict 실패 시 비교 자료로만 사용한다. 최종 답이 아니다.
- **M4 — config/label-only 우회 금지**: Cobblemon 자체가 26.1에서 동작해야 하므로 라벨만 고쳐서는 부족하다.

## Open Questions

- Cobblemon `main`이 26.1.x에 가장 가까운 branch인지, release branch가 더 나은지?
- Parchment 26.1.x 매핑이 충분한지, Mojang official fallback이 필요한지?
- renderer/registry/data codec 중 어느 영역이 6h gate를 넘기는가?

## Sources

- <https://modrinth.com/mod/cobblemon/versions>
- <https://gitlab.com/cable-mc/cobblemon>
- `state/verification.md` V04, V08, V14, V28, V29
