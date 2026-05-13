# Run Manual — Cobblemon 26.1.x on M-chip Mac

직접 게임을 실행해서 데모 영상을 찍기 위한 단계별 매뉴얼.
원문제: <https://carpedm30.notion.site/m>

---

## 0. 시스템 요구사항

| 항목 | 값 |
|---|---|
| OS | macOS 15.x (Apple Silicon — M1/M2/M3/M4) |
| JDK | **Java 25** (Mojang requirement for MC 26.1.x) |
| RAM | 8 GB+ (JVM heap 2 GB 권장) |
| GPU | Apple GPU (MoltenVK Vulkan 1.2) |
| 디스크 | ~2 GB (게임 + 모드 + 월드) |

---

## 1. JDK 25 설치

```bash
brew install openjdk@25

# 확인
export JAVA_HOME=/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home
$JAVA_HOME/bin/java --version
# → openjdk 25.x.x
```

---

## 2. Minecraft 26.1.2 설치

**옵션 A: 공식 런처**
1. <https://www.minecraft.net/ko-kr/download> 에서 macOS용 다운로드
2. 런처 실행 → 로그인
3. "Installations" → "New Installation" → Version=`release 26.1.2` → Create → Play 한 번
   (한 번 실행해서 26.1.2 클라이언트 jar를 받아두는 게 목적)
4. 종료

**옵션 B: Prism Launcher** (권장 — 인스턴스 격리)
```bash
brew install --cask prismlauncher
```
Prism 실행 → Add Instance → Vanilla → 26.1.2 선택.

---

## 3. Fabric Loader 0.19.2 설치

```bash
# Fabric Installer 다운로드
curl -L -o /tmp/fabric-installer.jar \
  https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.1.0/fabric-installer-1.1.0.jar

# Client 프로파일 생성
$JAVA_HOME/bin/java -jar /tmp/fabric-installer.jar client \
  -mcversion 26.1.2 -loader 0.19.2 -dir ~/Library/Application\ Support/minecraft
```

런처를 다시 열면 `fabric-loader-0.19.2-26.1.2` 프로파일이 보입니다. Prism 사용 시 인스턴스 Edit → Version → Add Fabric → 0.19.2.

---

## 4. 모드 5개를 `mods/` 폴더에 복사

**모드 폴더 위치**
- 공식 런처: `~/Library/Application Support/minecraft/mods/`
- Prism: `~/Library/Application Support/PrismLauncher/instances/<instance>/.minecraft/mods/`

```bash
mkdir -p ~/Library/Application\ Support/minecraft/mods
cd ~/Library/Application\ Support/minecraft/mods
```

**필수 5종 — 다운로드**

| 모드 | 버전 | 소스 |
|---|---|---|
| Fabric API | `0.148.2+26.1.2` | <https://modrinth.com/mod/fabric-api/versions?g=26.1.2> |
| Fabric Language Kotlin | `1.13.11+kotlin.2.3.21` | <https://modrinth.com/mod/fabric-language-kotlin> |
| VulkanMod | `26.1.2-0.6.5` | <https://github.com/xCollateral/VulkanMod/releases> |
| Beryl (shader bridge) | `26.1.2-0.1.3-alpha+1` | (VulkanMod releases 페이지 또는 Modrinth) |
| **Cobblemon-PT191s** | `1.8.0+26.1.2-PT191s-h10-textures` | **이 레포의 `impl/artifacts/jars/`** (포팅 산출물) |

**Cobblemon jar 복사** (이 레포 기준):
```bash
cp /Users/taewoopark/Desktop/Obsidian-Sync/Mincraft-Challenge/impl/artifacts/jars/Cobblemon-fabric-1.8.0+26.1.2-PT191s-h10-textures.jar \
   ~/Library/Application\ Support/minecraft/mods/
```

**SHA512 검증** (포팅 산출물 무결성):
```bash
shasum -a 512 ~/Library/Application\ Support/minecraft/mods/Cobblemon-fabric-1.8.0+26.1.2-PT191s-h10-textures.jar
# 기대값:
# 02d8cd271b78283cbcb54a0ee1676450c2b7adc42a163d6e1c9e133c871247ae16616f161727aa5d713fa337738f587f7dcadffc2f784cd552aefc0df8a33e28
```

---

## 5. 게임 실행 + Beryl 셰이더 켜기

1. 런처에서 Fabric 26.1.2 프로파일 Play
2. 메인 메뉴 → Options → Video Settings → **VulkanMod** 활성 확인
3. Options → **Shaders** → `Beryl-default` 선택 → Apply
4. F3 오버레이 좌상단에 `Vulkan: MoltenVK X.X.X` 표시 확인

---

## 6. 크리에이티브 월드 + 포켓몬 스폰

1. Singleplayer → Create New World
2. Game Mode = **Creative**, Cheats = **ON**, Difficulty = Peaceful
3. 월드 진입 후 채팅창(`T` 키)에서 스폰 커맨드:

