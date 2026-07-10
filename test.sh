#!/usr/bin/env bash
# Run the gcl-ui-components GDScript test suite via GUT 9.3.0 (headless).
#
# Usage:
#   ./test.sh                          # run all GUT unit tests headless
#   GODOT_BIN=/path/to/godot ./test.sh # explicit Godot 4.5 binary
#   ./test.sh --help
#
# Environment:
#   GODOT_BIN   path to the Godot 4.5 binary (optional — auto-detected)
#
# Exit: 0 = all tests passed, non-zero = failure
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

for arg in "$@"; do
  case "$arg" in
    --help|-h)
      sed -n '2,12p' "$0" | sed 's/^# \?//'
      exit 0 ;;
  esac
done

# ── Locate the Godot 4.5 binary ──────────────────────────────────────────────
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
  echo "✗ Godot 4.5 binary not found." >&2
  echo "  Set GODOT_BIN or run ./onboard.sh for setup instructions." >&2
  echo "  Download: Godot_v4.5-stable_linux.x86_64.zip from godotengine.org" >&2
  exit 1
fi

echo "=== gcl-ui-components GDScript tests (GUT 9.3.0) ==="
echo "Using Godot: $GODOT"

mkdir -p test-results

# gut_runner.gd is a headless SceneTree entry point (NO [editor_plugins]).
# Test discovery is scoped to the addon's tests/ directory.
set +e
"$GODOT" --headless \
  -s addons/gcl_ui_components/tests/gut_runner.gd \
  -gdir=res://addons/gcl_ui_components/tests \
  -gprefix=test_ \
  -gsuffix=.gd \
  -gexit \
  -glog=1 \
  -gjunit_xml_file="$SCRIPT_DIR/test-results/junit.xml" \
  "$@"
EXIT_CODE=$?
set -e

echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "✓ All tests passed."
else
  echo "✗ One or more tests failed." >&2
fi
exit "$EXIT_CODE"
