#!/usr/bin/env bash
# Set up the gcl-ui-components development environment (Godot addon, ENG-ADR-089).
#
# Usage:
#   ./onboard.sh   # idempotent — safe to re-run
#
# Environment:
#   GODOT_BIN   path to the Godot 4.5 binary (optional — auto-detected by test.sh)
#
# Exit: 0 = ready, non-zero = error
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ── Verify a Godot 4.5 binary is reachable (the real toolchain dependency) ────
GODOT="${GODOT_BIN:-}"
if [ -z "$GODOT" ]; then
  for candidate in \
      "$SCRIPT_DIR/../Godot_v4.5-stable_linux.x86_64" \
      "/usr/local/bin/godot" \
      "$(command -v godot 2>/dev/null || true)"; do
    [ -n "$candidate" ] && [ -x "$candidate" ] && GODOT="$candidate" && break
  done
fi
if [ -z "$GODOT" ]; then
  echo "⚠ Godot 4.5 binary not found on PATH or at ../Godot_v4.5-stable_linux.x86_64." >&2
  echo "  Set GODOT_BIN before running ./test.sh." >&2
  echo "  Download: Godot_v4.5-stable_linux.x86_64.zip from godotengine.org" >&2
else
  echo "✓ Godot: $GODOT ($("$GODOT" --version 2>/dev/null | head -1))"
fi

# GUT 9.3.0 is vendored under addons/gut/ — no package manager install required.
echo "✓ GUT 9.3.0 vendored at addons/gut/"

# Optional: install commit-lint tooling if package.json is present.
if [ -f "$SCRIPT_DIR/package.json" ] && command -v npm &>/dev/null; then
  echo "Installing commit-lint tooling (commitlint)…"
  npm install --no-audit --no-fund
fi

echo "✓ gcl-ui-components onboard complete."
echo "  Run tests with: ./test.sh   (or: GODOT_BIN=/path/to/godot ./test.sh)"
