# Playbook 01 — M-chip Mac Environment Setup

> Phase 2 / Step 1. P01 strict baseline: **26.1.x + Fabric + VulkanMod + Beryl**가 먼저 60FPS를 통과해야 한다.

---

## 0. Goal

`playbook/00-manifest.md`의 runtime 요구사항을 만족하고, **빈 26.1.2 + VulkanMod 0.6.5 + Beryl 0.1.3-alpha+1** 인스턴스가 M-chip Mac에서 평균 60FPS 이상으로 부팅하는지 확인한다.

통과 시그널:

- main menu 진입
- superflat world 진입
- VSync OFF, render distance 12에서 평균 FPS ≥ 60
- `latest.log`에 Vulkan/MoltenVK device 로그 존재

---

## 1. Java 21 Runtime

권장:

```bash
brew install --cask temurin@21
```

검증:

```bash
java --version
arch -arm64 java --version
```

ARM64 native JVM만 사용한다. Rosetta/x86_64 JVM은 MoltenVK 경로와 성능 측정을 오염시킨다.

---

## 2. Launcher Profile

Prism Launcher 권장:

```bash
brew install --cask prismlauncher
```

프로파일:

- Name: `cobblemon-p01-26.1`
- Version: `26.1.2` 또는 최신 `26.1.x`
- Mod loader: Fabric 최신 stable
- Memory: Initial 2048M, Max 8192M
- Java path: ARM64 Temurin 21

공식 Minecraft Launcher를 써도 되지만, modlist와 로그 수집은 Prism이 더 쉽다.

---

## 3. Fabric Loader 26.1.x

GUI 인스톨러:

1. <https://fabricmc.net/use/installer/> 실행
2. Client 탭
3. Minecraft Version: `26.1.2` 또는 최신 `26.1.x`
4. Loader Version: 최신 stable
5. Create profile

CLI/서버 jar URL은 26.1.x용 Fabric meta가 노출된 경우에만 사용한다. 실패하면 GUI 인스톨러로 돌아간다.

---

## 4. Mod Jar Placement

`mods/`에 Step 00 core jar만 먼저 넣는다.

```text
fabric-api-{ver}+26.1.x.jar
VulkanMod_26.1.2-0.6.5.jar
beryl_26.1.2-0.1.3-alpha+1.jar
```

Cobblemon과 label fix는 Step 02·03에서 빌드 후 추가한다. baseline 단계에서는 VulkanMod+Beryl만 측정한다.

---

## 5. MoltenVK / Vulkan Verification

부팅 후:

1. F3 debug screen에서 GPU가 Apple M-series인지 확인
2. VulkanMod 옵션 화면에서 Apple GPU device 확인
3. `logs/latest.log` 검색:

```bash
grep -i "moltenvk\|vulkan device\|portability_subset" logs/latest.log
```

이상 신호:

| 증상 | 조치 |
|---|---|
| `Failed to find Vulkan loader` | ARM64 JVM과 LWJGL/Fabric 버전 확인 |
| GPU가 Apple Silicon으로 안 보임 | Rosetta 사용 여부 확인 |
| Beryl 추가 후 검은 화면 | VulkanMod 단독 baseline 먼저 측정, Beryl alpha 회귀로 기록 |

---

## 6. Baseline FPS Measurement

| Scenario | World | RD | VSync | Mods | 측정 시간 | 합격 |
|---|---|---|---|---|---|---|
| S1 | Superflat | 12 | OFF | VulkanMod+Beryl | 60s | ≥ 60 avg |
| S2 | Default plain biome | 16 | OFF | VulkanMod+Beryl | 60s | ≥ 60 avg 권장 |
| S3 | Default fast flight | 24 | OFF | VulkanMod+Beryl | 60s | 참고 |

절차:

1. 30초 워밍업
2. 60초 평균/1% low/min 기록
3. `latest.log`와 스크린샷 저장

S1이 60 미만이면 P01 성능 위험으로 기록한다. Beryl OFF 기준선도 측정해 Beryl alpha 비용인지, VulkanMod/MoltenVK 비용인지 분리한다.

---

## 7. Step 01 PASS Artifacts

- `logs/latest.log`
- S1/S2/S3 FPS 표
- F3 debug screenshot
- jar SHA512 prefix 확인 결과

이 네 가지가 있으면 Step 02로 진행한다.

---

## Sources

- Mojang Java 21 요건: <https://www.minecraft.net/en-us/article/minecraft-snapshot-24w14a>
- Prism Launcher: <https://prismlauncher.org/>
- Fabric Installer: <https://fabricmc.net/use/installer/>
- VulkanMod macOS/MoltenVK 근거: V07·V16
- P01 jar manifest: `00-manifest.md`
