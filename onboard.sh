#!/usr/bin/env bash
# Set up gcl-ui-components development environment.
#
# Usage:
#   ./onboard.sh   # idempotent — safe to re-run
#
# Exit: 0 = ready, non-zero = error
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v node &>/dev/null; then
  echo "✗ node not found. Install Node.js 20 LTS." >&2
  exit 1
fi

NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
  echo "✗ Node.js 20+ required (found $(node --version))." >&2
  exit 1
fi

echo "Installing Node.js dependencies..."
npm install

echo "✓ gcl-ui-components onboard complete."
