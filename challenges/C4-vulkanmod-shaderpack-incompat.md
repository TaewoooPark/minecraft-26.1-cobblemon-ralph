# C4: VulkanMod ↔ Iris/OptiFine Shader Pack Incompatibility

- **Severity**: HIGH
- **Discovered**: iter#4
- **Status**: OPEN
- **Related Paths**: P01–P12 (셰이더 축 전반)

## What
VulkanMod은 Minecraft의 **OpenGL 렌더 경로를 통째로 Vulkan으로 교체**한다. 반면 **Iris**와 **OptiFine**은 OpenGL 기반 셰이더팩(.zip — vsh/fsh GLSL) 로딩 메커니즘이다. 따라서 VulkanMod이 활성화된 인스턴스에서는 **Iris/OptiFine 셰이더팩이 직접 동작하지 않는다**[V06·V18]. "셰이더로" 요건 충족을 위한 일반적 경로(BSL, Complementary, ComplementaryReimagined, MakeUp-UltraFast 등)는 strict 스택에서 사용하지 않는다.

## Why it matters
- 셰이더 축(D2/shader)의 가능 옵션을 **Beryl 통합 파이프라인** + (가설적) **VulkanMod-native 셰이더 모드**로 좁힌다.
- 2026-05-12 재검증 기준 Beryl 26.1.x official jar가 확인되어[V28], strict 경로에서는 **Beryl 통합 파이프라인을 채택**한다.
- 출제자 의도가 "임의 Iris/OptiFine 셰이더팩 동작"이라면 VulkanMod 지정 스택과 충돌한다. 다만 문제에 Beryl이 명시되어 있으므로 기본 해석은 Beryl 인정이다.

## Evidence
- <https://github.com/xCollateral/VulkanMod> 및 공식 incompatibility discussion [V06·V18]
- <https://modrinth.com/mod/vulkanmod> — "Incompatibilities" 섹션
- question.md §2.2 — "Iris 호환 셰이더팩이 직접 동작하지 않음" 명시

## Possible Mitigations
- **M1 — Beryl 통합 파이프라인 채택**: VulkanMod 친화적 strict 경로. 26.1.x official jar가 확인되어 P01 기본값으로 승격[V28].
- **M2 — VulkanMod fork/compat layer**: Iris 호환 레이어를 Vulkan 측에 이식한 비공식 fork 존재 여부 조사 (V17 후보).
- **M3 — 셰이더 요건 재해석**: "셰이더"=시각적 셰이더 효과 정도로 완화 → Beryl 기본 파이프라인 사용으로 충족 인정 받기 (synthesis Q2).
- **M4 — Sodium+Iris 경로로 환승(셰이더 우선)**: VulkanMod을 포기하고 OpenGL→Metal 직행 경로 사용 → 단, 본 문제의 지정 스택을 이탈하므로 "스택 준수" 점수를 잃음.
- **M5 — Iris-on-Vulkan 실험 프로젝트**: Iris의 Vulkan backend 실험 PR(있다면) 확인 (V18 후보).

## Open Questions
- Beryl 외에 VulkanMod 위에서 충분히 안정적인 셰이더 효과를 제공하는 모드/패치가 있는가? (V12와 부분 중복)
- Iris-on-Vulkan 실험 코드/PR이 strict 품질 기준을 만족하는가?

## Sources
- <https://github.com/xCollateral/VulkanMod>
- <https://modrinth.com/mod/vulkanmod>
- <https://modrinth.com/mod/iris>
