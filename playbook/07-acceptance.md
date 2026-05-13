# Playbook 07 — Acceptance Criteria

> Phase 2 / Step 7. strict premise에서 챌린지 통과 조건과 제출 패키지를 정의한다.

---

## 0. Non-Negotiable Premise

최종 답은 반드시 다음을 만족해야 한다.

```text
Minecraft 26.1.x
Fabric
VulkanMod
Beryl
Cobblemon
label bug fixed as intended
```

버전을 `1.21.11`, `1.21.1`, `1.20.1`로 낮춘 결과물은 fallback 데모일 뿐 통과 조건이 아니다.

---

## 1. PASS Conditions

| 영역 | 조건 |
|---|---|
| Version | Minecraft 26.1.x, 권장 26.1.2 |
| Loader | Fabric |
| Renderer | VulkanMod 26.1.x jar |
| Shader | Beryl 26.1.x jar, shader ON |
| Cobblemon | 자체 26.1.x 포팅본, Pokémon spawn 가능 |
| Label fix | 벽 뒤 이름표 미노출, 정상 시야에서는 라벨 표시 |
| Performance | Cobblemon 5마리 + shader ON 평균 60FPS 이상 |
| Evidence | modlist, SHA512, FPS CSV, screenshot/video, source patch/diff |

---

## 2. Conditional Clarifications

| 질문 | 기본 판단 |
|---|---|
| Beryl 통합 파이프라인이 "셰이더"로 인정되는가? | Yes. 문제에 Beryl이 명시되어 있다. |
| 60FPS 기준은 무엇인가? | 평균 FPS를 pass 기준, 1% low를 보조 지표로 기록한다. |
| 외부 mixin이 label fix로 인정되는가? | source patch 우선. 외부 mixin은 같은 동작이면 인정 가능 fallback. |
| Config OFF가 label fix인가? | 아니다. 비의도 회피로만 기록한다. |
| Create가 필수인가? | 본문 strict보다 후순위 optional. core pass와 분리한다. |

---

## 3. Scenario Matrix

| Scenario | 결과 | 제출 문구 |
|---|---|---|
| P01 all pass | strict pass | "의도한 스택으로 해결" |
| P01 baseline pass, Cobblemon port fail | strict fail | "Beryl/Vulkan baseline은 성립, Cobblemon 26.1 포팅이 blocking" |
| P01 port pass, FPS fail | strict fail 또는 partial | "기능 통합은 성립, 60FPS 기준 미달" |
| P01 fail, P03/P07/P10 pass | strict fail + comparison | "fallback 데모 첨부, 최종 답 아님" |
| Config OFF only | strict incomplete | "라벨 제거 회피, intended fix 아님" |

---

## 4. Required Artifacts

1. `modlist.txt`
2. `shasum-512.txt`
3. `fps-results.csv`
4. `demo.mp4`
5. `screenshots/label-before-after/`
6. `cobblemon-26.1-port.diff` 또는 fork URL
7. `label-fix.patch` 또는 `label-fix-mixin/`
8. `report.md`

`report.md`에는 반드시 다음을 적는다.

- 사용한 Minecraft/Fabric/VulkanMod/Beryl/Cobblemon 버전
- Cobblemon 26.1 포팅 범위
- label fix 방식
- FPS 측정 조건
- 실패 또는 fallback이 있다면 strict 기준에서 왜 합격이 아닌지

---

## 5. Step 07 PASS

Step 07은 단순 문서 마감이 아니라 챌린지 acceptance다.

PASS:

- Step 01, 02, 03, 04가 모두 통과
- 제출 산출물이 모두 존재
- fallback이 최종 답으로 섞이지 않음

FAIL/PARTIAL:

- 위 non-negotiable premise 중 하나라도 빠짐
- fallback 결과를 strict 성공처럼 기술함
- label을 제거만 하고 intended fix로 주장함

---

## Sources

- `state/synthesis.md`
- `state/verification.md`
- `playbook/00-manifest.md`
- `playbook/05-fallback-tree.md`
