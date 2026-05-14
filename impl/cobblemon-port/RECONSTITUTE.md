# Reconstituting the Cobblemon 26.1 Port Source Tree

The upstream source (~258 MB, 947 files) is **not** committed to this repository.
It is available at <https://gitlab.com/cable-mc/cobblemon> under MPL-2.0.

The 26.1 port is captured here in two redundant forms:

1. **Consolidated diff**: [`../artifacts/cobblemon-26.1-port.diff`](../artifacts/cobblemon-26.1-port.diff)
   — 2.5 MB unified diff against upstream commit `a3498fe03b`.
2. **Stepwise patches**: [`../patches/PT*.patch`](../patches/) — the 191 numbered
   patches in application order. Each patch is documented in
   [`../../state/impl-progress.md`](../../state/impl-progress.md) §6.

## Steps

```bash
# 1. Clone upstream at the base commit
cd impl/cobblemon-port    # this directory
git clone https://gitlab.com/cable-mc/cobblemon.git .
git checkout a3498fe03b
git checkout -b port/26.1.x

# 2a. Apply the consolidated diff (fast path)
git apply ../artifacts/cobblemon-26.1-port.diff

#   — OR —

# 2b. Apply stepwise (slower, for studying the cascade)
for p in ../patches/PT*.patch; do git apply "$p"; done

# 3. Java 25 + Gradle 9.2.1 + Loom 1.15.5 (see ../../README.md §6)
export JAVA_HOME=/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home

# 4. Build
./gradlew :fabric:build --no-daemon --console=plain

# 5. Verify
shasum -a 512 fabric/build/libs/Cobblemon-fabric-1.8.0+26.1.2-26.1.x-*.jar
# Expected for final PT191s state:
# 02d8cd271b78283cbcb54a0ee1676450c2b7adc42a163d6e1c9e133c871247ae16616f161727aa5d713fa337738f587f7dcadffc2f784cd552aefc0df8a33e28
```

## License inheritance

All ported Kotlin/Java source is **MPL-2.0**, inherited from upstream.
See <https://gitlab.com/cable-mc/cobblemon/-/blob/main/LICENSE>.
