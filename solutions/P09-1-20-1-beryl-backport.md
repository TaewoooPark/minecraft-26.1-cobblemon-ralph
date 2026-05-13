# P09: 1.20.1 + Beryl Back-Port — (v4, l1, s1, f1, c0)

- **Tuple**: version=v4 (1.20.1), loader=l1 (Fabric), shader=s1 (Beryl integrated, back-ported from 1.21.x), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DRAFT (back-port 가능성 LOW)
- **Predicted FPS (M-chip)**: low 50 / high 85 (1.20.1 자체 부하가 가벼움, 단 back-port 품질 변수)
- **Effort (24h budget)**: 20–30h (back-port 작업 비용 큼 — 24h 초과 가능성 HIGH)
- **Risk**: HIGH

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 1.20.1 | <https://minecraft.wiki> |
| Fabric Loader + API | 1.20.1 안정 빌드 (long-tail support) | <https://fabricmc.net/> |
| VulkanMod | 1.20.x 빌드 (V03 — VulkanMod 1.20.x 지원 확인됨) | <https://modrinth.com/mod/vulkanmod> |
| Beryl (back-port) | 1.21.11 → 1.20.1 자체 back-port ([UNVERIFIED] V11) | <https://modrinth.com/mod/beryl> |
| Cobblemon | 1.20.1 공식 빌드 (V04 명시) | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 (1.20.1 매핑) | — |

## Dependency Graph
```
MC 1.20.1 Fabric → Fabric API
                   ├── VulkanMod 1.20.x (공식 지원)
                   │    └── Beryl 1.20.1 (없음 → back-port 필요)
                   ├── Cobblemon 1.20.1 (안정)
                   └── Label-fix mixin
```
충돌·관문:
- VulkanMod·Cobblemon 둘 다 1.20.1 안정 빌드 보유 — 본 라인의 강점
- 그러나 Beryl이 1.21.x 라인부터 등장 → 1.20.1로의 back-port는 forward port와 다르게 (a) 신규 Vulkan 디스크립터 모델, (b) 신규 셰이더 stage 등에 1.20.1 시점의 vanilla 한계가 작용 → 작업량 큼

## Steps to Build (high-level, no code)
1. 1.20.1 + Fabric + Cobblemon 안정 베이스라인 측정 → 셰이더 없이 60FPS 마진 확인
2. VulkanMod 1.20.x 추가 → MoltenVK 경유 FPS 측정
3. **Beryl 1.21.11 소스 → 1.20.1 back-port 작업 (가장 큰 비용)**: Vulkan 추상화 레이어 차이, GUI 코드, resource pack 포맷 차이 흡수
4. 라벨 mixin (1.20.1 매핑)
5. FPS 측정

## Risks & Unknowns
- [UNVERIFIED] V11 — Beryl back-port 시도/PR 존재 가능성 매우 낮음
- back-port 동안 셰이더 스테이지 미발현·crash 빈발 가능성
- 24h 윈도 초과 가능성 HIGH — Beryl forward port와 동급의 난이도

## Falsification Test
**"베이스라인(1단계) FPS가 P03 베이스라인 대비 ≥10% 우위가 아니면 back-port의 ROI 없음 — 본 경로 폐기, P03 유지."**

## Sources
- <https://modrinth.com/mod/cobblemon>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/beryl>
