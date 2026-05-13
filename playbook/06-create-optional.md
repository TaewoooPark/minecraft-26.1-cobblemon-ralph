# Playbook 06 — Create Optional PoC

> Phase 2 / Step 6. Create는 core strict pass 이후에만 다룬다.
> `MC 26.1.x + VulkanMod + Beryl + Cobblemon + label fix`가 먼저 성립해야 한다.

---

## 0. Entry Conditions

다음이 모두 충족될 때만 진입한다.

1. Step 01 baseline pass
2. Step 02 Cobblemon 26.1.x port pass
3. Step 03 label fix pass
4. Step 04 T2 평균 60FPS pass
5. 잔여 budget ≥ 4h

미충족이면 Create를 건드리지 않는다. core strict를 깨면서 optional을 붙이면 본말이 전도된다.

---

## 1. Availability

| 옵션 | 판단 | 비고 |
|---|---|---|
| 공식 Create Fabric | 1.20.1 라인이 안정 기준[V05] | strict 26.1에는 직접 사용 불가 |
| Create-Fly / ZurrTum fork | 1.21.x 및 26.1-pre 계열 PoC 존재[V20·V25] | 공식 26.1 stable로 보지 않는다 |
| 대체 Create 유사 모드 | 가능성만 있음 | 심화 점수 방어용, core와 분리 |

2026-05-12 API/문서 기준으로 **Create optional은 strict core pass 조건이 아니다.** 성공하면 보너스 PoC, 실패해도 P01 core 판단에는 영향이 없어야 한다.

---

## 2. Install Strategy

26.1.x에서 시도할 때:

1. Create-Fly release 중 `26.1` 또는 `26.1-pre` 표기 jar를 찾는다.
2. 요구 Porting-Lib 버전을 release note에서 확인한다.
3. 별도 instance 복사본에서만 설치한다.
4. core P01 instance는 보존한다.

예상 jar:

```text
create-fly-{ver}-26.1*.jar
porting-lib-{ver}-26.1*.jar
```

`1.21.11` jar는 strict instance에 넣지 않는다.

---

## 3. Regression Checks

| 영역 | 검사 |
|---|---|
| 부팅 | duplicate/incompatible mod 없음 |
| Cobblemon | Pokémon spawn 정상 |
| Label fix | 벽 뒤 라벨 미노출 유지 |
| Beryl | contraption 표면 아티팩트 없음 |
| FPS | T2 평균 60 유지, 최소한 -5FPS 이내 회귀 |

Create 때문에 T2가 60 아래로 떨어지면 즉시 제거한다.

---

## 4. Minimal Demo

기본 동력 전달만 확인한다.

- Shaft + Cogwheel
- Andesite Casing
- Mechanical Mixer 1대
- 같은 화면에 Pokémon 1마리 이상
- shader ON

Trains, Schematics, 대규모 contraption은 24h core 범위 밖이다.

---

## 5. Failure Handling

| 실패 | 처리 |
|---|---|
| 26.1 호환 jar를 못 찾음 | optional skipped |
| Porting-Lib mismatch | 30분만 조정 |
| Cobblemon/Beryl 회귀 | Create 제거 |
| FPS 60 미달 | Create 제거 |

보고서 문구:

```text
Create optional was evaluated separately. It was not allowed to weaken the strict 26.1 VulkanMod+Beryl+Cobblemon solution.
```

---

## Sources

- Create Fabric official: V05
- Create-Fly / ZurrTum fork: V20·V25
- Core acceptance: `07-acceptance.md`
