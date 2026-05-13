# P06: 1.21.1 Cobblemon-Native + Beryl? — (v3, l1, s1, f1, c0)

- **Tuple**: version=v3 (1.21.1), loader=l1 (Fabric), shader=s1 (Beryl integrated — **호환 불확실**), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT (수렴 시 BLOCKED 가능성 큼)
- **Predicted FPS (M-chip)**: low 50 / high 80 (Cobblemon 안정성 ↑, 단 Beryl 가용 시 한정)
- **Effort (24h budget)**: 6–10h (Cobblemon 포팅 없음 — 핵심 단축)
- **Risk**: MEDIUM (s1 가용성에 좌우)

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.1 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.21.1 빌드 | <https://fabricmc.net/> |
| VulkanMod | 1.21.1 빌드 ([UNVERIFIED] V13) | <https://modrinth.com/mod/vulkanmod> |
| Beryl | **1.21.1 빌드 부재 가능성 HIGH** — Beryl 지원이 1.21.9–1.21.11에 한정 (V02 VERIFIED) | <https://modrinth.com/mod/beryl> |
| Cobblemon | 1.21.1 공식 빌드 (V04, [UNVERIFIED] 최신본 범위) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 | — |

## Dependency Graph
```
1.21.1 Fabric → Fabric API
                ├── VulkanMod 1.21.1 빌드 (V13 검증 필요)
                │    └── Beryl 1.21.1 빌드 → **존재 안 할 가능성 매우 큼** (V02 근거)
                ├── Cobblemon 1.21.1 (공식 안정 — Cobblemon-native 핵심 이점)
                └── Label-fix mixin
```
**핵심 충돌**: Beryl이 1.21.1에서 제공되지 않으면 본 경로의 s1 축은 미충족 → s3(custom SPIR-V) 또는 s4(셰이더 포기)로 전환 필요. 사실상 본 경로는 "Cobblemon 안정성과 셰이더 가용성 사이의 트레이드오프 카드"로 기록됨.

## Steps to Build (high-level, no code)
1. 1.21.1 + Fabric + Cobblemon 베이스라인 측정 (가장 안정적인 Cobblemon 동작 확인)
2. VulkanMod 1.21.1 빌드 추가 (V13 결과에 따라)
3. **Beryl 1.21.1 가용성 결정 시점** — modrinth/github 확인
   - 가용 → 추가 후 P03와 유사한 진행
   - 부재 → 본 경로 BLOCKED 마킹, P09(s2: Iris) 또는 P03로 전환
4. 라벨 mixin (1.21.1 매핑)
5. FPS 측정

## Risks & Unknowns
- [UNVERIFIED] V13 — VulkanMod·Beryl의 1.21.1 빌드 가용성
- Beryl 부재 시 본 경로의 "셰이더 ON" 요건 미달
- 1.21.1과 1.21.11 사이 Fabric API 차이로 인한 mod 호환 변동

## Falsification Test
**"Beryl 1.21.1 빌드가 modrinth/github 어디에도 게시되어 있지 않다면, 본 경로는 1시간 안에 BLOCKED 처리 — P03(1.21.11)로 즉시 전환."**

## Sources
- <https://modrinth.com/mod/cobblemon>
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/vulkanmod>
- V02, V13 — state/verification.md
