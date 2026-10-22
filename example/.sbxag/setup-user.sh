# Runs as your user (not root) inside the sandbox on first boot, right after setup.sh, from the
# project directory. Re-run with: sbxag setup
# For things that belong in $HOME: dotfiles, per-user toolchains (rustup, nvm, uv), project deps.

git config --global init.defaultBranch main

# Project dependencies (Bun comes from setup.sh)
if [ -f package.json ]; then
  bun install
fi
