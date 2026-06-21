# Template Project

This folder is a ready-to-copy **AI-project standard** starter. It works in both
**Claude Code** and **Codex** out of the box: local skills, role subagents,
project rules, an every-prompt synchronization hook, wiki memory, and frontend
governance docs.

## Use

Copy this folder to a new project location and open the copy.

- **Claude Code** reads `CLAUDE.md`, auto-discovers the 45 skills in
  `.claude/skills/`, the 6 subagents in `.claude/agents/`, and runs the
  synchronized chain on **every prompt** via the `.claude/hooks/inject-chain.sh`
  hook registered in `.claude/settings.json`. Nothing to install — just open the
  folder. (Trust the folder's local settings when prompted.)
- **Codex** reads `AGENTS.md` and routes work through the same skills in
  `agent-assets/`.

`.claude/skills/` mirrors the canonical skills in `agent-assets/` so both agents
share one standard. When you change a skill, update both copies (or re-mirror
`agent-assets/*/SKILL.md` into `.claude/skills/`).

## Ruflo multi-agent harness (bundled)

This template also ships the **Ruflo** harness (claude-flow v3): 89+ agents, 160+
commands, ruflo skills, the `claude-flow` MCP server (`.mcp.json`), coordination
hooks, and Codex assets in `.agents/`. The static assets travel with the folder;
the **runtime** (memory DB, swarm, daemon) is machine-specific and is built on
first use.

**Activation is automatic.** On first open of a copied project, the `SessionStart`
hook detects the missing runtime and runs the `ruflo-bootstrap` skill **in the
background** — building the memory DB, the swarm (hierarchical-mesh), and the daemon
(~1-3 min, logged to `.claude-flow-bootstrap.log`). Requires Node 18+ and network
(downloads `ruflo@latest`). Reopen Claude Code once afterward and approve the
`claude-flow` MCP server so MCP/hooks go fully live.

Opt out with `RUFLO_NO_AUTOBOOTSTRAP=1` and run it yourself when ready:

```bash
bash .claude/skills/ruflo-bootstrap/assets/init-ruflo.sh
```

Runtime state (`.claude-flow/`, `.claude/memory.db`, `.codex/`) is gitignored so a
fresh copy always rebuilds clean.

## Synchronized chain (every prompt)

`prompt-refiner` → `project-documentation-wiki` → `using-superpowers` (→ TDD /
debugging / planning) → domain skills (frontend or backend) →
`verification-before-completion` → docs/wiki + FEATURE.md update. See `CLAUDE.md`
for the full contract.

## Included

- `CLAUDE.md`: Claude Code operating rules and the every-prompt chain.
- `.claude/skills/`: 45 skills auto-discovered by Claude Code (Skill tool).
- `.claude/agents/`: 6 role subagents (frontend, backend, review, debug, plan, docs).
- `.claude/hooks/inject-chain.sh` + `.claude/settings.json`: per-prompt chain injector.
- `AGENTS.md`: Codex-readable project rules and skill startup chain.
- `AgentMD.md`: human-readable mirror of the same skill chain.
- `agent-assets/`: canonical local skills, agents, references, and plugin packages.
- `agent-assets/claude-plugin-directory.config.json`: single-file catalog of
  Claude directory plugins, MCP capability hints, and skill capability hints.
- `agent-assets/claude-plugin-directory/plugins/`: physical package folders for
  every public Claude plugin directory entry.
- `agent-assets/superpowers/`: local Codex Superpowers plugin mirror for
  planning, TDD, debugging, review, and verification workflows.
- `agent-assets/ui-ux-pro-max/`, `agent-assets/code-reviewer/`, and
  `agent-assets/backend-patterns/`: imported standalone skills for UI/UX
  design intelligence, code review, and backend/API architecture patterns.
- `agent-assets/backend/`: local backend engineering skill pack synthesized
  from SkillsMP backend sources, including Go/Golang, FastAPI, and Django/DRF.
- `agent-assets/code-review-graph/`: local test bundle for the Code Review
  Graph MCP server, hooks, Python package, tests, docs, and review skills.
- `docs/wiki/`: project wiki scaffold.
- `docs/frontend/`: frontend design-system, component, screen, decision, and
  audit memory.

## Verify

From the source `ai-tools` workspace:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```
