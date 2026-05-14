<h1 align="center">Minecraft Challenge, Cobblemon 26.1.x on M-chip Mac</h1>

<p align="center">
  <em>혼자서 24시간 동안 진행한 챌린지를, Claude Code의 자율 Ralph loop으로 풀어낸 기록입니다. 총 218회의 반복과 191개의 패치를 거쳐, 16개의 strict 체크포인트를 모두 통과했습니다.</em>
</p>

<p align="center">
  <a href="./README.md">English</a> ·
  <a href="https://carpedm30.notion.site/m">원본 문제</a> ·
  <a href="./question.md">question.md</a> ·
  <a href="./RUN-MANUAL.md">실행 매뉴얼</a> ·
  <a href="./impl/artifacts/report.md">최종 리포트</a> ·
  <a href="https://claude.com/plugins/ralph-loop">Anthropic Ralph Loop 플러그인</a> ·
  <a href="./.ralph/">Ralph Loop 설정</a>
</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/badge/license-MIT_%2B_MPL--2.0-000000?style=flat-square&labelColor=000000&color=333333&cacheSeconds=3600" alt="License: MIT + MPL-2.0 (dual)"></a>
  <img src="https://img.shields.io/github/stars/TaewoooPark/minecraft-26.1-cobblemon-ralph?style=flat-square&logo=github&logoColor=white&labelColor=000000&color=333333&cacheSeconds=3600" alt="GitHub stars">
  <img src="https://img.shields.io/github/last-commit/TaewoooPark/minecraft-26.1-cobblemon-ralph?style=flat-square&labelColor=000000&color=333333&cacheSeconds=3600" alt="Last commit">
  <img src="https://img.shields.io/github/languages/top/TaewoooPark/minecraft-26.1-cobblemon-ralph?style=flat-square&labelColor=000000&color=333333&cacheSeconds=3600" alt="Top language">
  &nbsp;
  <img src="https://img.shields.io/badge/Minecraft-26.1.2-000000?style=flat-square&logo=minecraft&logoColor=white&labelColor=000000" alt="Minecraft 26.1.2">
  <img src="https://img.shields.io/badge/Fabric-0.19.2-000000?style=flat-square&labelColor=000000" alt="Fabric 0.19.2">
  <img src="https://img.shields.io/badge/Kotlin-2.3.21-000000?style=flat-square&logo=kotlin&logoColor=white&labelColor=000000" alt="Kotlin 2.3.21">
  <img src="https://img.shields.io/badge/Java-25-000000?style=flat-square&logo=openjdk&logoColor=white&labelColor=000000" alt="Java 25">
  <img src="https://img.shields.io/badge/Gradle-9.2.1-000000?style=flat-square&logo=gradle&logoColor=white&labelColor=000000" alt="Gradle 9.2.1">
  &nbsp;
  <img src="https://img.shields.io/badge/Claude_Code-000000?style=flat-square&logo=anthropic&logoColor=white&labelColor=000000" alt="Claude Code">
  <img src="https://img.shields.io/badge/Anthropic-000000?style=flat-square&logo=anthropic&logoColor=white&labelColor=000000" alt="Anthropic">
  <img src="https://img.shields.io/badge/Ralph_Loop-000000?style=flat-square&labelColor=000000" alt="Ralph Loop">
  <img src="https://img.shields.io/badge/Agentic_Coding-000000?style=flat-square&labelColor=000000" alt="Agentic Coding">
  &nbsp;
  <img src="https://img.shields.io/badge/macOS-000000?style=flat-square&logo=apple&logoColor=white&labelColor=000000" alt="macOS">
  <img src="https://img.shields.io/badge/Apple_Silicon_M2-000000?style=flat-square&logo=apple&logoColor=white&labelColor=000000" alt="Apple Silicon M2">
  <img src="https://img.shields.io/badge/VulkanMod-0.6.5-000000?style=flat-square&logo=vulkan&logoColor=white&labelColor=000000" alt="VulkanMod 0.6.5">
  <img src="https://img.shields.io/badge/Beryl-0.1.3--alpha-000000?style=flat-square&labelColor=000000" alt="Beryl shader">
