# P02: 26.1 + Shader Skip — (v1, l1, s4, f1, c0)

- **Tuple**: version=v1 (MC 26.1), loader=l1 (Fabric 26.1), shader=s4 (No shader / baseline), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 75 / high 140 (셰이더 없음 → MoltenVK 경로만 부담)
- **Effort (24h budget)**: 6–10h (Cobblemon 포팅이 주요 비용)
- **Risk**: MEDIUM

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 26.1 | <https://minecraft.wiki/w/Java_Edition_26.1> |
| Fabric Loader | 26.1 | <https://fabricmc.net/2026/03/14/261.html> |
| Fabric API | 26.1 | <https://modrinth.com/mod/fabric-api> |
| VulkanMod | 26.1.x (V03 VERIFIED) | <https://modrinth.com/mod/vulkanmod> |
| Cobblemon (포팅본) | 1.21.1 → 26.1 자체 포팅 ([UNVERIFIED] V04/V14) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 | — |

## Dependency Graph
```
MC 26.1 → Fabric 26.1 → Fabric API
                       ├── VulkanMod (셰이더 미동반)
                       ├── Cobblemon-26.1 (포팅)
                       └── Label-fix mixin
```
충돌·관문:
- C1 회피: Beryl 미사용 → 26.1 셰이더 모드 호환 문제 사라짐
- C2 잔존: Cobblemon 26.1 부재 → 포팅 필수
- **셰이더 요건 비충족 위험** — 문제 본문이 "셰이더로"를 명시 → 본 경로는 출제 요건의 한 축 포기

## Steps to Build (high-level, no code)
1. 26.1 + Fabric + VulkanMod 빈 인스턴스에서 베이스라인 FPS 측정 (셰이더 X)
2. Cobblemon 1.21.1 → 26.1 포팅 (P01과 동일 작업, 단 Beryl 포팅이 빠져 가벼움)
3. 라벨 mixin (26.1 매핑) 작성
4. 포켓몬 다수 스폰 환경에서 FPS·1% low 측정
5. (선택) Beryl이나 대체 셰이더 모드가 26.1로 포팅될 때까지 본 경로를 "셰이더 OFF 기준선"으로 보고에 포함

## Risks & Unknowns
- 출제 요건 "셰이더로" 미충족 → synthesis Q2(셰이더 정의) 답변에 따라 무효 가능
- [UNVERIFIED] V04/V14 — Cobblemon 26.1 포팅 비용 추정 부정확
- C3(MoltenVK 오버헤드)는 잔존하지만 셰이더가 없어 마진 큼

## Falsification Test
**"Cobblemon 26.1 포팅 PoC가 4시간 안에 부팅 가능한 상태에 도달하지 못하면 P03/P06으로 전환."** 셰이더가 없으므로 60FPS 기준 통과 자체는 거의 확실 — 핵심 falsification은 Cobblemon 포팅 feasibility.

## Sources
- <https://minecraft.wiki/w/Java_Edition_26.1>
- <https://fabricmc.net/2026/03/14/261.html>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/cobblemon/versions>
