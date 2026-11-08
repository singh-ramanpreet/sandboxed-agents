# Runs as your user (not root) inside the sandbox on first boot, right after setup.sh, from the
# project directory. Re-run with: sbxag setup
# For things that belong in $HOME: coding agents, dotfiles, per-user toolchains, project deps.

echo "=== installing Antigravity CLI (agy) ==="
curl -fsSL https://antigravity.google/cli/install.sh | bash

echo "=== installing Claude Code ==="
curl -fsSL https://claude.ai/install.sh | bash

# Configure shell environment for Docker, Claude Code, and Antigravity CLI.
if ! grep -q '# sbxag-agents' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOF'

# sbxag-agents
export CLAUDE_CONFIG_DIR="$HOME/.claude"
export SSH_CONNECTION="127.0.0.1 22 127.0.0.1 22"
export SSH_CLIENT="127.0.0.1 22 22"

command -v start-docker >/dev/null 2>&1 && sudo /usr/local/bin/start-docker
EOF
fi

git config --global init.defaultBranch main

# Project dependencies (Bun comes from setup.sh)
if [ -f package.json ]; then
  bun install
fi
