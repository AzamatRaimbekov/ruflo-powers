# Installing Ruflo Powers (Claude Code "best powers")

This guide is for **anyone** who wants to drop the full agent toolkit — 84 skills,
sub-agents, slash commands, coordination hooks, the binding frontend standard,
the new-project architecture gate, and the `claude-flow` (ruflo) MCP server —
into their own project. No access to the original author's machine is needed.

---

## 1. Prerequisites

| Tool | Why | Check |
|------|-----|-------|
| **Claude Code** | The CLI that loads the skills/agents/hooks | `claude --version` |
| **Node.js ≥ 18** | Runs the `claude-flow`/ruflo MCP server + helper scripts | `node --version` |
| **git** | Clone the toolkit repo | `git --version` |
| **rsync** | Used by the installer to copy the payload | `rsync --version` |

> macOS ships `rsync`. On Linux: `sudo apt install rsync` / `sudo dnf install rsync`.
> Windows: use WSL or Git Bash.

---

## 2. Get the toolkit

Clone the repo once anywhere on your machine:

```bash
git clone https://github.com/AzamatRaimbekov/ruflo-powers.git ~/ruflo-powers
```

> No clone tooling? `npx degit AzamatRaimbekov/ruflo-powers ~/ruflo-powers` works too.

---

## 3. Install into your project

From **inside your project folder**:

```bash
cd ~/path/to/your-project
bash ~/ruflo-powers/install.sh
```

…or target a folder explicitly:

```bash
bash ~/ruflo-powers/install.sh ~/path/to/your-project
```

### What the installer copies

- `.claude/` — skills (84), agents, commands, helpers, `settings.json` (hooks)
- `.mcp.json` — registers the `claude-flow` (ruflo) MCP server
- `CLAUDE.md` / `AGENTS.md` — binding rules, frontend standard, connectivity map
- `agent-assets/` — frontend/backend bundle the skills chain into
- `frontend-agents/` — the **Template Project** starter for new apps
- `.rtk/` — RTK token-killer filter config
- `.codex/`, `.agents/`, `.gitignore`

It **never** overwrites your `CLAUDE.md`/`AGENTS.md` silently — the existing file
is saved as `*.bak` first. Runtime state and secrets (`*.db`, `.swarm/`, logs,
`.env`, `CLAUDE.local.md`, `settings.local.json`) are **excluded**.

### Flags

| Flag | Effect |
|------|--------|
| `--dry-run` | Print what would be copied; change nothing |
| `--force` | Overwrite existing files without `.bak` backups |
| `--no-mcp` | Copy files but don't register the MCP server |

---

## 4. Verify

```bash
# optional ruflo health check
npx -y ruflo@latest doctor --fix

# confirm the payload landed
ls .claude/skills | wc -l        # ~84
test -f .claude/skills/frontend-agent/references/react-senior-standard.md && echo "frontend standard ✓"
```

---

## 5. Activate

1. **Open / restart Claude Code** in the project so it loads the new `CLAUDE.md`,
   skills, agents, hooks, and MCP server.
2. When prompted, **approve the `claude-flow` MCP server**.
3. Review `CLAUDE.md` — it carries **binding** rules (the senior-React frontend
   standard, the new-project architecture gate, file-placement rules, etc.).

That's it. On your next new project, the `project-kickoff` skill runs the
architecture-approval gate before any code, and the synchronized skill chain
fires on every prompt.

---

## Updating later

Re-running the installer is **idempotent** and safe:

```bash
cd ~/ruflo-powers && git pull
cd ~/path/to/your-project && bash ~/ruflo-powers/install.sh
```

Your customized `CLAUDE.md`/`AGENTS.md` are backed up to `*.bak` on each run
(unless you pass `--force`).

---

## For the maintainer (author's machine only)

The author also has a local convenience skill, **`best-powers`**, that copies
straight from the master workspace without cloning:

```bash
bash ~/.claude/skills/best-powers/scripts/setup.sh /path/to/folder
# point at a different master on another machine:
BEST_POWERS_MASTER=/path/to/AI-TOOLS bash ~/.claude/skills/best-powers/scripts/setup.sh
```

`best-powers` and `install.sh` ship the **same payload**; `install.sh` is the
portable one to share with others.