</p>

<p align="center">
  텍스처가 적용된 포켓몬 10마리 이상을 <strong>118 FPS</strong>로 렌더링했습니다. <strong>H-체크포인트 16개</strong>를 모두 통과했습니다. <strong>60초</strong> 분량의 데모를 녹화했고, jar 산출물은 <strong>SHA512</strong>로 검증했습니다.
</p>

---

> **원본 문제**: <https://carpedm30.notion.site/m> (로컬 미러: [`question.md`](./question.md))
>
> **목표**: 포켓몬 모드인 Cobblemon을 Minecraft 26.1과 VulkanMod, Beryl 셰이더 환경 위에 이식하여, M-chip Mac에서 60 FPS 이상으로 구동하는 것이 목표였습니다. 포켓몬 이름표가 벽을 뚫고 보이는 렌더링 버그도 함께 수정합니다.
>
> **결과**: H0부터 H15까지 16개의 strict 체크포인트를 모두 통과했습니다. 셰이더가 켜진 상태에서 텍스처가 적용된 포켓몬이 118 FPS로 표시됩니다. 이름표 가림 처리는 양방향으로 검증을 마쳤으며, 60초 분량의 데모 영상도 녹화했습니다.

---

> ## 🔍 외부 평가 결과 (2026-05-14)
>
> 공개 릴리스 이후 외부 검토자가 두 가지 사안을 제기했습니다. 두 사안의 원인, 증거, 해결 상태를 그대로 옮겨 적어, 독자가 직접 깊이 들어가 보지 않더라도 이 작업물의 한계를 판단할 수 있도록 정리해 두었습니다.
>
> ### 지적 사항 1 — 재현 실패: `RECONSTITUTE.md` HTTP 404 응답
>
> - **증상**: `README §5`("소스로부터 재현하기")의 안내를 따라가면 `impl/cobblemon-port/RECONSTITUTE.md` 링크에 도달하는데, `raw.githubusercontent.com` 에서 **HTTP 404** 가 반환되었습니다. 이로 인해 Option B(소스 빌드) 재현 경로가 사실상 끊긴 상태였으며, Option A(GitHub Release jar 다운로드) 만 동작했습니다.
> - **원인**: 해당 파일은 **2026-05-13 18:46에 작성**되었으며, 이는 PT191s 빌드와 `report.md v0.8` 가 만들어진 풀이 기간 안의 시점입니다. 최초 공개 커밋 [`97b4a62`](https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/commit/97b4a62) 의 `.gitignore` 에는 처음부터 `!impl/cobblemon-port/RECONSTITUTE.md` 라인이 들어 있었습니다. 즉, 이 파일을 공개하려는 의도가 day-1부터 명확했다는 증거입니다. 그러나 git 의 동작 규칙상, 부모 디렉토리가 제외된 상태에서는 `!` 부정으로 하위 파일을 다시 포함시킬 수 없습니다. 바로 위 줄의 `impl/cobblemon-port/` 규칙이 예외를 무력화시켰습니다. 파일은 로컬 디스크에 존재했고 `README §5` 와 `RUN-MANUAL §4` 에서 참조되고 있었지만, remote 에는 한 번도 도달하지 못했습니다.
> - **해결**: 커밋 [`cb96a1b`](https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/commit/cb96a1b) (2026-05-15) 에서 gitignore 문법을 `impl/cobblemon-port/*` 로 변경하여 `!` 부정이 작동하도록 수정한 뒤, **1717바이트 동일 파일을 변경 없이 그대로 추가**했습니다. **풀이 기간 종료 이후 새로 작성된 내용은 없습니다.** 전체 증거(파일 타임스탬프, 최초 `.gitignore` 14행 부정 라인, 바이트 단위 동일성)는 [GitHub Release 의 "Post-release errata" 섹션](https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/releases/tag/v1.8.0%2B26.1.2-PT191s) 에 보존되어 있습니다.
> - **판정**: 운영상의 누락이며, 풀이 자체의 결함은 아닙니다.
>
> ### 지적 사항 2 — Cobblemon UX 커버리지 부족 (실제 결함, 미해결)
>
> 원인 분석과 Ralph 규칙 개선안 6가지 (Tier-1/Tier-2 acceptance 분리, R19 stub-debt 원장, R20 first-party 데이터 무결성, R21 이연 작업 스케줄링, U Update-scope 슬롯, 비용 가중 우선순위) 전체 내용: **[`EVALUATION-FINDING-2-KO.md`](EVALUATION-FINDING-2-KO.md)**.

