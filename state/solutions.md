# Solution Paths — Index

> 각 경로 = (v?, l?, s?, f?, c?) 5-튜플. 상세는 `solutions/P{nn}-{slug}.md`.
> 반복마다 ≤ 1개씩 등록 (R1).

| ID | v | l | s | f | c | Status | Predicted FPS | Risk | Detail |
|----|---|---|---|---|---|--------|---------------|------|--------|
| P01 | v1 | l1 | s1 | f1 | c0 | OPTIMAL_CANDIDATE | 45–75 | HIGH | [P01](../solutions/P01-26-1-strict-beryl-port.md) — 의도한 strict 경로. Beryl 26.1.x 공식 빌드 확인(V28), Cobblemon 포팅이 핵심 리스크 |
| P02 | v1 | l1 | s4 | f1 | c0 | DRAFT | 75–140 | MEDIUM | [P02](../solutions/P02-26-1-shader-skip.md) |
| P03 | v2 | l1 | s1 | f1 | c0 | DRAFT | 45–75 | MEDIUM | [P03](../solutions/P03-1-21-11-beryl-native.md) — 비의도 fallback/비교 기준. 최종 답으로는 26.1 요건 미충족 |
| P04 | v2 | l1 | s1 | f2 | c0 | DRAFT | 40–70 | MEDIUM | [P04](../solutions/P04-1-21-11-beryl-raycast-labelfix.md) |
| P05 | v2 | l1 | s1 | f1 | c1 | DRAFT | 35–65 | HIGH | [P05](../solutions/P05-1-21-11-beryl-unofficial-create.md) |
| P06 | v3 | l1 | s1 | f1 | c0 | BLOCKED | 50–80 | MEDIUM | [P06](../solutions/P06-1-21-1-cobblemon-native.md) — Beryl 1.21.1 부재 (V13) |
| P07 | v3 | l1 | s2 | f1 | c0 | DRAFT | 55–90 | LOW | [P07](../solutions/P07-1-21-1-iris-no-vulkanmod.md) |
| P08 | v3 | l2 | s1 | f1 | c3 | BLOCKED | 35–70 | HIGH | [P08](../solutions/P08-1-21-1-neoforge-connector-create.md) — Beryl 1.21.1 부재(V02·V21) |
| P09 | v4 | l1 | s1 | f1 | c0 | DRAFT | 50–85 | HIGH | [P09](../solutions/P09-1-20-1-beryl-backport.md) |
| P10 | v4 | l1 | s2 | f1 | c1 | DRAFT | 50–90 | LOW | [P10](../solutions/P10-1-20-1-iris-create-fabric.md) |
| P11 | v2 | l3 | s1 | f1 | c0 | DEPRIORITIZED | 45–75 | MEDIUM | [P11](../solutions/P11-1-21-11-quilt-alt-loader.md) — Quilt 호환 공개 데이터 부족, strict P01 대비 우위 없음 |
| P12 | v1 | l1 | s3 | f1 | c0 | DEPRIORITIZED | 35–60 | HIGH | [P12](../solutions/P12-26-1-custom-spirv.md) — V28 이후 Beryl native가 기본이므로 실험 대체 경로 |

## Legend
- Status: `DRAFT` → `VIABLE` / `BLOCKED` / `OPTIMAL_CANDIDATE`
- Predicted FPS: 추정 범위 (M3 기준)
- Risk: LOW / MEDIUM / HIGH

## Cartesian sketch (참고용, 작성 우선순위)

핵심 12-경로 (셰이더·버전 강조 매트릭스):

1. (v1, l1, s1, f1, c0) — 26.1 strict + Beryl native + Cobblemon 포팅 ★ 의도한 풀이
2. (v1, l1, s4, f1, c0) — 26.1 + 셰이더 포기
3. (v2, l1, s1, f1, c0) — 1.21.11 Beryl-native fallback / 비교 기준
4. (v2, l1, s1, f2, c0) — 1.21.11 Beryl + raycast fix
5. (v2, l1, s1, f1, c1) — 1.21.11 Beryl + 비공식 Create
6. (v3, l1, s1, f1, c0) — 1.21.1 Cobblemon-native + Beryl?
7. (v3, l1, s2, f1, c0) — 1.21.1 + Iris (VulkanMod 미사용)
8. (v3, l2, s1, f1, c3) — 1.21.1 NeoForge + Connector + Create 공식
9. (v4, l1, s1, f1, c0) — 1.20.1 + Beryl 백포팅 (가능성 낮음)
10. (v4, l1, s2, f1, c0) — 1.20.1 + Iris + Create 공식 Fabric
11. (v2, l3, s1, f1, c0) — 1.21.11 Quilt 대체 시나리오
12. (v1, l1, s3, f1, c0) — 26.1 + SPIR-V 커스텀
