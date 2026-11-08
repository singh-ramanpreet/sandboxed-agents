echo "=== installing Antigravity CLI (agy) ==="
curl -fsSL https://antigravity.google/cli/install.sh | bash

echo "=== installing Claude Code ==="
curl -fsSL https://claude.ai/install.sh | bash

if ! grep -q '# sbxag-agents' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOF'

# sbxag-agents
export CLAUDE_CONFIG_DIR="$HOME/.claude"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export SSH_CONNECTION="127.0.0.1 22 127.0.0.1 22"
export SSH_CLIENT="127.0.0.1 22 22"

[ -d "$XDG_RUNTIME_DIR" ] || sudo install -d -m 700 -o "$(id -u)" -g "$(id -g)" "$XDG_RUNTIME_DIR"

_sbx_names() { dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply \
                 / org.freedesktop.DBus.ListNames 2>/dev/null; }
if ! _sbx_names >/dev/null; then
  rm -f "$XDG_RUNTIME_DIR/bus"
  dbus-daemon --session --address="$DBUS_SESSION_BUS_ADDRESS" --fork --nopidfile
fi
if ! _sbx_names | grep -q org.freedesktop.secrets; then
  mkdir -p -m 700 "$HOME/.local/share/keyrings"
  _pw="$HOME/.local/share/keyrings/.sbxag-password"
  [ -s "$_pw" ] || { (umask 077; openssl rand -hex 16 > "$_pw"); }
  gnome-keyring-daemon --daemonize --unlock --components=secrets < "$_pw" >/dev/null
fi
unset -f _sbx_names; unset _pw
EOF
fi
