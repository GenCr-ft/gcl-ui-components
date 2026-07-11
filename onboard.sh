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

# ── Populate GUT 9.3.0 from the vendor/gut submodule ─────────────────────────
# GUT is pinned as a git submodule at vendor/gut (v9.3.0, same commit as
# gcp-aethel-client) and copied into addons/gut. addons/gut is .gitignored —
# it is regenerated here, never committed.
if [ ! -d "$SCRIPT_DIR/vendor/gut/addons/gut" ]; then
  echo "Initialising GUT submodule (vendor/gut)…"
  git submodule update --init vendor/gut
fi
if [ ! -d "$SCRIPT_DIR/addons/gut" ]; then
  echo "Copying GUT 9.3.0 from vendor/gut into addons/gut…"
  mkdir -p "$SCRIPT_DIR/addons"
  cp -r "$SCRIPT_DIR/vendor/gut/addons/gut" "$SCRIPT_DIR/addons/gut"
fi
# Godot 4.5 compat: rename GUT's `Logger` static var (shadows the native 4.5
# Logger class) → `GutLogger`. Idempotent — skipped if already applied.
if ! grep -q "static var GutLogger" "$SCRIPT_DIR/addons/gut/utils.gd"; then
  echo "Applying GUT→Godot 4.5 Logger-shadow compat patch…"
  patch -p1 -d "$SCRIPT_DIR" < "$SCRIPT_DIR/scripts/gut-godot45-logger-shadow.patch"
fi
echo "✓ GUT 9.3.0 installed at addons/gut/ (from vendor/gut submodule, Godot 4.5 patched)"

# ── Import assets once (headless) so GUT class resolution is populated ────────
# A SINGLE clean import is required; running --import twice can corrupt GUT
# class resolution (workspace MEMORY.md). test.sh deliberately does NOT import.
# The font/theme resources emit non-fatal "ERROR:" lines during first import —
# these are expected and do not fail onboarding.
if [ -n "$GODOT" ]; then
  echo "Importing project assets once (expect non-fatal font-import ERROR lines)…"
  "$GODOT" --headless --import --path "$SCRIPT_DIR" >/dev/null 2>&1 || true
fi

# Optional: install commit-lint tooling if package.json is present.
if [ -f "$SCRIPT_DIR/package.json" ] && command -v npm &>/dev/null; then
  echo "Installing commit-lint tooling (commitlint)…"
  npm install --no-audit --no-fund
fi

echo "✓ gcl-ui-components onboard complete."
echo "  Run tests with: ./test.sh   (or: GODOT_BIN=/path/to/godot ./test.sh)"
