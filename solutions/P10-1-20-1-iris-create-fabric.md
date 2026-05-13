# P10: 1.20.1 + Iris + Official Create Fabric — (v4, l1, s2, f1, c1*)

- **Tuple**: version=v4 (1.20.1), loader=l1 (Fabric), shader=s2 (Iris/OptiFine 셰이더팩), labelfix=f1 (depthTest mixin), create=c1 (Create Fabric **공식** 1.20.1 빌드)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 50 / high 90 (MoltenVK 우회 + 1.20.1 자체 가벼움)
- **Effort (24h budget)**: 4–8h (모든 모드 공식 1.20.1 빌드 존재 — 포팅 0)
- **Risk**: LOW (단 "지정 스택 미준수" 페널티 + 26.1 미일치)

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.20.1 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.20.1 LTS 빌드 | <https://fabricmc.net/> |
| Sodium | 1.20.1 | <https://modrinth.com/mod/sodium> |
| Iris Shaders | 1.20.1 | <https://modrinth.com/mod/iris> |
| 셰이더팩 | Complementary Reimagined / Photon / MakeUp-UltraFast | <https://modrinth.com/shaders> |
| Cobblemon | 1.20.1 공식 (V04 명시) | <https://modrinth.com/mod/cobblemon> |
| Create Fabric | **공식 1.20.1 빌드** (Fabric 포트가 정체된 위치 — 본 경로의 핵심 이점, [UNVERIFIED] V05) | <https://modrinth.com/mod/create-fabric> |
| Label-fix mixin | 자체 작성 (1.20.1 매핑) | — |

## Dependency Graph
```
MC 1.20.1 Fabric ─── Fabric API
                     ├── Sodium ── Iris ── 셰이더팩
                     ├── Cobblemon 1.20.1 (안정 LTS)
                     ├── Create Fabric 1.20.1 (공식 빌드)
                     └── Label-fix mixin
```
충돌·관문:
- 모든 4축이 공식 빌드로 결합 가능한 **유일한 LTS 라인** — 포팅·비공식 의존성 0
- 단 본 문제 지정 스택(VulkanMod·Beryl·26.1)을 **전혀** 따르지 않음 → synthesis Q1·Q2 답변에 따라 무효 가능
- "Create + Fabric 없음" 문구는 1.21+ 시점의 사실 — 1.20.1로 후퇴하면 공식 Create Fabric 존재 가능성 큼 ([UNVERIFIED] V05 정확 확인 필요)

## Steps to Build (high-level, no code)
1. 1.20.1 + Fabric + Sodium 베이스 측정 → vanilla M-chip 60FPS 마진 확인
2. Iris + 가벼운 셰이더팩 추가 → 셰이더 ON FPS 측정
3. Cobblemon 1.20.1 + Create Fabric 1.20.1 추가
4. 라벨 mixin (1.20.1 매핑)
5. Create 자동화 + 포켓몬 다수 부하 동시 측정 — 1% low까지 확인
6. 셰이더팩 단계적 상향(Photon 등)으로 상한 평가

## Risks & Unknowns
- 출제 지정 스택 미준수 → Q1/Q2 결과로 페널티 또는 실격 가능
- [UNVERIFIED] V05 — Create Fabric 1.20.1 공식 빌드의 정확한 최신 버전·안정성
- Cobblemon 1.20.1 ↔ Create 1.20.1 사이 알려진 충돌이 있는가? ([UNVERIFIED])

## Falsification Test
**"본 경로는 'all-official LTS 안전망'이다. 출제자가 Q1에서 '26.1 강제'를 확정하면 본 경로는 무효 — synthesis에서 fallback 카드로만 보고에 포함."**

## Sources
- <https://modrinth.com/mod/sodium>
- <https://modrinth.com/mod/iris>
- <https://modrinth.com/mod/cobblemon>
- <https://modrinth.com/mod/create-fabric>
- <https://modrinth.com/shaders>
