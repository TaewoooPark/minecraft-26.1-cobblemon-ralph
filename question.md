# Minecraft Challenge — 심층 조사 문서

> 원본 출처: [carpedm30 Notion](https://carpedm30.notion.site/m)
> 조사일: 2026-05-12
> 제한 시간: 24시간

---

## 1. 문제 원문

### 목표
**셰이더로 포켓몬 마크(Cobblemon)를 M chip 맥에서 60FPS로 즐길 수 있게 만들기.**

지정된 스택:
- **Minecraft 26.1**
- [**VulkanMod**](https://modrinth.com/mod/vulkanmod) — Vulkan 렌더러 모드
- [**Beryl**](https://modrinth.com/mod/beryl) — VulkanMod 위에 올라가는 통합 셰이더 파이프라인
- [**Cobblemon**](https://modrinth.com/mod/cobblemon/versions) — 포켓몬 모드
- **+ Label Bug Fix**: 포켓몬 이름표가 벽 너머로 보이는 현상 수정

### 심화(Optional)
- [**Create**](https://modrinth.com/mod/create/versions) 추가 (Fabric 포트 없음)

### 출제 의도
> "무한한 solution space에서 최적의 답을 제한 시간 안에 찾는 문제. 출제자도 오늘 처음 정의하고 풀어봤고, 마인크래프트 모딩에 대해 아는 건 없었다."

---

## 2. 핵심 용어/스택 정리

### 2.1 "Minecraft 26.1"이란?
- Mojang의 **새 버저닝 체계** 첫 메이저 릴리스. 종래 `1.21.x` → `YY.minor` (연도-기반).
- **26.1 "Tiny Takeover"** — 2026-03-24 출시. 새 아기 몹 텍스처, 황금 민들레, 크래프트 가능 네임태그 등.
- 첫 스냅샷 `26.1 Snapshot 1`은 2025-12-16. 이전 스냅샷 형식 `26wWWa`는 폐기.
- **결정적 특징**:
  - **Unobfuscated** 코드베이스 — Mojang 공식 매핑 사용. Yarn 등 커뮤니티 매핑 불필요.
  - **26.1은 OpenGL 단독 지원 마지막 버전**. 26.2부터 Vulkan 백엔드 토글 예정.
  - Fabric 26.1 빌드: 2026-03-14 공식 지원 시작.

### 2.2 VulkanMod
- xCollateral의 **Vulkan 렌더러** Fabric 모드. Sodium 등 OpenGL 최적화 모드의 대안.
- macOS에서는 **MoltenVK**(Vulkan → Metal 변환 레이어)를 자동으로 사용.
- 지원 MC 버전: `26.1.x`, `1.21.9–1.21.11`, `1.21–1.21.5`, `1.20.x`, `1.19.2–1.19.4`, `1.18.2`.
- 셰이더 생태계가 OpenGL 중심이라 **Iris 호환 셰이더팩이 직접 동작하지 않음** — 별도 셰이더 파이프라인이 필요.

### 2.3 Beryl
- **VulkanMod 종속**. Vulkan 기반 **통합(integrated) 셰이더 파이프라인**. 외부 셰이더팩 미지원 — 자체 파이프라인만 제공.
- 지원 MC: **`26.1.x`, `1.21.9–1.21.11`**. 2026-05-12 재검증 기준 `beryl_26.1.2-0.1.3-alpha+1.jar`가 Modrinth API에서 확인됨.
- Fabric 클라이언트 사이드.

### 2.4 Cobblemon
- Fabric/Forge/NeoForge 지원 오픈소스 포켓몬 모드.
- 2026-05-12 재검증 기준 Fabric 공식 빌드는 **1.21.1 / 1.20.1 / 1.19.2** 라인에 머문다. `26.1.x` 공식 빌드는 확인되지 않았으므로 strict 경로에서는 자체 포팅이 필요하다.

### 2.5 Label Bug
- "포켓몬 이름이 벽 너머로 뜨는 문제" — Cobblemon `PokemonRenderer.renderNameTag`가 vanilla nameplate와 유사하게 `Font.DisplayMode.SEE_THROUGH` 라벨 패스를 사용하기 때문에 발생하는 것으로 좁혀졌다.
- strict 경로에서는 Cobblemon 포팅본 source에서 `SEE_THROUGH`를 제거하거나 `NORMAL`로 바꾸는 방식이 1순위다.
- 외부 mixin은 같은 변경을 분리 배포할 때의 fallback이고, config로 라벨을 끄는 것은 fix가 아니라 회피다.

---

## 3. 조사로 드러난 핵심 충돌(Solution Space의 제약)

문제가 그대로는 **성립하지 않거나 매우 어려운** 호환성 충돌이 다수 존재:

| # | 충돌 | 영향 |
|---|------|------|
| C1 | **Beryl 26.1 지원 여부** | 재검증으로 해소. VulkanMod+Beryl 26.1.2 공식 jar 페어 존재 |
| C2 | **Cobblemon이 1.21.1까지만 공식 지원**(2026-05 시점 확인된 범위) | 의도한 strict 풀이의 핵심 병목. 26.1 포팅 필수 |
| C3 | **VulkanMod ↔ Iris/OptiFine 셰이더팩 비호환** | "셰이더로"를 일반적 OptiFine/Iris 셰이더팩으로 해석할 수 없음 → Beryl 내장 파이프라인 사용이 사실상 유일한 경로 |
| C4 | **MoltenVK 오버헤드** (Apple Silicon) | Vulkan SPIR-V → Metal MSL 변환 비용. 60FPS 보장의 변수 |
| C5 | **Create Fabric 공식은 1.20.1 라인에 머무름** | Optional 심화 문제의 "Fabric 없음" 단서와 일치. Create-Fly는 1.21.11 빌드는 있으나 26.1 정식 대응은 별도 검증 필요 |
| C6 | **26.1 Unobfuscated** | 기존 Yarn 기반 mixin 코드 일부 재작성 필요할 수 있음 |

**즉, 문제는 "버전 매칭이라는 1차 퍼즐"부터 풀어야 함.**

---

## 4. 가능한 해법 경로 (Solution Paths)

### Path A — **문제 의도 그대로: 26.1 strict** ★ 추천
전제: **문제는 반드시 의도한 대로 풀어야 한다.** 따라서 `26.1`을 `1.21.11`이나 `1.21.1`로 완화하지 않는다.

1. MC **26.1.x** + Fabric Loader 26.1 + Fabric API 26.1.
2. VulkanMod **26.1.2-0.6.5** + Beryl **26.1.2-0.1.3-alpha+1** 공식 jar 페어 사용.
3. Cobblemon은 공식 26.1 빌드가 없으므로 **1.21.1 → 26.1.x 자체 포팅**.
4. Label bug는 Cobblemon 포팅본의 `PokemonRenderer`에서 `Font.DisplayMode.SEE_THROUGH` 라벨 패스를 제거하거나 `NORMAL`로 바꾸는 source patch를 우선 적용. 별도 mixin은 fallback.
- **리스크**: 이제 Beryl이 아니라 Cobblemon 포팅이 핵심 병목. 24시간 내 성공 가능성은 있으나, RenderState/registry/data API 차이에 따라 4–8h 이상 소요될 수 있음.

### Path B — **비의도 fallback: 1.21.11 Beryl-native**
1. MC **1.21.11** + Fabric + VulkanMod + Beryl + Cobblemon 자체 포팅.
2. strict 경로가 Cobblemon 26.1 포팅에서 막힐 때 비교 데모/백업 자료로만 사용.
- **리스크**: 문제의 `26.1`을 충족하지 않으므로 최종 답으로는 감점 또는 불인정 가능.

### Path C — **시연용 안전망: 1.21.1/1.20.1 + Iris**
- Cobblemon 공식 빌드와 일반 셰이더팩으로 빠르게 데모 가능하나, VulkanMod+Beryl+26.1 지정 스택을 벗어난다.
- 본 문제를 "의도한 대로" 푼 산출물로는 취급하지 않고, 실패 분석/비교군으로만 둔다.

### 심화(Create)
- 공식 Create Fabric은 1.20.1에서 정지. ZurrTum/Create Fly 등 커뮤니티 포트가 1.21+에서 활동 중이나 26.1 빌드는 미확정.
- "Fabric 없음" 문구는 이 사실에 대한 힌트. 가능한 접근:
  - (i) ZurrTum 비공식 포트 사용
  - (ii) NeoForge로 전체 스택 전환 후 Sinytra Connector로 VulkanMod/Cobblemon 합류
  - (iii) Create의 일부 기능만 가지는 대체 모드 사용

---

## 5. 24시간 실행 계획 제안

1. **(0–1h) strict 베이스라인**: 26.1.x + Fabric + VulkanMod 0.6.5 + Beryl 0.1.3-alpha+1 빈 인스턴스에서 M-chip Mac 60FPS 확인.
2. **(1–7h) Cobblemon 26.1 포팅**: Cobblemon 1.7.3/1.8.0 snapshot 소스에서 `mc_version=26.1.x`, 최신 Fabric API/Parchment 또는 Mojang official 매핑으로 빌드. RenderState/registry/data codec 오류를 우선 처리.
3. **(동시에) Label bug source patch**: `PokemonRenderer.renderNameTag`의 `DisplayMode.SEE_THROUGH` 라벨 draw를 제거/변경. 포팅본에 직접 반영.
4. **(7–12h) 통합 부팅**: VulkanMod+Beryl+Cobblemon 포팅본 동시 부팅, 포켓몬 5마리 스폰, 라벨 벽 투과 재현/수정 검증.
5. **(12–18h) FPS 튜닝**: Beryl/VulkanMod 옵션 조정으로 T2(셰이더 ON + Cobblemon 5마리) 평균 60FPS 달성.
6. **(18–24h) 검증/문서화**: modlist, SHA, FPS CSV, 라벨 before/after, 데모 영상, 포팅 diff 정리.

---

## 6. 출제자에게 확인하면 좋을 질문

- Q1. "셰이더"는 지정된 **Beryl 통합 셰이더 파이프라인**으로 충분한가? (문제에 Beryl이 명시되어 있으므로 기본값은 Yes)
- Q2. "60FPS"는 **평균/1% low/최저** 중 어떤 기준인가? 측정 씬은 어디인가?
- Q3. Label bug 수정은 **Cobblemon 포팅본 source patch**로 제출해도 되는가, 별도 fix mod여야 하는가?
- Q4. 심화의 "Create + Fabric 없음" — 비공식 포트 사용도 허용되는가? 단, strict 본문 풀이가 우선이다.

---

## 7. 참고 링크

- VulkanMod: <https://github.com/xCollateral/VulkanMod>, <https://modrinth.com/mod/vulkanmod>
- Beryl: <https://modrinth.com/mod/beryl>
- Cobblemon: <https://modrinth.com/mod/cobblemon/versions>, <https://wiki.cobblemon.com/>
- Create: <https://modrinth.com/mod/create/versions>
- Fabric 26.1 발표: <https://fabricmc.net/2026/03/14/261.html>
- Fabric 26.1 포팅 가이드: <https://docs.fabricmc.net/develop/porting/>
- Minecraft 26.1 Wiki: <https://minecraft.wiki/w/Java_Edition_26.1>
- VulkanMod macOS 토론: <https://github.com/xCollateral/VulkanMod/discussions/389>
- MoltenVK: <https://github.com/KhronosGroup/MoltenVK>
- Sinytra Connector: <https://github.com/Sinytra/Connector>
