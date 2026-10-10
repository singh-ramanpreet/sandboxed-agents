#!/usr/bin/env bash
# Install sbxag:
#   curl -fsSL https://raw.githubusercontent.com/singh-ramanpreet/sandboxed-agents/main/install.sh | bash
#
# Options (env): BIN_DIR=~/.local/bin  REF=main
set -euo pipefail

REF="${REF:-main}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
URL="https://raw.githubusercontent.com/singh-ramanpreet/sandboxed-agents/${REF}/sbxag"

mkdir -p "$BIN_DIR"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

curl -fsSL "$URL" -o "$tmp"
head -n1 "$tmp" | grep -q '^#!/usr/bin/env bash' || { echo "Download doesn't look like sbxag: $URL" >&2; exit 1; }
install -m 0755 "$tmp" "$BIN_DIR/sbxag"

echo "Installed sbxag to $BIN_DIR/sbxag"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "Add it to your PATH:  export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
command -v msb >/dev/null 2>&1 || echo "Note: microsandbox (msb) not found. Install it: curl -fsSL https://install.microsandbox.dev | sh"
