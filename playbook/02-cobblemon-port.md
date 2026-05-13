# Playbook 02 — Cobblemon 1.21.1/main → 26.1.x 자체 포팅

> Phase 2 / Step 2. strict 풀이의 핵심 병목.
> Cobblemon 공식 26.1.x 빌드는 없으므로[V04·V14], P01은 이 mini-port 없이는 성립하지 않는다.

---

## 0. Starting Point

Cobblemon `main` 브랜치 기준:

```properties
minecraft_version = 1.21.1
java_version = 21
parchment_mappings = 2024.07.28@zip
mod_version = 1.8.0
group = com.cobblemon.mod
```

빌드 시스템은 Gradle + Kotlin multi-loader다. Java 21은 Step 01 환경과 일치한다.

---

## 1. Port Scope

`1.21.1 → 26.1.x`는 단순 minor bump가 아니다. 26.1은 unobfuscated 전환으로 pre-26.1 mod는 최소 재컴파일과 mapping migration이 필요하다[V08].

우선순위:

| 영역 | 위험 | 처리 |
|---|---|---|
| Gradle/Fabric API 버전 | 낮음 | 먼저 bump |
| Parchment/Mojang official mapping | 중간 | 26.1.x에서 가능한 mapping 조합 선택 |
| Entity renderer / RenderState | 높음 | `PokemonRenderer` compile error부터 처리 |
| Registry / Data codec | 높음 | spawn, species registry, resource loading 우선 |
| Mixins | 중간 | target signature를 26.1.x bytecode에 맞춰 갱신 |
| 부수 기능 | 낮음 | 24h 데모에서는 제외 |

목표는 전체 기능 포팅이 아니라 **main menu + Pokémon 1마리 spawn + 렌더 정상**이다.

---

## 2. Prepare Repository

```bash
git clone https://gitlab.com/cable-mc/cobblemon.git cobblemon-26.1-port
cd cobblemon-26.1-port
git checkout main
git checkout -b port/26.1
./gradlew --version
```

검증:

- JVM 21
- Gradle wrapper 실행 가능
- baseline `1.21.1` build가 깨지지 않는지 먼저 확인하면 원인 분리가 쉽다.

---

## 3. Version Bump

`gradle.properties`와 버전 catalog를 26.1.x로 맞춘다.

```diff
-minecraft_version = 1.21.1
+minecraft_version = 26.1.2
-parchment_mappings = 2024.07.28@zip
+parchment_mappings = <26.1.x 호환 최신 또는 Mojang official fallback>
```

Fabric 쪽:

```diff
-fabric_loader_version = 0.16.x
+fabric_loader_version = <26.1.x 호환 최신>
-fabric_api_version = 0.106.x+1.21.1
+fabric_api_version = <26.1.x 호환 최신>
```

정확한 버전 번호는 실행 시점의 Fabric/Modrinth 메타에서 확인한다.

---

## 4. First Build And Triage

```bash
./gradlew :fabric:build
```

오류 triage 순서:

1. Gradle dependency/version resolution
2. mapping 이름 변경
3. `PokemonRenderer` / entity renderer compile errors
4. registry/data codec errors
5. mixin target errors

각 오류는 `build-attempt-N.log`로 보관한다. strict 실패 시 이 로그가 보고서 핵심 근거가 된다.

---

## 5. Known Patch Areas

### 5.1 PokemonRenderer / RenderState

라벨 수정과 엔티티 렌더가 같은 파일에 걸려 있다.

```text
common/src/main/kotlin/com/cobblemon/mod/common/client/render/pokemon/PokemonRenderer.kt
```

26.1.x에서 renderer signature가 바뀌면 다음 방식으로 최소 이식한다.

1. Pokémon 전용 render state 클래스 또는 기존 state 확장
2. species, level, battle prompt, label component를 render state에 복사
3. 기존 renderNameTag logic은 최대한 유지
4. Step 03 label patch를 같은 source tree에 적용

### 5.2 Registry / Spawn

목표는 `/pokemon spawn pikachu` 또는 동등한 명령으로 1마리를 띄우는 것이다. 전투, worldgen, economy, multiplayer 기능은 24h core gate 밖이다.

### 5.3 Mixins

26.1.x bytecode에서 target signature를 다시 추출한다. 실패한 mixin은 부팅을 막는 것부터 처리하고, cosmetic mixin은 임시 disable 후보로 둔다.

---

## 6. Build Artifacts

성공 시:

```bash
./gradlew :fabric:remapJar
```

기대 산출물:

```text
fabric/build/libs/cobblemon-fabric-1.8.0+26.1.x.jar
```

이 jar를 Step 01의 `mods/`에 추가하고 VulkanMod+Beryl과 동시 부팅한다.

---

## 7. PASS Conditions

1. `./gradlew :fabric:build` 성공
2. `./gradlew :fabric:remapJar` 성공
3. client main menu 진입
4. world 진입
5. Pokémon 1마리 spawn 및 렌더 정상
6. critical mixin failure 0건

6h 안에 3번까지 못 가면 strict 실패 가능성이 높다. 그래도 fallback으로 버전을 완화하지 않고, 실패 원인과 진행도를 기록한다.

---

## 8. License / Distribution

Cobblemon은 MPL 2.0이다. 포팅 diff는 같은 라이선스 조건을 존중해 공개 가능한 형태로 정리한다.

제출 문구:

```text
Cobblemon by cable-mc, ported to Minecraft 26.1.x for this challenge.
```

---

## Sources

- Cobblemon GitLab: <https://gitlab.com/cable-mc/cobblemon>
- Cobblemon Modrinth: <https://modrinth.com/mod/cobblemon/versions>
- Fabric porting guide: <https://docs.fabricmc.net/develop/porting/>
- MPL 2.0: <https://www.mozilla.org/en-US/MPL/2.0/>
- 검증: V04, V08, V14
