# sandboxed-agents

`sbxag`: one [microsandbox](https://github.com/superradcompany/microsandbox) microVM per project, with AI coding agents (Antigravity CLI, Claude Code) inside.

```sh
curl -fsSL https://raw.githubusercontent.com/singh-ramanpreet/sandboxed-agents/main/install.sh | bash
```

```sh
cd my-project
sbxag claude      # or: sbxag agy, sbxag (shell)
```

- **One VM per project.** The dev environment (Docker, databases, toolchains) is built once and shared by every agent. The project is mounted at `/workspace/<dir>`, named after the project directory.
- **Runs as you.** Shells and agents run as a user with your host name and uid/gid (passwordless `sudo`), not root, so tools that refuse root work, e.g. `claude --dangerously-skip-permissions`.
- **Shared logins.** Agent logins live in shared volumes. Sign in once per agent, and every project uses it.
- **Per-project setup.** Optional `.sbxag/setup.sh` installs the toolchain as root, `.sbxag/setup-user.sh` then runs as you (dotfiles, `$HOME` toolchains, project deps), and `.sbxag/ports` lists ports to forward. See [example/](example/.sbxag/).
- **Ports.** Forwarded to localhost by default; `sbxag --host` binds them to `0.0.0.0` so other machines can reach them, like vite. Ports are fixed when the sandbox is created, so after changing `.sbxag/ports` or `--host`, run `sbxag destroy` and start again.

Run `sbxag -h` for all commands. Requires `msb`; on Linux your user needs `/dev/kvm` access (`sudo usermod -aG kvm $USER`).
