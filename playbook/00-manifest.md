# Playbook 00 — Mod Jar Manifest (P01: 26.1 Strict)

> Phase 2 / Step 0. strict 경로 P01의 jar 매니페스트.
> 모든 버전·해시는 2026-05-12 재검증 기준이다.

---

## Target Stack Tuple

**P01 = `(v1=MC 26.1.x, l1=Fabric, s1=Beryl native, f1=source/mixin label fix, c0=Skip Create)`**

최종 답은 이 tuple을 유지해야 한다. `1.21.11` 계열은 fallback 비교군이다.

---

## 1. Core Stack

| # | Component | Version | Loader | File / Source | SHA512 prefix | 검증 |
|---|---|---|---|---|---|---|
| 1 | Minecraft | 26.1.x, 권장 26.1.2 | — | <https://minecraft.wiki/w/Java_Edition_26.1> | — | V08 |
| 2 | Fabric Loader | 26.1.x 호환 최신 | Fabric | <https://fabricmc.net/use/installer/> | — | V08 |
| 3 | Fabric API | 26.1.x 호환 최신 | Fabric | <https://modrinth.com/mod/fabric-api> | — | 보조 |
| 4 | VulkanMod | 0.6.5 | Fabric | `VulkanMod_26.1.2-0.6.5.jar` | `437bb0e4ba7d5873` | V29 |
| 5 | Beryl | 0.1.3-alpha+1 | Fabric | `beryl_26.1.2-0.1.3-alpha+1.jar` | `584f2cf5783ee5e5a` | V28 |
| 6 | Cobblemon | 1.21.1/main 기반 자체 26.1.x 포팅 | Fabric | <https://gitlab.com/cable-mc/cobblemon> | — | V04·V14 |
| 7 | Label fix | Cobblemon source patch 우선 | Fabric | `PokemonRenderer.renderNameTag` | — | V09·V22 |

---

## 2. Compatibility Matrix

| Pair | 판단 | 출처 |
|---|---|---|
| VulkanMod 0.6.5 ↔ Beryl 0.1.3-alpha+1 | 26.1.2 official jar 페어 존재 | V28·V29 |
| VulkanMod ↔ Sodium/Iris/OptiFine | 공식 비호환 | V06·V18 |
| VulkanMod ↔ EntityCulling | 공식 비호환 | V06·V24 |
| Cobblemon ↔ 26.1.x | 공식 빌드 없음, 자체 포팅 필요 | V04·V14 |
| macOS M-chip ↔ VulkanMod | MoltenVK 경로 동작 근거 있음 | V07·V16 |

---

## 3. Explicit Exclusions

strict manifest에는 다음을 넣지 않는다.

- Sodium, Iris, OptiFine, EntityCulling
- Globox/Nameplate류 이름표 대체 모드
- Cobblemon 부수 모드
- Create 계열. optional 심화는 Step 06에서 core pass 이후 별도 PoC로만 다룬다.

---

## 4. Java / Runtime Requirements

| 항목 | 값 |
|---|---|
| Java | JDK 21 ARM64 |
| Memory | 권장 `-Xmx8G -Xms2G` |
| GPU | Apple Silicon M1/M2/M3/M4 |
| macOS | MoltenVK가 포함된 LWJGL3 경로 사용 |
| Vulkan SDK | 수동 설치 불필요[V16] |

---

## 5. Download / Integrity Check

실행 직전 Modrinth API에서 jar URL을 다시 가져와 다운로드한다.

```text
VulkanMod_26.1.2-0.6.5.jar
beryl_26.1.2-0.1.3-alpha+1.jar
fabric-api-{ver}+26.1.x.jar
```

검증:

```bash
shasum -a 512 VulkanMod_26.1.2-0.6.5.jar
shasum -a 512 beryl_26.1.2-0.1.3-alpha+1.jar
```

기대 prefix:

- VulkanMod: `437bb0e4ba7d5873`
- Beryl: `584f2cf5783ee5e5a`

---

## 6. Remaining Assumptions

| ID | 가정 | Step | 검증 방법 |
|---|---|---|---|
| A0.1 | Fabric API 26.1.x 최신 빌드가 VulkanMod+Beryl과 함께 부팅 | 01 | 빈 인스턴스 부팅 |
| A0.2 | Beryl alpha가 Cobblemon 모델 렌더와 충돌하지 않음 | 04 | 30분 T2/T3 측정 |
| A0.3 | Cobblemon 26.1.x 포팅 범위가 24h 내 최소 데모까지 가능 | 02 | compile/main menu/spawn gate |

---

## Sources

- Beryl Modrinth API: V28
- VulkanMod Modrinth API: V29
- VulkanMod incompat 공식: V06·V18
- Cobblemon Modrinth/GitLab: V04·V14
- Fabric 26.1 context: V08
