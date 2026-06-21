# Ruflo Powers — Claude Code toolkit

A drop-in **Claude Code** configuration that turns any project folder into a
fully-loaded agent workspace: **83 skills**, specialized sub-agents, slash
commands, coordination hooks, a binding frontend standard, and the
`claude-flow` (ruflo) MCP server for swarm / memory / routing.

## What's inside

| Path | What it is |
|------|-----------|
| `.claude/skills/` | 83 skills (frontend, backend, review, swarm, docs, …) |
| `.claude/agents/` | Specialized sub-agent definitions |
| `.claude/commands/` | Slash commands |
| `.claude/helpers/` | Hooks, statusline, routing, auto-memory |
| `.claude/settings.json` | Hook + behavior wiring |
| `.mcp.json` | Registers the `claude-flow` (ruflo) MCP server |
| `CLAUDE.md` / `AGENTS.md` | Rules + skill/agent connectivity map |
| `agent-assets/` | Frontend/backend bundle used by skills |
| `.codex/`, `.agents/` | Codex + agent configs |

> Runtime state (`*.db`, `.swarm/`, `.claude-flow/data`, logs) and local
> secrets (`.env`, `CLAUDE.local.md`) are **not** shipped — they regenerate
> per machine.

## Install

```bash
# 1. Clone this repo somewhere once
git clone https://github.com/<you>/ruflo-powers.git ~/ruflo-powers

# 2. From inside YOUR project, run the installer
cd ~/path/to/your-project
bash ~/ruflo-powers/install.sh
```

Or install into a target directory directly:

```bash
bash ~/ruflo-powers/install.sh ~/path/to/your-project
```

### Flags

| Flag | Effect |
|------|--------|
| `--dry-run` | Show what would be copied; change nothing |
| `--force` | Overwrite existing files without `.bak` backups |
| `--no-mcp` | Don't register the MCP server (just copy files) |

The installer:
- copies the toolkit payload into the target (excluding runtime/secret files),
- backs up any existing `CLAUDE.md` / `AGENTS.md` to `*.bak`,
- makes hooks/helpers executable,
- registers the `claude-flow` MCP server (if the `claude` CLI is available).

## After installing

```bash
npx -y ruflo@latest doctor --fix   # optional health check
```

Then open the project in Claude Code. Review `CLAUDE.md` — it carries binding
rules (e.g. the senior-React frontend standard).

## Quick install (no clone)

```bash
npx degit <you>/ruflo-powers /tmp/ruflo-powers && bash /tmp/ruflo-powers/install.sh
```