```
/gamemode creative
/pokespawn pikachu
/pokespawn charmander
/pokespawn squirtle
/pokespawn bulbasaur
/pokespawn eevee
```

> ⚠️ **`/summon cobblemon:pokemon ... {Pokemon:{Species:"pikachu"}}` 를 쓰지 마세요.**
> Vanilla `/summon` 의 NBT 페이로드는 Cobblemon 의 species deserialize 체인보다 늦게 적용돼서
> Species 필드가 무시되고 **랜덤 종**이 spawn됩니다 (H7 검증에서도 Pineco/Shroomish/Azurill 등이 나옴).
> Cobblemon 전용 명령 **`/pokespawn <species>`** 가 정확한 종을 보장합니다.

**대안 1** — 레벨까지 지정:
```
/pokespawn pikachu level=50
```

**대안 2** — 인벤토리에 직접 가하기 (전투 시연용):
```
/pokegive @s pikachu
/pokegive @s charmander
```

**대안 3** — 인벤토리(`E`)에서 검색창에 `cobblemon:pokemon` → Spawn Egg를 우클릭으로 배치.

**팁**: 야간이면 `/time set day`, 평지가 필요하면 `/setworldspawn`.

---

## 7. FPS 확인 (`F3` 디버그 오버레이)

- `F3` 키 → 좌상단에 `XXX fps` 표시
- **기대값**: 5마리 가시 상태 + Beryl 셰이더 ON 기준 **≥ 60 FPS** (이 레포 측정 118 FPS — M003)
- `F3 + A` = 청크 리로드, `F3 + T` = 텍스처 리로드

---

## 8. 영상 촬영 가이드

**촬영 도구** (macOS):
- QuickTime Player: File → New Screen Recording → 창 선택
- **권장: OBS** (`brew install --cask obs`) — 화면 + 오디오 + 60 FPS 캡처

**캡처할 장면** (60초 권장):
| 0-10s | 메인 메뉴 → "Singleplayer" 클릭, 월드 진입 |
| 10-25s | F3 켜고 좌상단 FPS·Vulkan·shader 라인 보이게 (2-3초 정지) |
| 25-45s | 포켓몬 5마리가 한 프레임에 보이는 위치로 카메라 이동, 회전하며 텍스처 확인 |
| 45-60s | 포켓몬 가까이 가서 nameplate(이름표)가 벽 뒤에서 가려지는지 확인 (PT151 label-fix 시연) |

**파일 저장**:
```bash
# 영상 변환 (ffmpeg) — 용량 압축
ffmpeg -i ~/Desktop/raw-demo.mov -c:v libx264 -crf 23 -preset slow \
       -vf "scale=1280:720" -an demo.mp4

# SHA512 기록 (선택)
shasum -a 512 demo.mp4
```

---

## 9. 문제 해결

| 증상 | 원인 / 조치 |
|---|---|
| 게임이 시작 전 크래시 | JDK 25 아님 — `java --version` 확인 |
| "Fabric Loader requires version ≥0.18.4" | Fabric Loader 버전 낮음 — 0.19.2로 재설치 |
| "Mod cobblemon requires version of fabric-api ≥0.148.2" | Fabric API 버전 낮음 — Modrinth에서 26.1.2 버전 다운 |
| 포켓몬이 안 보이고 회색 큐브로 나옴 | PT191s가 아닌 **이전 PT170 jar** 사용 중 — SHA512 재확인 |
| **"pikachu" 라고 쳤는데 다른 종이 나옴** | **vanilla `/summon` 의 NBT 페이로드는 Cobblemon species deserialize 이후에 적용되므로 무시됨.** 반드시 `/pokespawn pikachu` 사용. `/summon cobblemon:pokemon` 만 쓰면 cobblemon 이 random species 를 할당함 (H7 검증에서도 Pineco/Shroomish/Azurill 등 랜덤이 나옴) |
| 셰이더가 안 켜지고 메뉴 항목 없음 | Beryl 미설치 또는 VulkanMod 누락 |
| FPS < 60 | (a) 렌더 거리 → 12 chunks 이하, (b) 청크 시뮬레이션 거리 8, (c) Fancy Clouds OFF |

---

## 10. 검증 데이터 (이 레포 측정 결과)

| 시나리오 | FPS | 파일 |
|---|---|---|
| T1 baseline (no Cobblemon, shader ON) | **115.2** | `impl/measurements/M001-iter202-T1-baseline-shaderON-noCobblemon.csv` |
| T2 5-Pokemon (shader ON) | **121.4** | `impl/measurements/M002-iter205-T2-cobblemon-5pokemon-shaderON.csv` |
| T2 5-Pokemon + 텍스처 적용 (PT191s) | **118** | `impl/measurements/M003-iter216-T2-PT191-textured-pokemon.csv` |

스크린샷 증거: `impl/measurements/PT191-pokemon-F3-118fps-iter216.png`
