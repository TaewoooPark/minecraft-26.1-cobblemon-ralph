# label-before-after — Screenshot Capture Plan (H8 verification)

**Status**: directory pre-created at iter#159 (2026-05-13). Image files PENDING H6/H7 Prism Launcher runtime session.

## File naming convention

```
T-H8-<test-id>.<state>.png
```

Where:
- `<test-id>` ∈ {1, 2, 3, 4, 5} (see TEST PLAN below)
- `<state>` ∈ {before, after}
  - `before` = baseline before PT151 label-fix (rollback via `git checkout PokemonRenderer.kt`)
  - `after`  = with PT151 label-fix applied (current jar)

## Required screenshots (10 total = 5 tests × 2 states)

| File | Test | State | Expected behavior |
|---|---|---|---|
| T-H8-1.before.png | open field, /pokespawn pikachu 5b away | pre-patch | label visible above Pikachu (control) |
| T-H8-1.after.png | (same setup, after patch reinstall) | post-patch | label still visible (no line-of-sight obstruction) |
| T-H8-2.before.png | behind opaque cobblestone wall, Pikachu beyond | pre-patch | label visible through wall (BUG — VulkanMod see-through) |
| T-H8-2.after.png | (same setup, after patch reinstall) | post-patch | label HIDDEN; only visible when peeking around |
| T-H8-3.before.png | through glass block, Pikachu beyond | pre-patch | label visible |
| T-H8-3.after.png | (same setup) | post-patch | label HIDDEN (COLLIDER includes glass shape — documented choice) |
| T-H8-4.before.png | first-person /pokeride on Pikachu | pre-patch | own ride label visible |
| T-H8-4.after.png | (same setup) | post-patch | own ride label STILL visible (bb.contains guard) |
| T-H8-5.before.png | 5 Pokemon spawned, all visible | pre-patch | all 5 labels visible |
| T-H8-5.after.png | (same setup) | post-patch | all 5 labels visible (matches behavior of T-H8-1) |

## Capture procedure

1. **Pre-patch baseline (before/*.png)**:
   ```bash
   cd impl/cobblemon-port
   git stash  # save current label-fix changes
   ./gradlew :fabric:build --no-daemon
   # Copy fabric/build/libs/Cobblemon-fabric-…jar to Prism cobblemon-p01-26.1/mods/
   # Boot MC, navigate to test scenario, F2 to screenshot
   # Save as T-H8-N.before.png in this directory
   git stash pop  # restore label-fix
   ```

2. **Post-patch (after/*.png)**:
   ```bash
   ./gradlew :fabric:build --no-daemon
   # Replace jar in Prism mods/
   # Boot MC, repeat exact same scenario
   # F2 screenshot → T-H8-N.after.png
   ```

3. **Save metadata**:
   - In-game F3 visible (FPS + position + facing) for reproducibility
   - Same MC seed + same time-of-day for consistent lighting

## In-game commands for setup

```
/gamemode creative
/effect give @s minecraft:night_vision 99999 0 true   # remove lighting variable
/time set day                                          # consistent time
/pokespawn pikachu                                     # T-H8-1, T-H8-2, T-H8-3
/pokespawn pikachu 5                                   # T-H8-5
/pokeride                                              # T-H8-4 (after spawn)
```

## H8 acceptance criteria (playbook/07 §1)

PASS requires:
- T-H8-1.after.png: label visible (control — patch doesn't break label rendering)
- T-H8-2.after.png: label HIDDEN behind cobblestone (primary fix verification)
- T-H8-4.after.png: own ride label visible (guard works — patch is not over-aggressive)
- T-H8-5.after.png: 5 labels visible (multi-entity correctness)

FAIL conditions:
- T-H8-2.after.png shows label still bleeding through wall → patch bypassed / wrong block class
- T-H8-1.after.png shows label disappeared → over-aggressive raycast (likely camera position bug)
- FPS regression > 5% from T-H8-5 → raycast overhead unacceptable, fallback to mixin

## Tracking back to source

Patch location:
- `common/src/main/kotlin/com/cobblemon/mod/common/client/render/pokemon/PokemonRenderer.kt:435`
  (entry-guard `if (isOccludedByOpaqueBlock(entity)) return`)
- `common/src/main/kotlin/com/cobblemon/mod/common/client/render/pokemon/PokemonRenderer.kt:487`
  (`private fun isOccludedByOpaqueBlock` helper, 21 lines)

Patch artifact: `../label-fix.patch`
Build verification: B181 :fabric:build BUILD SUCCESSFUL 25s, SHA512=c786b0f8..debca
