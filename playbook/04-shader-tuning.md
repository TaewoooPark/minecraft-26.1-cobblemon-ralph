# Playbook 04 — Beryl Shader Tuning & 60 FPS

> Phase 2 / Step 4. strict 통합 환경에서 shader ON + Cobblemon 60FPS를 맞춘다.

---

## 0. Goal

대상 환경:

```text
Minecraft 26.1.x
Fabric
VulkanMod_26.1.2-0.6.5.jar
beryl_26.1.2-0.1.3-alpha+1.jar
Cobblemon 26.1.x self-port
label fix
```

합격선:

| Scenario | 조건 | 평균 FPS 합격 | 1% low 권장 |
|---|---|---|---|
| T1 | 빈 평지 + shader ON, RD 12 | ≥ 75 | ≥ 50 |
| T2 | Cobblemon 5마리 + shader ON, RD 16 | **≥ 60** | ≥ 40 |
| T3 | Cobblemon 20마리 + shader ON, RD 16 | ≥ 45 | ≥ 30 |

T2가 핵심이다.

---

## 1. Beryl Settings

Beryl 0.1.x는 alpha라 옵션 UI가 제한적일 수 있다. 노출된 옵션만 보수적으로 낮춘다.

| 카테고리 | 권장 시작값 | 실패 시 |
|---|---|---|
| Shadow map | 1024 | 512 |
| Shadow distance | 80 blocks | 48 blocks |
| Soft shadows | OFF | OFF 유지 |
| SSAO | Low | OFF |
| Volumetric light | OFF | OFF 유지 |
| Bloom | Low | OFF |
| Water reflections | Low / screen-space | OFF |

옵션 UI가 없으면 VulkanMod/vanilla video setting으로만 조정한다.

---

## 2. VulkanMod / Vanilla Settings

| 옵션 | 권장 |
|---|---|
| Render Distance | 16, 미달 시 12 |
| Simulation Distance | 8 |
| Entity Distance | 100% |
| VSync | OFF |
| Max FPS | 120 |
| Particles | Decreased |
| Mipmaps | 4 |
| Clouds | Fast 또는 OFF |

macOS:

- AC 전원 연결
- Low Power Mode OFF
- ProMotion은 120Hz 고정 또는 VSync OFF 유지
- 백그라운드 CPU/GPU 앱 종료

---

## 3. Measurement Protocol

표준화:

```text
/time set noon
/gamerule doDaylightCycle false
/weather clear 1000000
/tp @s 0 80 0
```

T2 spawn 예:

```text
/pokemon spawn pikachu
/pokemon spawn charizard
/pokemon spawn bulbasaur
/pokemon spawn squirtle
/pokemon spawn jigglypuff
```

측정:

1. 90초 워밍업
2. 60초 평균/1% low/min 기록
3. F3 screenshot 및 영상 캡처
4. label fix가 유지되는지 같은 월드에서 확인

---

## 4. Decision Table

| T2 평균 FPS | 결정 |
|---|---|
| ≥ 75 | 여유. optional Create PoC 검토 가능 |
| 60–74 | strict pass |
| 45–59 | Beryl 옵션 하향, RD 12 재측정 |
| 30–44 | Beryl OFF 기준선 측정 후 alpha 비용 기록 |
| < 30 | P01 성능 실패로 기록, fallback 데모 분리 |

---

## 5. PASS Conditions

1. T2 평균 ≥ 60
2. shader ON 상태 screenshot/video
3. Cobblemon 5마리 이상 렌더 정상
4. label fix 회귀 없음
5. 30분 플레이 중 critical crash 없음

---

## Sources

- Beryl/VulkanMod 26.1.x jar: V28·V29
- VulkanMod macOS/MoltenVK 근거: V07·V16
- VulkanMod incompat 목록: V06·V18
- Manifest: `00-manifest.md`
