# antigravity

Run [Antigravity CLI](https://antigravity.google/docs/cli/overview/) (`agy`) for a project inside a microsandbox microVM. The project is mounted at `/workspace`; everything else stays in the VM.

## Install

```sh
cp agy-sandbox ~/.local/bin/ && chmod +x ~/.local/bin/agy-sandbox
```

Requires [microsandbox](https://github.com/superradcompany/microsandbox) (`msb`). On Linux your user needs access to `/dev/kvm` (`sudo usermod -aG kvm $USER`, then log in again).

## Use

From a project root:

```sh
agy-sandbox           # create/start the sandbox and open agy
agy-sandbox shell     # shell instead
agy-sandbox setup     # re-run .agy-sandbox/setup.sh
agy-sandbox destroy   # remove the sandbox
```

First launch prints a sign-in URL: open it, sign in with Google, paste the code back. The login stays in the VM.

## Per-project config (optional)

```
<project>/.agy-sandbox/
  setup.sh   # runs as root in the VM on first boot; install the toolchain here
  ports      # one port per line, forwarded to localhost
```

If `setup.sh` installs Docker, it's started on every boot. See [example/](example/.agy-sandbox/) for Bun + Supabase.

Resources: `CPUS=3 MAX_CPUS=4 MEMORY=4G MAX_MEMORY=8G DISK=30G` (override per run).
