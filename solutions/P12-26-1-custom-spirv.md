# P12: 26.1 + Custom SPIR-V — (v1, l1, s3, f1, c0)

- **Tuple**: version=v1 (MC 26.1), loader=l1 (Fabric 26.1), shader=s3 (Custom SPIR-V / VulkanModShader fork — 실험적), labelfix=f1 (depthTest mixin), create=c0 (Skip)
- **Status**: DEPRIORITIZED (실험 단계 — V28 이후 Beryl 26.1.x official jar가 확인되어 필요성이 크게 낮아짐)
- **Predicted FPS (M-chip)**: low 35 / high 60 (커스텀 셰이더 파이프라인 품질 미상)
- **Effort (24h budget)**: 20–35h (24h 초과 가능성 매우 큼)
- **Risk**: HIGH

## Stack
| Mod | Version | Source |
|---|---|---|
| Minecraft | 26.1 | <https://minecraft.wiki/w/Java_Edition_26.1> |
| Fabric Loader | 26.1 | <https://fabricmc.net/2026/03/14/261.html> |
| VulkanMod | 26.1.x (V03 VERIFIED) | <https://modrinth.com/mod/vulkanmod> |
| Custom SPIR-V 셰이더 모드 | VulkanMod fork / 자체 작성, SPIR-V binary 로딩 (V12 [UNVERIFIED]) | github 검색 |
| Cobblemon (포팅본) | 1.21.1 → 26.1 자체 포팅 | <https://modrinth.com/mod/cobblemon> |
| Label-fix mixin | 자체 작성 (26.1 unobfuscated 매핑) | — |

## Dependency Graph
```
MC 26.1 → Fabric 26.1
          ├── VulkanMod 26.1 (셰이더 hook 지점 노출 여부 확인 필요)
          │    └── Custom SPIR-V 모드 (VulkanMod의 render pass에 침투)
          ├── Cobblemon-26.1 (포팅 필요)
          └── Label-fix mixin
```
충돌·관문:
- Beryl 26.1.x official jar가 존재하므로[V28], 이 경로는 더 이상 C1 우회가 아니다. Beryl이 성능/호환성에서 실패할 때만 대체 실험으로 남긴다.
- 그래도 SPIR-V 컴파일러 (glslang) 통합, VulkanMod의 render pass 후킹은 비공개 API 영역 → 모드 작성자 협업 없이 24h는 비현실적
- C2(Cobblemon 26.1 부재) 비용은 P02와 동일하게 잔존

## Steps to Build (high-level, no code)
1. VulkanMod 26.1 단독 → 베이스라인
2. VulkanMod이 노출하는 render pass / post-process hook API 확인 (소스 읽기)
3. 가장 가벼운 셰이더 효과(fullscreen color grading + chromatic aberration 등) 1개를 SPIR-V로 작성 → 로딩 PoC
4. Cobblemon 26.1 포팅 (P01·P02와 동일 비용)
5. 라벨 mixin
6. FPS·시각 검증

## Risks & Unknowns
- [UNVERIFIED] V12 — VulkanMod 위의 셰이더 모드(Beryl 외) 사례
- VulkanMod이 외부 mod의 SPIR-V 주입 hook을 노출하지 않으면 본 경로 0 단계에서 실패
- 효과 품질이 Beryl 통합 파이프라인 대비 매우 제한적 → "셰이더로"의 의도와 거리

## Falsification Test
**"VulkanMod 소스에서 외부 셰이더 hook 지점이 1시간 안에 식별되지 않으면 본 경로 폐기. P01 strict의 기본 셰이더 전략은 Beryl native이며, P02/P03은 비교 fallback으로만 남긴다."**

## Sources
- <https://github.com/xCollateral/VulkanMod>
- <https://modrinth.com/mod/vulkanmod>
- <https://github.com/KhronosGroup/glslang>
