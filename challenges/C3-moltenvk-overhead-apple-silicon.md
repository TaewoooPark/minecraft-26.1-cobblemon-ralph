# C3: MoltenVK Translation Overhead on Apple Silicon

- **Severity**: HIGH
- **Discovered**: iter#3
- **Status**: OPEN
- **Related Paths**: P01–P12 (모든 경로 — 플랫폼 공통)

## What
Apple Silicon Mac에는 **네이티브 Vulkan 드라이버가 없다**. VulkanMod이 호출하는 Vulkan API는 macOS에서 **MoltenVK**(Vulkan → Metal MSL 변환 레이어)를 통해 **Metal 백엔드로 재해석**된다. 이 변환은 (1) SPIR-V → MSL 셰이더 컴파일 비용, (2) Vulkan↔Metal 동기화·디스크립터 모델 차이, (3) 일부 미지원 Vulkan 확장 의존 모드에서의 fallback 비용을 발생시킨다. 결과적으로 동일 GPU에서 네이티브 Metal 경로(예: 기본 OpenGL→Metal 또는 미래의 Sodium-Metal) 대비 **프레임 시간 오버헤드**가 누적될 수 있다.

## Why it matters
- "M-chip Mac에서 60FPS" 목표는 **MoltenVK 오버헤드의 상한**에 직접적으로 좌우된다.
- VulkanMod이 Iris/OptiFine 셰이더와 호환되지 않으므로 ([UNVERIFIED] V06), **셰이더 ON 상태에서 GPU 부담이 가산**되어 60FPS 마진을 잠식할 수 있음.
- M1 vs M3 vs M4 칩별 Metal 드라이버·통합 GPU 성능 차이는 **출제자가 어느 칩을 가정했는지에 따라** 추천 경로가 달라짐 (synthesis OpenQuestion 후보).

## Evidence
- <https://github.com/KhronosGroup/MoltenVK> — MoltenVK는 macOS/iOS의 Vulkan-on-Metal 구현체, performance section에 변환 비용 기재
- <https://github.com/xCollateral/VulkanMod/discussions/389> — VulkanMod macOS 사용자 토론(질문에서 인용)
- question.md §2.2 — macOS에서 MoltenVK 자동 사용 명시 ([UNVERIFIED] V07)

## Possible Mitigations
- **M1 — MoltenVK 빌드 최적화**: 최신 MoltenVK 릴리스를 번들 (`MVK_CONFIG_*` 환경 변수로 prefilled pipeline, async shader compile 활성).
- **M2 — Vulkan feature surface 최소화**: VulkanMod·Beryl 옵션에서 MoltenVK 미지원 또는 비싼 확장(geometry shader, multi-draw indirect 등) 회피.
- **M3 — 셰이더 품질 다이얼 다운**: Beryl 통합 파이프라인의 reflection/SSAO/shadow 캐스케이드 등 GPU-heavy 패스 옵션 조정.
- **M4 — 측정 후 결정**: 24h 플랜의 (0–1h) 베이스라인 측정에서 MoltenVK 단독 오버헤드를 계량 → 마진 부족 시 Path 전환 트리거.
- **M5 — 네이티브 Metal 대안 검토**: Sodium + Iris 경로(Metal 직행)와의 비교 — 단, Iris/OptiFine과 VulkanMod 비호환이라 "셰이더로" 요건 동시 충족 어려움 → 별도 챌린지로 분리(C4 후보).

## Open Questions
- [UNVERIFIED] M-chip별(M1/M2/M3/M4 Pro/Max)의 MoltenVK→Metal 변환 비용 벤치마크 자료 존재?
- [UNVERIFIED] 출제자의 테스트 머신은 어느 칩인가? (synthesis Q6 후보)
- [UNVERIFIED] VulkanMod이 MoltenVK 번들을 포함하는가, 시스템 설치에 의존하는가?

## Sources
- <https://github.com/KhronosGroup/MoltenVK>
- <https://github.com/xCollateral/VulkanMod/discussions/389>
- <https://github.com/xCollateral/VulkanMod>
