---
type: log
status: current
updated: 2026-06-03
sources: []
tags:
  - project-docs
  - wiki/log
---

# Template Project Wiki Log

## [2026-05-29] bootstrap | Wiki initialized

- Created initial LLM Wiki structure in `docs/wiki`.

## [2026-06-03] update | Superpowers local plugin

- Added local wiki memory for the bundled `agent-assets/superpowers/` Codex plugin mirror.
- Linked [[superpowers-local-plugin]] from the template index and overview so copied projects can discover local planning, TDD, debugging, review, verification, and delivery workflows.

## [2026-06-03] update | Claude plugin directory registry

- Added `agent-assets/claude-plugin-directory.config.json` as the single-file Claude plugin directory registry for plugin, MCP, and skill capability hints.
- Updated the template overview and index so copied projects can discover the catalog-only registry.

## [2026-06-03] update | Claude plugin directory folder mirror

- Added `agent-assets/claude-plugin-directory/plugins/` with 100 physical package folders, one per public Claude Plugins directory entry.
- Each package folder includes local metadata, template plugin manifest, and applicable plugin/MCP/skill capability files.

## [2026-06-03] ingest | Code Review Graph test plugin

- Added `agent-assets/code-review-graph/` as a local test bundle for the Code Review Graph MCP server, hooks, Python package, tests, docs, and review skills.
- The included `.mcp.json` runs `uvx code-review-graph serve`; user-specific MCP client registration and credentials stay outside the template.

## [2026-06-03] update | Backend skill pack

- Added `agent-assets/backend/` as a SkillsMP-derived backend engineering plugin with eight local skills and OpenAI agent metadata.
- Updated template instructions and local docs so copied projects can discover backend architecture, API contract, data persistence, security/auth, reliability/observability, performance/scaling, framework pattern, and backend code review guidance.

## [2026-06-03] update | Backend framework skills

- Added `backend-golang`, `backend-fastapi`, and `backend-django` to the local backend plugin.
- Updated template instructions so copied projects can discover Go/Golang, FastAPI, and Django/DRF backend development guidance.
