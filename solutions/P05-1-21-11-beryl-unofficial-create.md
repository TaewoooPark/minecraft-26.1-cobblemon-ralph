# P05: 1.21.11 Beryl + Unofficial Create Fabric — (v2, l1, s1, f1, c1)

- **Tuple**: version=v2 (1.21.11), loader=l1 (Fabric), shader=s1 (Beryl integrated), labelfix=f1 (depthTest mixin), create=c1 (ZurrTum 비공식 Fabric 포트)
- **Status**: DRAFT
- **Predicted FPS (M-chip)**: low 35 / high 65 (Create 청크 부하 가산)
- **Effort (24h budget)**: 12–18h (비공식 포트 호환 검증 + 디버깅)
- **Risk**: HIGH

## Stack
P03 베이스 + Create 비공식 포트.

| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.11 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.21.11 | <https://fabricmc.net/> |
| VulkanMod | 1.21.11 | <https://modrinth.com/mod/vulkanmod> |
| Beryl | 1.21.11 | <https://modrinth.com/mod/beryl> |
| Cobblemon | 1.21.11 호환 ([UNVERIFIED] V04/V14) | <https://modrinth.com/mod/cobblemon> |
| Create (비공식 Fabric 1.21.x) | ZurrTum/Create Fly 등 ([UNVERIFIED] V20) | github 검색 |
| Label-fix mixin | 자체 작성 | — |

## Dependency Graph
```
1.21.11 Fabric ──┬── VulkanMod ─── Beryl
                 ├── Cobblemon (KMP 기반 클라이언트)
                 ├── Create (비공식 포트, Forge 원본 → Fabric 어댑터)
                 └── Label-fix mixin
```
충돌·관문:
- 비공식 Create 포트는 Forge-only API(IForgeRegistries, capabilities)에 의존했을 가능성 → Forgified-Fabric-API 같은 호환 레이어 필요할 수 있음 ([UNVERIFIED] V20)
- Create 청크 시뮬레이션 + Beryl 셰이더 + Cobblemon 엔티티 다수 → CPU/GPU 양쪽 부하 가산
- VulkanMod이 Create의 일부 렌더(Belt, contraption assembly)에서 회귀 일으킬 가능성 — 알려진 사례 [UNVERIFIED]

## Steps to Build (high-level, no code)
1. P03 베이스 완성 (1.21.11 + VulkanMod + Beryl + Cobblemon)
2. 비공식 Create Fabric 포트 1.21.x 빌드 식별 → 단독 부팅 확인
3. P03 베이스에 추가 → modlist 충돌 해결 (Forgified-Fabric-API, Connector 우회 등)
4. Create kinetic 네트워크 가동 씬 + 포켓몬 다수 환경 동시 부하 측정
5. 라벨 mixin은 P03와 동일

## Risks & Unknowns
- [UNVERIFIED] V20 — 1.21.11에 맞는 비공식 Create 포트 안정 빌드 존재 여부
- VulkanMod이 Create contraption 렌더에서 visual artifact 일으킬 가능성 ([UNVERIFIED])
- 60FPS 마진이 Create 부하로 잠식되어 옵션 다이얼 다운 불가피할 수 있음

## Falsification Test
**"비공식 Create 포트가 P03 베이스에 추가된 직후 부팅 크래시 또는 30분 안에 modlist 호환 해결 불가면 본 경로 폐기, P03 유지."**

## Sources
- <https://modrinth.com/mod/create/versions>
- <https://modrinth.com/mod/beryl>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/cobblemon>