---

## TL;DR

이 작업은 24시간짜리 1인 챌린지였습니다. 목표는 `MC 26.1 + Fabric + VulkanMod + Beryl + Cobblemon + 이름표 수정`이 모두 함께 동작하는 M-chip Mac 클라이언트를 완성하는 일이었습니다. 시작 시점에는 네 개의 모드 중 어느 하나도 26.1을 공식적으로 지원하지 않는 상태였습니다. 실제 포팅 작업은 Claude Code의 Ralph loop이 한 번에 한 단계씩 자율적으로 수행했습니다. Ralph loop이란, 매 반복마다 동일한 프롬프트가 모델에 다시 입력되는 자기 참조 형태의 루프를 의미합니다.

최종 결과물은 다음과 같습니다.

- **실제 종 텍스처가 적용된 포켓몬 렌더링** (Klang, Mr. Mime, Roggenrola, Exeggcute, Chansey 등). 마젠타색 missing-texture 큐브로 표시되는 상태가 아닙니다.
- **성능**: T1 베이스라인 115.2 FPS, 포켓몬 5마리 환경의 T2 121.4 FPS, 텍스처가 적용된 10마리 이상 환경의 M003 118 FPS.
- **이름표 수정**: PT151 단계에서 raycast 로직을 `PokemonRenderer.kt`에 적용한 뒤, PT185 단계에서 `PokemonPlaceholderRenderer`로 이식했습니다. 스크린샷 5장(정상 시야 4장, 벽 뒤 가림 1장)으로 검증을 마쳤습니다.
- **부팅이 검증된 jar 산출물**: PT156, PT170, PT185, PT191s.
- **데모 영상**: `impl/demo/demo.mp4` (60초, 1280×720, H.264).

재현 절차에 필요한 자료와 Ralph loop의 동작 방식, 여기까지 도달하기 위해 거쳐 온 191개의 패치, 그리고 시도 끝에 막다른 길로 판명된 경로 12개까지 모두 이 저장소에 보존해 두었습니다.

---

## ⚡ 빠른 설치 (산출물 사용, 빌드 불필요)

Cobblemon을 MC 26.1.2에서 직접 플레이만 해 보고 싶으시다면, 아래 순서대로 진행해 주시면 됩니다.

### 사전 준비 (macOS Apple Silicon, M1/M2/M3/M4)

```bash
brew install openjdk@25                  # Java 25 (MC 26.1.x 구동에 필요)
brew install --cask prismlauncher        # 권장. 공식 런처를 사용해도 됩니다.
export JAVA_HOME=/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home
```

### 설치 (약 5분 소요)

1. **Minecraft 26.1.2 설치**: Prism Launcher에서 *Add Instance → Vanilla → `26.1.2` → Create* 순서로 진행합니다.
2. **Fabric Loader 0.19.2 설치**: 해당 인스턴스의 *Edit → Version → Install Fabric → `0.19.2`*를 선택합니다.
3. **5개의 모드 jar**을 인스턴스의 `mods/` 폴더에 내려받습니다.

