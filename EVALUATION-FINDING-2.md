# External Evaluation — Finding 2

> Companion document for the 2026-05-14 external evaluation summarized at the top of [`README.md`](README.md#-external-evaluation-2026-05-14). Finding 1 is reproduced in full in the README; Finding 2's detail lives here.

## Finding 2 — Cobblemon UX coverage shortfall (genuine, unresolved)

This one is a real shortfall, not a packaging issue.

- **Symptom**: The shipped jar boots, lets you `/pokespawn` species with correct textures at 118 FPS, and demonstrates the wall-occlusion label fix. But the **full Cobblemon game loop** — entering a battle through the client UI, triggering an evolution, gaining an advancement, observing a wild encounter via natural spawn, fabric-api-event-driven hooks — **does not work** in this build. The 16 H-checkpoints intentionally scoped acceptance to {boot, spawn, render, label, FPS, packaging, audit}, and the loop saturated against that scope without ever reopening it.
- **Cause** (in the loop, not in the code): the Ralph promise gate fired correctly under the rules as written. The defect is in the rules. Specifically:
  - PT149/PT150 mass-stubbed mixins and fabric-api event hooks because no 26.1.x upstream existed at solve time. R14 ("don't repeat the same hypothesis") then prevented re-attempt, and the stubs became permanent.
  - PT156 stripped `data/{cobblemon,minecraft}/...` to bypass a 26.1.x BlockBehaviour `<clinit>` NPE. This nuked advancements and loot tables silently. No checkpoint flagged the loss.
  - H11 audit annotated battle wiring as "deferred to Phase 4," but `.ralph/CLAUDE.md` never defined Phase 4. The deferred work had no return-trigger, so the loop never came back to it.
- **Verdict**: The strict premise (`MC 26.1 + Fabric + VulkanMod + Beryl + Cobblemon-boots + Pokémon-renders + label-fix + ≥60 FPS`) was met. **Cobblemon's full UX was not.** This is acknowledged here rather than buried.

## How to fix the Ralph methodology so a future loop reaches the full UX

| # | Problem in current `.ralph/` | Proposed change |
|---|---|---|
| **A** | C1–C15 conflated "MC 26.1 platform PASS" with "Cobblemon UX PASS." A narrowly-scoped H-list saturated, so the promise gate fired even though battle/evolution/advancement were untouched. | Split acceptance into **two independent tiers**. Tier-1 Platform = current H0–H15. Tier-2 UX = battle entered through client UI + result screen, ≥1 advancement triggered, ≥1 wild spawn observed, ≥1 evolution chain progressed. Promise gate requires `Tier1 == PASS AND Tier2 == PASS`, never one alone. |
| **B** | PT149/PT150 mass-stubs were applied with no debt-tracking. R14 then locked in those stubs as permanent. | Add **R19 (stub-debt ledger)**: every `Mixin.stub()` or `Stub.noOp()` writes to `state/stub-debt.md` with a reason and an owner-PT for re-implementation. Promise gate fails if any debt item is older than N iterations without a re-attempt or an explicit "deferred-to-Phase-N" annotation that points to a real, scheduled phase. |
| **C** | PT156 datastrip silently nuked first-party `cobblemon/` and `minecraft/` data; no checkpoint registered the loss of advancements/loot/recipes. | Add **R20 (first-party data integrity)**: any patch that removes files under `cobblemon/`, `minecraft/`, or any namespace listed in `playbook/00-manifest.md` as primary requires a paired `state/data-loss.md` entry and a recovery-PT scheduled within the next 10 iterations, or the promise gate fails. |
| **D** | "Deferred to Phase 4" in H11 audit was free text. Phase 4 was never defined; the loop never returned. | Add **R21 (deferred-work scheduling)**: any `deferred-to-Phase-N` annotation must register N in `state/phases.md` with explicit checkpoints and a return-trigger condition. Promise gate enumerates pending phases and refuses to fire while any are open. |
| **E** | The single-prompt loop hard-coded `H→B→M→PT→F→A→P→G`. There was no slot for "audit whether the H-list still covers the premise." | Add **U (Update-scope)** as a new priority slot, fired during the R16-mandated 5-iteration self-audit: "given the current premise, does the H-list cover all user-observable acceptance scenarios? If not, append H_x and reset promise eligibility." |
| **F** | The loop greedily completed cheap platform layers (boot → spawn → render) and never pulled toward expensive user-facing layers (battle UI, evolution flow). | Add a **cost-weighted priority** in `ralph-rule.md`: when picking the next H to advance, prefer items closer to the *user-observable* end of the pipeline (battle > spawn > boot) once boot/spawn baselines exist. Otherwise the loop greedy-completes infrastructure and never reaches gameplay. |

A loop with these six rule additions would have either (i) explicitly declared full Cobblemon UX out-of-scope and stopped claiming the challenge solved, or (ii) spent ~30–50 more iterations restoring the data-strip, un-stubbing the event hooks for a battle path, and exercising one full battle before firing the promise.
