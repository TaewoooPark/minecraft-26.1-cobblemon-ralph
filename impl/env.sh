# Phase 3 standard environment — source this before any Java/gradle command.
# Origin: iter#69 H0 PASS. iter#71 PT003: JDK 21 → 25 (F001 — MC 26.1.2 requires Java 25 per Loom 1.11.458).

export JAVA_HOME="/opt/homebrew/opt/openjdk@25"
export PATH="${JAVA_HOME}/bin:/opt/homebrew/bin:${PATH}"

# Sanity:
#   java -version   → openjdk 25.0.2 ARM64
#   prismlauncher --version → PrismLauncher 11.0.2
#   ffmpeg -version | head -1 → ffmpeg 8.0.1
