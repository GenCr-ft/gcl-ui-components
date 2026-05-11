#!/usr/bin/env bash
# Run the gcl-ui-components test suite.
#
# Usage:
#   ./test.sh          # run unit tests (none yet — stub)
#   ./test.sh --help
#
# Exit: 0 = all tests passed, non-zero = failure
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

for arg in "$@"; do
  case "$arg" in
    --help|-h)
      sed -n '2,7p' "$0" | sed 's/^# \?//'
      exit 0 ;;
  esac
done

if ! command -v npm &>/dev/null; then
  echo "✗ npm not found. Install Node.js 20 LTS." >&2
  exit 1
fi

if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
  echo "✗ node_modules missing. Run ./onboard.sh first." >&2
  exit 1
fi

echo "=== gcl-ui-components tests ==="
echo "  (no tests yet — stub library, Phase 5+ work)"
echo ""
echo "✓ All tests passed (0 tests)."
exit 0
