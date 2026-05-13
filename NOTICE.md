# NOTICE — Third-party attributions & modification log

This repository contains an **unofficial port** of the Cobblemon mod to Minecraft 26.1.2.
It is not affiliated with, endorsed by, or sponsored by **Cable MC**, **The Pokémon Company**, **Game Freak**, or **Nintendo**.

---

## 1. Upstream — Cobblemon

- **Project**: Cobblemon
- **Authors**: The Cobblemon Team
- **Homepage**: <https://cobblemon.com/>
- **Source**: <https://gitlab.com/cable-mc/cobblemon>
- **License**: **Mozilla Public License 2.0** (<https://gitlab.com/cable-mc/cobblemon/-/blob/main/LICENSE>)
- **Base commit ported from**: `a3498fe03b` (Cobblemon `main` branch snapshot, May 2026)

The compiled jar distributed via this repository's GitHub Releases
(`Cobblemon-fabric-1.8.0+26.1.2-PT191s-h10-textures.jar`)
is a **derivative work** of upstream Cobblemon and remains licensed under **MPL-2.0**.
The full upstream LICENSE text is preserved inside the jar at `/LICENSE`.

---

## 2. Modifications (MPL-2.0 §3.2)

This port modifies upstream Cobblemon to make it compile and run against:

- Minecraft **26.1.2** (upstream targets Minecraft 1.21.1)
- Fabric Loader **0.19.2**
- Java **25** (upstream targets Java 21)
- Gradle **9.2.1** + Fabric-Loom **1.15.5** (upstream uses Architectury Loom 1.11 + Gradle 8.x)

**Source disclosure** — every modification is captured in:

| File | Description | Size |
|---|---|---|
| [`impl/artifacts/cobblemon-26.1-port.diff`](./impl/artifacts/cobblemon-26.1-port.diff) | Consolidated unified diff vs upstream `a3498fe03b` — **all 26.1 port changes** | 2.5 MB · 947 files · +7,473 / −10,931 |
| [`impl/artifacts/label-fix.patch`](./impl/artifacts/label-fix.patch) | Nameplate wall-occlusion fix (PT151 + PT185) — separable standalone patch | 7.9 KB |
| [`impl/patches/PT001-PT008.patch`](./impl/patches/) | Build-system bring-up patches (gradle / loom / kotlin / mappings) | 9 files |
| [`impl/cobblemon-port/RECONSTITUTE.md`](./impl/cobblemon-port/RECONSTITUTE.md) | How to reconstitute the full source tree from upstream + diff | reproducibility recipe |
| [`state/impl-progress.md`](./state/impl-progress.md) §6 | Iteration-by-iteration log of every PT### patch (191 total) | full audit trail |
| [`impl/artifacts/report.md`](./impl/artifacts/report.md) | Final report — port scope, build evidence, FPS measurements | audit summary |

To inspect what was changed, run:
```bash
diffstat impl/artifacts/cobblemon-26.1-port.diff
# or
less impl/artifacts/cobblemon-26.1-port.diff.stat
```

---

## 3. Pokémon intellectual property

Pokémon names, designs, sprites, sounds, and game mechanics referenced in Cobblemon assets
(under `assets/cobblemon/` inside the jar) are intellectual property of
**The Pokémon Company**, **Game Freak**, **Creatures Inc.**, and **Nintendo**.

These assets are bundled by upstream Cobblemon and inherited unchanged into this port.
This repository does **not** alter, redistribute, or claim ownership of any Pokémon IP.
Each Pokémon model file in the jar (`assets/cobblemon/bedrock/pokemon/models/<id>_<name>/license`)
carries its own per-asset attribution from the upstream Cobblemon team.

If you are a rights-holder representative and wish content removed,
please open an issue at <https://github.com/TaewoooPark/minecraft-26.1-cobblemon-ralph/issues>.

---

## 4. Other third-party components (this port's runtime dependencies)

These mods are **not** redistributed by this project; users install them directly from their official sources.
Listed here as full attribution for the runtime stack.

| Component | License | Source |
|---|---|---|
| Fabric Loader | Apache-2.0 | <https://fabricmc.net/> |
| Fabric API | Apache-2.0 | <https://github.com/FabricMC/fabric> |
| Fabric Language Kotlin | Apache-2.0 | <https://github.com/FabricMC/fabric-language-kotlin> |
| VulkanMod | LGPL-3.0 | <https://github.com/xCollateral/VulkanMod> |
| Beryl (shader bridge) | (see project) | VulkanMod releases & Modrinth |
| Minecraft 26.1.2 | Mojang Studios EULA | <https://www.minecraft.net/eula> |

---

## 5. Tooling attribution

- **Claude Code** — Anthropic — autonomous coding agent — <https://claude.com/claude-code>
- **Ralph autonomous iteration pattern** — described by Geoffrey Huntley — <https://ghuntley.com/ralph/>

The build automation, patch authoring, and iteration log in `state/` were produced by
Claude Code running an autonomous self-referential loop (Phase 3, 218 iterations).
Human authorship: prompt design, completion criteria, license review, and final acceptance.

---

## 6. License of original work in this repository

Files in this repository **outside** of `impl/cobblemon-port/` (which contains the ported Cobblemon source)
— specifically the Ralph loop methodology, the state ledger, the playbooks, the run manual,
and this NOTICE — are licensed under **MIT** (see [LICENSE](./LICENSE)).

Files **inside** `impl/cobblemon-port/` (after reconstitution per `RECONSTITUTE.md`)
and the compiled jar distributed via GitHub Releases remain under **MPL-2.0**,
inherited from upstream Cobblemon.

---

*Last updated: 2026-05-13 · port commit ref: `26.1.x-a3498fe` · jar SHA512: `02d8cd27...8a33e28`*
