# C1: Beryl ↔ Minecraft 26.1 Compatibility

- **Severity**: RESOLVED
- **Discovered**: iter#1
- **Status**: CLOSED by V28
- **Related Paths**: P01 (26.1 strict), P03 (1.21.11 fallback)

## What
초기 조사에서는 Beryl이 MC 1.21.9–1.21.11만 지원한다고 봤지만, 2026-05-12 재검증 결과 **Beryl 0.1.3-alpha+1이 26.1 / 26.1.1 / 26.1.2 Fabric 빌드로 배포**되어 있다. 따라서 "MC 26.1 + VulkanMod + Beryl" 조합은 문자 그대로 성립한다.

## Why it matters
Beryl 포팅 리스크가 사라졌으므로, 문제를 의도한 대로 풀 때의 1차 관문은 더 이상 C1이 아니라 **Cobblemon 1.21.1 → 26.1.x 포팅(C2)**이다. VulkanMod과 Beryl은 26.1.2 공식 jar 페어로 베이스라인을 만들 수 있다.

## Evidence
- <https://modrinth.com/mod/beryl> — 지원 게임 버전 목록에 26.1.x와 1.21.9–1.21.11 포함 (V28)
- Modrinth API — `beryl_26.1.2-0.1.3-alpha+1.jar`, SHA512 prefix `584f2cf5783ee5e5a` (V28)
- <https://minecraft.wiki/w/Java_Edition_26.1> — 26.1은 별도 메이저 버전 라인이며 모드 호환은 1.21.x와 분리됨 (V01, VERIFIED)

## Possible Mitigations
- **M1 — 26.1.2 native 페어 사용**: VulkanMod 0.6.5 + Beryl 0.1.3-alpha+1을 strict baseline으로 채택.
- **M2 — 1.21.11 fallback 유지**: strict 경로가 Cobblemon 포팅에서 막힐 때만 비교 데모로 보존. 최종 답으로는 26.1 요건 미충족.

## Open Questions
- Beryl alpha가 Cobblemon 포팅본의 커스텀 모델/렌더타입과 함께 60FPS를 유지하는가? Step 04에서 실측한다.

## Sources
- <https://modrinth.com/mod/beryl>
- <https://minecraft.wiki/w/Java_Edition_26.1>
- <https://modrinth.com/mod/vulkanmod>
