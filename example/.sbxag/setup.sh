# Runs as root inside the sandbox on first boot (Debian 13). Re-run with: sbxag setup
# Install tools system-wide (e.g. /usr/local): shells run as your user, not root.
# Example: base tools, keyring for agy, Docker, Bun, and Supabase CLI.

apt-get update
apt-get install -y --no-install-recommends \
  curl git unzip procps openssl \
  dbus dbus-x11 gnome-keyring \
  docker.io docker-cli iptables

# Helper to start dockerd (called now and from ~/.bashrc after `sbxag stop` -> `sbxag`).
cat > /usr/local/bin/start-docker <<EOF
#!/usr/bin/env bash
set -e
if ! docker info >/dev/null 2>&1; then
  rm -f /var/run/docker.pid /var/run/docker.sock /var/run/docker/containerd/containerd.pid
  setsid -f dockerd --group "\$(getent group "$SBX_GID" | cut -d: -f1)" \
    >/var/log/dockerd.log 2>&1 </dev/null
  timeout 180 sh -c "until docker info >/dev/null 2>&1; do sleep 1; done" \
    || { tail -50 /var/log/dockerd.log; docker info; exit 1; }
fi
EOF
chmod 0755 /usr/local/bin/start-docker
/usr/local/bin/start-docker

# Bun
curl -fsSL https://bun.sh/install | BUN_INSTALL=/usr/local bash

# Supabase CLI
case "$(uname -m)" in aarch64) a=arm64 ;; *) a=amd64 ;; esac
curl -fsSL "https://github.com/supabase/cli/releases/latest/download/supabase_linux_${a}.tar.gz" \
  | tar -xz -C /usr/local/bin supabase