| 모드 | 버전 | 출처 |
|---|---|---|
| **Cobblemon (이 포트)** | `1.8.0+26.1.2-PT191s-h10-textures` | **[GitHub Release](https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/releases/latest)** |
| Fabric API | `0.148.2+26.1.2` | <https://modrinth.com/mod/fabric-api/versions?g=26.1.2> |
| Fabric Language Kotlin | `1.13.11+kotlin.2.3.21` | <https://modrinth.com/mod/fabric-language-kotlin> |
| VulkanMod | `26.1.2-0.6.5` | <https://github.com/xCollateral/VulkanMod/releases> |
| Beryl (shader bridge) | `26.1.2-0.1.3-alpha+1` | VulkanMod releases 페이지 또는 Modrinth |

4. **Cobblemon jar의 SHA512 해시**를 검증합니다.

```bash
shasum -a 512 ~/Library/Application\ Support/PrismLauncher/instances/<your-instance>/minecraft/mods/Cobblemon-fabric-1.8.0+26.1.2-PT191s-h10-textures.jar
# 예상 값: 02d8cd271b78283cbcb54a0ee1676450c2b7adc42a163d6e1c9e133c871247ae16616f161727aa5d713fa337738f587f7dcadffc2f784cd552aefc0df8a33e28
```

5. 인스턴스를 실행합니다.
6. *Options → Video Settings*에서 VulkanMod가 활성화되어 있는지 확인합니다.
7. *Options → Shaders*에서 `Beryl-default`를 선택한 뒤 *Apply* 버튼을 눌러주세요.

### 게임 내 사용법

```
/gamemode creative
/pokespawn pikachu                    # 종 이름으로 포켓몬 소환
/pokespawn charmander level=50        # 옵션과 함께 소환
/pokegive @s squirtle                 # 인벤토리에 직접 지급
```

> ⚠️ 반드시 **`/pokespawn`** 명령을 사용하시기 바랍니다. vanilla의 `/summon cobblemon:pokemon ... {Pokemon:{Species:"pikachu"}}` 형태는 사용하지 마시기 바랍니다. NBT payload가 Cobblemon의 species deserialize 체인보다 나중에 적용되는 구조이기 때문에, species 필드가 무시되어 무작위 종이 소환됩니다. 전체 워크플로우는 [RUN-MANUAL.md §6](./RUN-MANUAL.md)에서 확인하실 수 있습니다.

### 단계별 매뉴얼

데모 영상 녹화, 문제 해결, FPS 검증을 포함한 전체 사용자 워크플로우는 [**`RUN-MANUAL.md`**](./RUN-MANUAL.md)에 정리해 두었습니다.

### 법적 사항과 라이선스

이 포트는 Cobblemon (MPL-2.0)의 **비공식 포트**입니다. Cable MC, The Pokémon Company, Game Freak, Nintendo와는 어떠한 공식 관계도 없습니다. 전체 출처 표기와 수정 사항 공개 내용은 [`NOTICE.md`](./NOTICE.md)에서 확인하실 수 있습니다.

---

## 1. Ralph 시작 전 준비 (루프 실행 이전에 수동으로 진행한 부분)

Ralph loop의 첫 반복이 시작되기 전에, 아래 자료들을 먼저 준비해 두었습니다. 모델이 작업할 수 있는 틀을 사전에 마련해 두는 단계였습니다.

### 1.1 문제 정의

[`question.md`](./question.md)에 carpedm30의 원본 브리프를 그대로 옮겨 적은 뒤, 그 위에 확장 사양을 덧붙였습니다. 모드 URL, 버전 제약 조건, "non-negotiable premise"(양보할 수 없는 전제)의 정의가 여기에 포함되어 있습니다. 전제는 다음과 같습니다. M-chip Mac, MC 26.1, VulkanMod, Beryl, Cobblemon, 이름표 수정, 60 FPS 이상.

### 1.2 솔루션 공간 설계 (`state/`와 `playbook/`)

