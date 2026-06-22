---
name: best-powers
description: One-shot bootstrap that gives any folder the full Ruflo / Claude Code "best powers" — copies the master CLAUDE.md + AGENTS.md (with the binding frontend standard and skill/plugin/agent connectivity map), all 84 skills, agents, commands, helpers, settings, the agent-assets frontend bundle, the frontend-agents Template Project starter, .rtk token-killer filters, .codex config, and registers the claude-flow MCP server, then runs ruflo doctor. Use when the user wants to initialize, set up, or power-up a new/empty folder with the complete agent + swarm + skills + frontend configuration.
---

# best-powers

Bootstraps the current working folder with the **complete** Ruflo + Claude Code
setup, cloned from the master template at `/Users/raimbekov/Desktop/AI-TOOLS`
(override with the `BEST_POWERS_MASTER` env var when running on another machine).

> For **other users** (no access to this machine's master path), use the portable
> distribution instead: `git clone` the AI-TOOLS repo and run its root
> `install.sh`. See `INSTALL.md` in the repo. This skill is the local convenience
> wrapper; `install.sh` is the shareable installer with the same payload.

## What it installs into the target folder

- `CLAUDE.md` + `AGENTS.md` — agent comms, swarm, routing, memory rules, the
  **binding frontend standard**, and the **skill/plugin/agent connectivity map**
- `.mcp.json` — the `claude-flow` (ruflo v3) MCP server config
- `.codex` — Codex config + AGENTS override (keeps Claude Code and Codex in sync)
- `.claude/agents` — all custom agent definitions (23 groups)
- `.claude/commands` — all slash commands
- `.claude/helpers` — helper scripts
- `.claude/skills` — the **full 84-skill library**: frontend (`frontend-agent` +
  `ui-ux-pro-max`, `react-19-*`, `nextjs-app-router-practices`, …), backend
  (`backend-*` suite), swarm/sparc, github, agentdb, review, workflow skills, and
  the `project-kickoff` new-project architecture-approval gate
- `.claude/settings.json` — hooks + settings
- `.agents` + `.gitignore`
- `.rtk/` — RTK (Rust Token Killer) filter config for token-optimized commands
- `agent-assets/` — frontend bundle (ui-ux-pro-max, design-system-steward,
  project-documentation-wiki, react-19, frontend-design) the `frontend-agent`
  skill chains into, including the binding
  `frontend-agent/references/react-senior-standard.md` law file
- `frontend-agents/` — the standard **Template Project** starter (its own wired
  `.claude/`, `agent-assets/`, per-prompt chain hook) to copy when spinning up a
  new app
- Registers the `claude-flow` MCP server in the **target's** scope (`claude mcp add`)
- Ensures the official **`superpowers`** plugin is installed (user scope, global,
  idempotent) — `claude plugin install superpowers@claude-plugins-official`
- Runs `npx ruflo@latest doctor --fix`, then prints a summary (skill/agent counts,
  frontend-standard check)

## How to run

Run the setup script from the folder you want to power up (defaults to `$PWD`):

```bash
bash ~/.claude/skills/best-powers/scripts/setup.sh
```

Target a specific folder, or skip the slow/online steps:

```bash
bash ~/.claude/skills/best-powers/scripts/setup.sh /path/to/folder
bash ~/.claude/skills/best-powers/scripts/setup.sh --no-doctor      # config only, fast
bash ~/.claude/skills/best-powers/scripts/setup.sh --no-mcp --force # no MCP add, silent overwrite
```

Flags: `--no-mcp` (skip MCP registration; `.mcp.json` still copied), `--no-doctor`
(skip the ruflo health check), `--force` (overwrite existing CLAUDE.md/AGENTS.md
without the warning note).

## After running

Tell the user to **restart Claude Code in that folder** so it loads the new
`CLAUDE.md`, skills, agents, and MCP server. The script is idempotent and safe to
re-run; it refuses to run against the master template itself. Any new skill,
agent, or rule added to the master workspace automatically ships to future
folders — `best-powers` is the propagation mechanism for the whole setup.
