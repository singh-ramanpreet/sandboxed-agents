# sandboxed-agents

`sbxag`: one [microsandbox](https://github.com/superradcompany/microsandbox) microVM per project, with AI coding agents (Antigravity CLI, Claude Code) inside.

```sh
curl -fsSL https://raw.githubusercontent.com/singh-ramanpreet/sandboxed-agents/main/install.sh | bash
```

```sh
cd my-project
sbxag claude      # or: sbxag agy, sbxag (shell)
```

- **One VM per project.** The dev environment (Docker, databases, toolchains) is built once and shared by every agent. The project is mounted at `/workspace`.
- **Shared logins.** Agent logins live in shared volumes. Sign in once per agent, and every project uses it.
- **Per-project setup.** Optional `.sbxag/setup.sh` installs the toolchain, and `.sbxag/ports` lists ports to forward. See [example/](example/.sbxag/).

Run `sbxag -h` for all commands. Requires `msb`; on Linux your user needs `/dev/kvm` access (`sudo usermod -aG kvm $USER`).
