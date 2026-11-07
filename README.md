# sandboxed-agents

`sbxag`: one [microsandbox](https://github.com/superradcompany/microsandbox) microVM per project.

```sh
curl -fsSL https://raw.githubusercontent.com/singh-ramanpreet/sandboxed-agents/main/install.sh | bash
```

```sh
cd my-project
sbxag
```

- **One VM per project.** The dev environment (Docker, databases, toolchains, coding agents) is built once per project. The project is mounted at `/workspace/<dir>`, named after the project directory.
- **Runs as you.** Shells run as a user with your host name and uid/gid (passwordless `sudo`), not root, so tools that refuse root work, e.g. `claude --dangerously-skip-permissions`.
- **Per-project setup.** Optional `.sbxag/config.yml` configures resources, ports, and shared named volumes; `.sbxag/setup.sh` runs as root on first boot (system packages, Docker, toolchains); and `.sbxag/setup-user.sh` runs as you (coding agents like Claude Code / Antigravity CLI, dotfiles, `$HOME` toolchains, project deps). See [example/](example/.sbxag/).
- **Ports & volumes.** Configured in `.sbxag/config.yml` under `ports:` (bound to `127.0.0.1` by default, or prefix an IP like `0.0.0.0:3000` to expose on your network) and `volumes:` (shared named volumes, e.g. for agent logins and settings across projects). Fixed when the sandbox is created: after editing `.sbxag/config.yml`, run `sbxag destroy` and start again.

Run `sbxag -h` for all commands. Requires `msb`; on Linux your user needs `/dev/kvm` access (`sudo usermod -aG kvm $USER`).
