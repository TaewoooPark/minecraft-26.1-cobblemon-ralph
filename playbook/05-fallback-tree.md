# Playbook 05 — Failure / Fallback Decision Tree

> Phase 2 / Step 5. strict P01이 막힐 때 무엇을 기록하고 어떤 비교 데모를 만들지 정한다.

---

## 0. Principles

1. 최우선 경로는 **P01 strict**다.
2. fallback은 최종 합격 경로가 아니다.
3. 실패는 객관 수치와 로그로 남긴다.
4. 버전을 낮춰 성공한 데모는 "비의도 비교 자료"로 분리한다.

---

## 1. Failure Matrix

| 발생 Step | 실패 시그널 | 1차 처리 | 해결 안 되면 |
|---|---|---|---|
| Step 01 | VulkanMod+Beryl 26.1.x 부팅 실패 | jar SHA/Fabric API 재확인 | P01 baseline 실패 기록, VulkanMod 단독 측정 |
| Step 01 | S1 평균 FPS < 60 | Beryl 옵션/ON-OFF 분리 측정 | P01 성능 실패 기록, P02 기준선 |
| Step 02 | Cobblemon build dependency 실패 | 버전 catalog/Fabric API 조정 | build log 첨부, P03/P07 비교 데모 여부 결정 |
| Step 02 | renderer/registry compile error가 6h 내 해소 안 됨 | renderer부터 scope 축소 | strict 미완 기록 |
| Step 03 | source label patch 실패 | external mixin 시도 | config OFF는 비의도 fallback으로만 표기 |
| Step 04 | T2 60FPS 미달 | Beryl low preset/RD12 재측정 | 성능 실패 기록 |
| Step 06 | Create PoC 실패 | Create 제거 | core P01에는 영향 없음 |

---

## 2. Non-Acceptance Fallbacks

### P03 — 1.21.11 Beryl-native

사용 목적:

- Beryl/VulkanMod와 label fix 개념을 26.1보다 작은 API gap에서 비교한다.
- strict 실패의 원인이 Cobblemon 26.1 포팅인지 분리한다.

주의:

- 26.1 요건을 만족하지 않는다.
- 성공해도 P01 대체 합격이 아니다.

### P07 — 1.21.1 + Iris + Cobblemon official

사용 목적:

- Cobblemon 공식 환경에서 label fix와 FPS를 빠르게 시연한다.

주의:

- VulkanMod+Beryl을 포기한다.
- strict 문제를 의도대로 푼 것이 아니다.

### P10 — 1.20.1 + Iris + Cobblemon official + Create official

사용 목적:

- Create까지 포함한 안정 데모를 만든다.

주의:

- 26.1, VulkanMod, Beryl을 모두 벗어난다.
- optional 심화 비교 자료로만 쓴다.

---

## 3. P02 Baseline

P02는 `26.1.x + VulkanMod + Cobblemon + label fix + shader OFF` 기준선이다.

용도:

- Beryl alpha 비용 분리
- Cobblemon 포팅 성공 여부 독립 확인

주의:

- Beryl shader ON 요건을 만족하지 않으므로 합격 경로가 아니다.

---

## 4. Failure Log Template

`state/coverage.md`에 다음 형태로 남긴다.

```text
- iter#NN 2026-05-12 strict-fail:<step> :: P01 <gate> failed at <elapsed>; evidence=<fps/log/error>; fallback=<comparison only>
```

예:

```text
- iter#NN 2026-05-12 strict-fail:Step02 :: Cobblemon 26.1 port did not reach main menu by 6h; evidence=build-attempt-4.log RenderState errors; fallback=P07 comparison only
```

---

## 5. Final Rule

fallback 영상이 더 보기 좋아도 최종 보고서의 결론은 바꾸지 않는다.

- P01 성공: strict pass
- P01 실패 + fallback 성공: strict fail, comparison demo attached
- P01 실패 + fallback 실패: strict fail, failure evidence attached

---

## Sources

- `state/synthesis.md`
- `state/verification.md`
- `solutions/P01-26-1-strict-beryl-port.md`
- `solutions/P03-1-21-11-beryl-native.md`
- `solutions/P07-1-21-1-iris-no-vulkanmod.md`
- `solutions/P10-1-20-1-iris-create-fabric.md`
