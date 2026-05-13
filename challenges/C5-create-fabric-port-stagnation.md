# C5: Create Fabric Port Stagnation (Optional Track)

- **Severity**: MEDIUM
- **Discovered**: iter#5
- **Status**: OPEN
- **Related Paths**: 모든 경로의 create 축 (D5)

## What
공식 **Create Fabric** 라인은 MC 1.20.1에서 안정적으로 확인된다[V05]. question.md §심화의 "Fabric 포트 없음"은 26.1 strict 라인에서 공식 Create Fabric을 바로 쓸 수 없다는 단서로 해석한다. 따라서 심화(Optional) 요건은 core P01 이후에만 (a) 비공식 포트 PoC, (b) 로더 전환 실험, (c) Create 대체 모드 중 하나로 별도 평가한다.

## Why it matters
- Optional 트랙이지만 **점수/완성도 차별화**가 달린 항목.
- 비공식 포트 사용은 **C2+C4와의 의존성 충돌**을 추가로 일으킬 가능성 — Fabric API 버전 매칭, mixin 충돌, KubeJS/Forge-only API 의존 등. C1(Beryl 26.1)은 V28로 해소됐다.
- NeoForge 전환은 VulkanMod·Beryl의 Fabric 중심 배포와 정면 충돌한다[V19·V26].

## Evidence
- <https://modrinth.com/mod/create/versions> — 공식 Create 페이지의 Fabric 빌드 최신 MC가 1.20.1 라인에서 멈춤
- <https://modrinth.com/mod/create-fabric> — Fabric 포트 페이지(별도 프로젝트 슬러그)
- <https://github.com/ZurrTum/Create-Fly> 또는 유사 비공식 포트 저장소
- question.md §3 C5 — "Fabric 포트 없음" 단서

## Possible Mitigations
- **M1 — 심화 포기**: 60FPS·셰이더·라벨 픽스의 본 트랙 완수에 집중. Create는 보고서에서 "범위 외" 처리.
- **M2 — ZurrTum 등 비공식 포트 채용**: 26.1 또는 26.1-pre 계열이 있으면 strict instance 복사본에서 PoC. core pass를 깨면 즉시 제거[V20·V25].
- **M3 — NeoForge 전체 환승 + Sinytra Connector**: Create(NeoForge) + Cobblemon(NeoForge) + VulkanMod/Beryl(Fabric→Connector) — 다단계 호환 검증 필요, 24h budget risk HIGH.
- **M4 — Create 대체 모드**: Industrial Revolution, Modern Industrialization 등 Fabric 네이티브 자동화 모드 — 단 "Create"라는 단어를 정확히 지정한 출제 의도와 어긋남.
- **M5 — Optional 자체를 출제자 확인 항목으로 격상**: synthesis Q5에 명시.

## Open Questions
- 2026-05 시점 Create Fabric 포트의 가장 진보된 비공식 빌드와 그 MC 버전?
- 비공식 포트가 Cobblemon·Beryl과 함께 부팅되는가? (mixin/Fabric API 충돌)
- Sinytra Connector가 strict 26.1 경로에 실질적으로 도움이 되는가? 현재 primary 지원은 1.21.1로 확인됨[V21].

## Sources
- <https://modrinth.com/mod/create/versions>
- <https://modrinth.com/mod/create-fabric>
- <https://github.com/Sinytra/Connector>
