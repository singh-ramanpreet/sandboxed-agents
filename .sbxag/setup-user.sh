echo "=== installing Antigravity CLI (agy) ==="
curl -fsSL https://antigravity.google/cli/install.sh | bash

echo "=== installing Claude Code ==="
curl -fsSL https://claude.ai/install.sh | bash

if ! grep -q '# sbxag-agents' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOF'

# sbxag-agents
export CLAUDE_CONFIG_DIR="$HOME/.claude"
export SSH_CONNECTION="127.0.0.1 22 127.0.0.1 22"
export SSH_CLIENT="127.0.0.1 22 22"
EOF
fi
