# Runs as root inside the sandbox on first boot (Debian 13). Re-run with: sbxag setup
# Example: Bun + Supabase CLI (local stack needs Docker).

# Docker — installing it is enough; the launcher starts dockerd on every boot.
apt-get install -y --no-install-recommends docker.io docker-cli iptables

# Bun
curl -fsSL https://bun.sh/install | bash

# Supabase CLI
case "$(uname -m)" in aarch64) a=arm64 ;; *) a=amd64 ;; esac
curl -fsSL "https://github.com/supabase/cli/releases/latest/download/supabase_linux_${a}.tar.gz" \
  | tar -xz -C /usr/local/bin supabase