- [`state/challenges.md`](./state/challenges.md)에 6개의 핵심 기술 챌린지(C1부터 C6까지)를 정리해 두었습니다. Beryl과 MC 26.1 사이의 버전 격차, Cobblemon의 호환성 한계, Apple Silicon에서의 MoltenVK 오버헤드, VulkanMod와 shaderpack의 비호환성, Create Fabric의 진행 정체, 이름표의 depth-test 처리와 같은 문제들이 포함됩니다.
- [`state/dimensions.md`](./state/dimensions.md)에는 솔루션이 변형될 수 있는 5개의 축(MC 버전, 로더, 셰이더, 이름표 수정 방식, Create 포함 여부)을 정의했습니다.
- [`state/solutions.md`](./state/solutions.md)에는 가능한 12개의 솔루션 경로(P01부터 P12까지)를 나열했습니다. 각 경로는 (버전, 로더, 셰이더, 이름표, Create)의 서로 다른 조합으로 이루어져 있습니다.
- [`state/verification.md`](./state/verification.md)에는 출처를 인용한 사실 검증 항목 29개(V01부터 V29까지)를 정리했습니다. 모든 버전, jar SHA, 의존성 주장에 대응하는 항목이 하나씩 존재합니다.
- [`state/synthesis.md`](./state/synthesis.md)에는 진행 도중에 갱신되는 순위와 추천 사항이 담겨 있습니다.
- [`playbook/00~07`](./playbook/)에는 manifest, 환경, 포트 계획, 이름표 수정 계획, 셰이더 튜닝, fallback tree, 선택 사항인 Create, acceptance matrix가 순서대로 정리되어 있습니다.

### 1.3 Ralph loop 설정 (`.ralph/`)

- [`.ralph/PROMPT.md`](.ralph/PROMPT.md): 매 반복마다 Claude에게 다시 입력되는 프롬프트입니다.
- [`.ralph/CLAUDE.md`](.ralph/CLAUDE.md): 영구 컨텍스트 파일입니다. C1부터 C15까지의 완료 기준과 `<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>` 종료 게이트가 정의되어 있습니다.
- [`.ralph/ralph-rule.md`](.ralph/ralph-rule.md): 위반 불가 규칙 18개입니다 (R1 한 번에 하나의 원자적 작업, R7 약속 발행 규율, R13 동일 빌드 중복 금지, R14 동일 가설 중복 금지, R18 매 반복마다 두 원장에 한 줄씩 append).

### 1.4 Phase 3 구현 원장 (`state/impl-progress.md`)

- H0부터 H15까지 16개의 strict 체크포인트가 정의되어 있습니다 (도구 준비, vanilla 부팅, 베이스라인 FPS, 레포 클론, gradle 갱신, compile-clean, Cobblemon 부팅, 포켓몬 스폰, 이름표 패치 검증, T1/T2/T3 FPS, 튜닝, 데모, 패키징, 자기 감사).
- 매 반복마다 `state/coverage.md`에 한 줄을 append하고, `state/impl-progress.md` §6에 한 행을 추가합니다.

---

## 2. Ralph Loop의 작동 방식

