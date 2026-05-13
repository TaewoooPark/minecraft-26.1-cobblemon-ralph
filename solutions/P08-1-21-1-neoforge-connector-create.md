# P08: 1.21.1 NeoForge + Sinytra Connector + Official Create — (v3, l2, s1, f1, c3)

- **Tuple**: version=v3 (1.21.1), loader=l2 (NeoForge + Sinytra Connector), shader=s1 (Beryl via Connector — **호환 미보장**), labelfix=f1 (depthTest mixin), create=c3 (NeoForge 공식 Create)
- **Status**: DRAFT (Connector-Beryl 결합이 가장 큰 미지수)
- **Predicted FPS (M-chip)**: low 35 / high 70 (Connector 변환 비용 + Create 청크 부하)
- **Effort (24h budget)**: 14–20h (다층 호환 검증)
- **Risk**: HIGH

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.21.1 | <https://minecraft.wiki> |
| NeoForge | 1.21.1 빌드 | <https://neoforged.net/> |
| Sinytra Connector | 1.21.1 빌드 ([UNVERIFIED] V21 — 1.21.1 지원 검증) | <https://github.com/Sinytra/Connector> |
| Forgified Fabric API | 1.21.1 빌드 | <https://github.com/Sinytra/ForgifiedFabricAPI> |
| VulkanMod (Fabric → Connector) | 1.21.1 빌드 ([UNVERIFIED] V13) | <https://modrinth.com/mod/vulkanmod> |
| Beryl (Fabric → Connector) | **1.21.1 빌드 부재 가능성 HIGH** (V02) | <https://modrinth.com/mod/beryl> |
| Cobblemon (NeoForge 빌드) | 1.21.1 | <https://modrinth.com/mod/cobblemon> |
| Create (NeoForge 공식) | 1.21.1 빌드 | <https://modrinth.com/mod/create> |
| Label-fix mixin | 자체 작성 (NeoForge target) | — |

## Dependency Graph
```
NeoForge 1.21.1
 ├── Sinytra Connector
 │    └── Forgified Fabric API
 │         ├── VulkanMod (Fabric→NeoForge 변환)
 │         │    └── Beryl (1.21.1 부재 → Connector도 못 살림)
 │         └── (Cobblemon Fabric 빌드도 가능하나 NeoForge 네이티브 빌드 우선)
 ├── Cobblemon (NeoForge native)
 ├── Create (NeoForge native)
 └── Label-fix mixin
```
충돌·관문:
- **Create+Cobblemon 동시 안정 가용성**이 가장 큰 매력. NeoForge 진영에서 1.21.1 두 모드 모두 공식 빌드 존재 가능성 큼 (검증 필요).
- 단, VulkanMod·Beryl이 Fabric-only ([UNVERIFIED] V19)라 Connector를 통한 변환이 필수 — **이 결합은 사용 사례가 거의 없음**, 안정성 미상.
- Beryl 1.21.1 부재 시 → s5(포팅) 또는 s2(Iris)로 즉시 변경 필요.

## Steps to Build (high-level, no code)
1. NeoForge 1.21.1 + Sinytra Connector + Forgified Fabric API 베이스 부팅
2. Cobblemon(NeoForge) + Create(NeoForge) 단독 부팅 확인 → C5의 Optional 트랙 충족
3. VulkanMod Fabric jar을 Connector 경유로 로드 시도 → 부팅 성공 여부가 본 경로 생사
4. Beryl 1.21.1 가용성 확인 (부재면 P09/P03로 전환)
5. 라벨 mixin (NeoForge target — fabric-loom 미사용 빌드 환경)
6. Create 자동화 가동 + 포켓몬 환경 동시 부하 측정

## Risks & Unknowns
- [UNVERIFIED] V19/V21 — VulkanMod Fabric jar이 Connector를 통해 동작한다는 보고 사례
- Sinytra Connector + VulkanMod 결합은 **희귀 사례** — 재현 자료 부족
- Beryl 1.21.1 부재 (V02 근거상 가능성 매우 큼)

## Falsification Test
**"NeoForge + Connector + VulkanMod 단독 부팅이 2시간 안에 성공하지 못하면 본 경로 폐기, P07로 전환."**

## Sources
- <https://neoforged.net/>
- <https://github.com/Sinytra/Connector>
- <https://github.com/Sinytra/ForgifiedFabricAPI>
- <https://modrinth.com/mod/cobblemon>
- <https://modrinth.com/mod/create>