Ralph loop은 자기 자신을 참조하는 자율 코딩 루프입니다. 매 반복이 끝날 때마다 동일한 프롬프트가 다시 실행되며, 모델은 직전 반복에서 자신이 남긴 파일을 통해 이전 출력을 다시 마주하게 됩니다. 이 기법은 [Geoffrey Huntley의 글](https://ghuntley.com/ralph/)을 통해 널리 알려졌고, 이후 Claude Code의 공식 **[Anthropic Ralph Loop 플러그인](https://claude.com/plugins/ralph-loop)** 으로 패키징되었습니다 (소스: [`anthropics/claude-plugins-official/plugins/ralph-loop`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop)). 이 프로젝트는 해당 플러그인의 `/ralph-loop` 스킬을 사용하여, `<promise>COMPLETE-SOLUTION-DELIVERABLE</promise>` 완료 게이트 아래에서 총 218회의 반복을 수행했습니다.

### 2.1 단일 프롬프트

```
Read .ralph/PROMPT.md and execute exactly one Ralph iteration following
.ralph/CLAUDE.md and .ralph/ralph-rule.md. Workdir is /…/Mincraft-Challenge.
Phase 3 활성: priority H→B→M→PT→F→A→P→G.
state/impl-progress.md §1 Checkpoint Status 표를 매 반복 시작 시 읽고,
가장 낮은 ID의 TODO/IN_PROGRESS/FAIL 체크포인트 1개만 advance.
…R13/R14/R16/R18 엄수.
```

### 2.2 우선순위 파이프라인 (매 반복마다 하나만 선택)

```
H  Checkpoint advance        (TODO → IN_PROGRESS → PASS / FAIL / BLOCKED)
B  Build attempt             (./gradlew :fabric:build, B001부터 B218까지 번호 부여)
M  Measurement run           (F3 오버레이 FPS, impl/measurements/ 의 CSV)
PT Patch                     (소스 편집, PT001부터 PT191까지)
F  Failure hypothesis        (근본 원인 가설 F001부터 F032까지)
A  Audit                     (사실 교차 검증과 무회귀 점검)
P  Packaging                 (modlist / shasum / report / demo)
G  Promise gate              (C1부터 C15까지 모두 참일 때에만 <promise> 발행)
```

### 2.3 매 반복마다 강제되는 invariant

- **R1**: 한 번의 반복에서는 정확히 하나의 원자적 단위만 실행합니다 (묶음 처리 금지).
- **R4**: 모든 사실 주장에는 인라인 URL 또는 검증 ID `V##`를 함께 첨부합니다.
- **R7**: 완료 약속 태그는 15개의 acceptance 기준이 모두 strict하게 참인 경우에만 발행할 수 있습니다. 루프에서 벗어나기 위해 거짓 약속을 발행하는 행위는 금지됩니다.
- **R13**: 동일한 코드 상태와 동일한 인자 조합으로 빌드를 중복 실행하지 않습니다.
- **R14**: 동일한 가설로 동일한 오류를 반복해서 시도하지 않습니다 (3회 연속 동일 오류 클래스가 발생하면 자동으로 fallback-tree 검토 단계로 전환합니다).
- **R18**: 매 반복마다 `state/coverage.md`와 `state/impl-progress.md` §6 두 원장에 정확히 한 줄씩 추가합니다. 두 원장이 분기하면 자기 참조 구조가 무너집니다.

---

## 3. Phase 3 결과 요약

| 체크포인트 | 상태 | 근거 |
|---|---|---|
| H0 도구 준비 | PASS | Java 25, Gradle 9.2.1, Prism |
| H1 MC 26.1.x vanilla 부팅 | PASS iter#199 | piston-data 직접 다운로드 후 custom launcher 경유, accessibility 메뉴 스크린샷 |
| H2 VulkanMod + Beryl 베이스라인 (S1/S2/S3 60 이상) | PASS iter#206 | M001 및 M002 데이터에 기반한 monotonicity audit |
| H3에서 H5까지, Compile clean | PASS | `./gradlew :fabric:build` exit 0 |
| H6 Cobblemon 부팅 | PASS iter#167 | PT156 jar의 `Done (4.908s)` |
| H7 포켓몬 스폰 | PASS iter#198 | 서버에서 서로 다른 5종이 `/summon`으로 소환됨 |
| H8 이름표 패치와 벽 가림 | PASS iter#207 | 양방향 스크린샷 5장 |
| H9 T1 FPS 75 이상 | PASS iter#202 | M001 평균 **115.2 FPS** |
| H10 T2 FPS 60 이상 (텍스처가 적용된 포켓몬 5마리 환경) | PASS iter#216 | M002 **121.4 FPS** 및 M003 **118 FPS** (텍스처 적용 상태) |
| H11 T3 FPS 45 이상 (10마리 이상과 전투 환경) | PASS iter#216 | M003에 10마리 이상이 포함되며, 전투 FX에 대해서는 monotonicity 논증으로 입증 |
| H12 Beryl 튜닝 | PASS iter#216 | vacuous (T2가 미달하지 않았으므로 delta 조정이 필요하지 않음) |
| H13 demo.mp4 60초 | PASS iter#216 | `impl/demo/demo.mp4`, ffmpeg AVFoundation |
| H14 산출물 8종 모두 존재 | PASS iter#216 | [`impl/artifacts/`](./impl/artifacts/) 참조 |
| H15 자기 감사 | PASS iter#216 | report.md v0.8, SHA512 byte 일치, bypass 0 |

부팅이 검증된 jar 4개(PT156 91 MB, PT170 104 MB, PT185 105 MB, PT191s 106 MB)는 git 트리에 포함하기에 용량이 너무 큽니다. 따라서 해당 파일들은 이 저장소의 **GitHub Release**에 첨부해 두었습니다. SHA512의 source-of-truth는 [`impl/artifacts/shasum-512.txt`](./impl/artifacts/shasum-512.txt)입니다.

---

## 4. 레포지토리 구조

```
.
├── README.md                       ← 영문 README
├── README-KO.md                    ← 이 파일 (한국어 README)
├── question.md                     ← carpedm30 원본 브리프 그대로
│
├── .ralph/
│   ├── PROMPT.md                   ← 매 반복마다 다시 입력되는 프롬프트
│   ├── CLAUDE.md                   ← C1부터 C15까지의 완료 기준
│   └── ralph-rule.md               ← R1부터 R18까지의 위반 불가 규칙
│
├── state/                          ← Ralph의 read/write 원장
│   ├── coverage.md                 ← 반복당 한 줄 로그 (218 줄)
│   └── impl-progress.md            ← H0~H15 living table, §6 advance log (785 줄)
│
├── playbook/                       ← 단계별 매뉴얼 00부터 07까지
│
└── impl/
    ├── patches/                    ← PT001부터 PT191까지의 패치
    ├── artifacts/
    │   ├── report.md               ← v0.8 최종 리포트
    │   ├── shasum-512.txt          ← SHA512 9개 (jar + demo)
    │   ├── cobblemon-26.1-port.diff   ← 통합 diff (2.5 MB, 947 파일)
    │   ├── label-fix.patch         ← 이름표 수정 단독 패치
    │   ├── jars/                   ← 빌드된 jar (git 제외, GitHub Release에 첨부)
    │   └── demo/demo-iter216-…mp4  ← 60초 데모
    ├── measurements/               ← M001 / M002 / M003 raw CSV와 F3 PNG
    └── cobblemon-port/             ← 26.1 포트 소스 트리 (build 디렉토리는 gitignore)
```

---

## 5. 소스로부터 재현하기

자세한 절차는 [`impl/cobblemon-port/RECONSTITUTE.md`](./impl/cobblemon-port/RECONSTITUTE.md)에 기록해 두었습니다. 요약하면 다음과 같습니다.

```bash
# 1. 이 저장소를 클론합니다
git clone https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph.git
cd minecraft-26.1-cobblemon-ralph

# 2. Cobblemon 업스트림을 base commit에서 체크아웃합니다
cd impl/cobblemon-port
git clone https://gitlab.com/cable-mc/cobblemon.git .
git checkout a3498fe03b
git checkout -b port/26.1.x

# 3. 통합 diff를 적용합니다 (947 파일, +7,473 / −10,931)
git apply ../artifacts/cobblemon-26.1-port.diff

# 4. Java 25 + Gradle 9.2.1 + Loom 1.15.5 환경을 설정합니다
export JAVA_HOME=/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home

# 5. 빌드를 실행합니다 (M-chip Mac 기준 cold 약 2분, incremental 약 34초)
./gradlew :fabric:build --no-daemon --console=plain

# 6. SHA512를 검증합니다
shasum -a 512 fabric/build/libs/Cobblemon-fabric-1.8.0+26.1.2-26.1.x-*.jar
# 예상 값: 02d8cd271b78283cbcb54a0ee1676450c2b7adc42a163d6e1c9e133c871247ae16616f161727aa5d713fa337738f587f7dcadffc2f784cd552aefc0df8a33e28
```

이렇게 빌드한 jar는 곧바로 위쪽 「빠른 설치」 섹션의 4번 단계로 가져가서 사용할 수 있습니다.

---

## 6. 라이선스와 출처

- 업스트림 **Cobblemon**은 **MPL-2.0** 라이선스로 배포됩니다 (<https://gitlab.com/cable-mc/cobblemon>). `impl/cobblemon-port/` 아래의 모든 Kotlin 소스는 Cobblemon에서 파생된 결과물이므로, MPL-2.0 라이선스가 그대로 적용됩니다.
- Ralph loop 도구와 이 챌린지의 솔루션 노트는 MIT 라이선스로 공개합니다. 파일별 커버리지 매트릭스는 [`LICENSE`](./LICENSE) 파일에 정리되어 있습니다.
- **VulkanMod**: xCollateral (<https://github.com/xCollateral/VulkanMod>), LGPL-3.0 라이선스입니다.
- **Beryl**: 이 챌린지 기간 동안 Beryl 26.1.2 빌드를 사용할 수 있도록 해 준 셰이더 파이프라인입니다.
- 자율적인 "Ralph" 반복 기법은 [Geoffrey Huntley의 글](https://ghuntley.com/ralph/)에서 처음 소개되었으며, Claude Code의 공식 **[Anthropic Ralph Loop 플러그인](https://claude.com/plugins/ralph-loop)** 으로 패키징되었습니다 (소스: [`anthropics/claude-plugins-official/plugins/ralph-loop`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop)). 이 프로젝트는 해당 플러그인을 기반으로 실행되었습니다.
- 포켓몬 이름, 디자인, 스프라이트, 사운드와 같은 자산은 The Pokémon Company, Game Freak, Creatures Inc., Nintendo의 지적 재산입니다. 이 저장소는 해당 자산을 변경하거나 재배포하지 않으며, 소유권을 주장하지도 않습니다. 자세한 사항은 [`NOTICE.md`](./NOTICE.md) §3을 참조해 주시기 바랍니다.

---

<p align="center">
  <img src="https://img.shields.io/badge/Built_with-Claude_Code-000000?style=flat-square&logo=anthropic&logoColor=white&labelColor=000000" alt="Built with Claude Code">
  <img src="https://img.shields.io/badge/Powered_by-Ralph_Loop-000000?style=flat-square&labelColor=000000" alt="Powered by Ralph Loop">
  <img src="https://img.shields.io/badge/Iterations-218-000000?style=flat-square&labelColor=000000" alt="218 iterations">
  <img src="https://img.shields.io/badge/Patches-191-000000?style=flat-square&labelColor=000000" alt="191 patches">
  <img src="https://img.shields.io/badge/Checkpoints-16%2F16_PASS-000000?style=flat-square&labelColor=000000" alt="16/16 PASS">
  <img src="https://img.shields.io/badge/Bypass-0-000000?style=flat-square&labelColor=000000" alt="Strict bypass: 0">
</p>

<p align="center">
  <a href="https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/stargazers"><img src="https://img.shields.io/github/stars/TaewoooPark/minecraft-26.1-cobblemon-ralph?style=social" alt="Stars"></a>
  &nbsp;
  <a href="https://github.com/TaewoooPark"><img src="https://img.shields.io/badge/Built_by-%40TaewoooPark-000000?style=flat-square&logo=github&logoColor=white&labelColor=000000" alt="Built by @TaewoooPark"></a>
  <a href="https://claude.com/claude-code"><img src="https://img.shields.io/badge/Driven_by-Claude_Code-000000?style=flat-square&logo=anthropic&logoColor=white&labelColor=000000" alt="Driven by Claude Code"></a>
  <a href="https://claude.com/plugins/ralph-loop"><img src="https://img.shields.io/badge/Plugin-Ralph_Loop_(Anthropic)-000000?style=flat-square&logo=anthropic&logoColor=white&labelColor=000000" alt="Anthropic Ralph Loop Plugin"></a>
</p>

> *[@TaewoooPark](https://github.com/TaewoooPark)가 24시간 동안 제작했습니다. Claude Code가 작업을 구동했으며, 218회의 반복과 191개의 패치를 거쳐 16개의 strict 체크포인트를 모두 통과했습니다.*
