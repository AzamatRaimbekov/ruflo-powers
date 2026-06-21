# Template Project

## Purpose

`Template Project/` is a ready-to-copy frontend project starter. It contains
project-local skills, agent metadata, Codex rules, wiki scaffolding, and
frontend governance docs so a copied project starts through the same agent chain
every time.

## Entry Points

- `AGENTS.md`: Codex-readable rules and managed project-local skill chain.
- `AgentMD.md`: human-readable mirror of the skill chain.
- `README.md`: short usage guide.
- `agent-assets/`: bundled skills, agents, plugin metadata, references, and
  scripts.
- `agent-assets/claude-plugin-directory.config.json`: single-file Claude
  plugin directory registry with plugin, MCP, and skill capability hints.
- `agent-assets/claude-plugin-directory/plugins/`: folder-based mirror with one
  package folder for every public Claude plugin entry.
- `agent-assets/superpowers/`: local Codex Superpowers plugin mirror with
  planning, TDD, debugging, review, and verification skills.
- `agent-assets/ui-ux-pro-max/`: imported UI/UX design intelligence skill with
  searchable data and scripts.
- `agent-assets/code-reviewer/`: imported code review skill and rule set.
- `agent-assets/backend-patterns/`: imported backend architecture skill.
- `agent-assets/backend/`: SkillsMP-derived backend engineering plugin with
  architecture, API contract, data persistence, security/auth,
  reliability/observability, performance/scaling, Go/Golang, FastAPI,
  Django/DRF, framework pattern, and backend code review skills.
- `agent-assets/code-review-graph/`: local test bundle for the Code Review
  Graph MCP server, hooks, Python package, tests, docs, and review skills.
- `docs/wiki/`: project documentation wiki scaffold.
- `docs/frontend/`: frontend UI governance memory.

## Behavior

- Codex should read `AGENTS.md` first when this folder is used as a project.
- Project work starts with `agent-assets/prompt-refiner/SKILL.md`, then
  `agent-assets/project-documentation-wiki/SKILL.md`.
- Superpowers workflows are available locally from
  `agent-assets/superpowers/skills/` before falling back to a global Codex
  plugin install.
- Claude directory plugin metadata is configured in one file at
  `agent-assets/claude-plugin-directory.config.json`. It is catalog-only,
  disabled by default, and does not store credentials.
- Claude directory plugin folders are installed under
  `agent-assets/claude-plugin-directory/plugins/`. They provide manifests and
  capability hints, but target projects still install and authenticate real
  plugins in their own environment.
- Frontend work routes through `agent-assets/frontend/skills/frontend-agent/SKILL.md`.
- Design-system work routes through
  `agent-assets/frontend/skills/design-system-steward/SKILL.md` and keeps the
  project `design.md` current.
- Frontend initialization includes `agent-assets/frontend/skills/frontend-error-ux/SKILL.md`.
- React, routing, and Next.js work use the React 19 agent sub-skills.
- UI work uses the frontend-design skill and project extension.
- UI/UX deep checks can use `agent-assets/ui-ux-pro-max/SKILL.md` alongside
  frontend-design.
- Code review work can use `agent-assets/code-reviewer/SKILL.md`.
- Backend/API work can use `agent-assets/backend-patterns/SKILL.md`.
- Backend design, implementation, and review can use the specialized
  `agent-assets/backend/skills/` pack before falling back to remote marketplace
  instructions.
- Review-graph workflow tests can use
  `agent-assets/code-review-graph/skills/review-pr/SKILL.md`,
  `agent-assets/code-review-graph/skills/review-changes/SKILL.md`, and
  `agent-assets/code-review-graph/skills/review-delta/SKILL.md`; the MCP
  config runs `uvx code-review-graph serve`.

## Dependencies

- Source bundle: `../agent-assets/`.
- Installer: `../tools/install-agent-assets.ps1`.
- Template verification: `../tools/test-template-project.ps1`.

## Verification

Run from the source `ai-tools` workspace:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```

## Test Case Checklist

- Happy path: template contains `AGENTS.md`, `AgentMD.md`, `agent-assets/`,
  `docs/wiki/`, and `docs/frontend/`.
- Skill coverage: template contains at least 42 bundled `SKILL.md` files, including
  all 14 Superpowers skills.
- Agent coverage: template contains at least 34 bundled `openai.yaml` files.
- Claude plugin directory: template includes the single-file registry and its
  AGENTS/AgentMD instructions mention it.
- Claude plugin folders: template includes package folders for every public
  directory entry.
- Code Review Graph: template includes `agent-assets/code-review-graph/` with
  local manifests, `.mcp.json`, hooks, source, tests, docs, and review skills.
- Backend plugin: template includes `agent-assets/backend/` with eleven backend
  skills and OpenAI agent metadata.
- Startup rules: `AGENTS.md` and `AgentMD.md` list every bundled skill path.
- Regression: generated installer output still matches template expectations.

## Wiki Links

- `../docs/wiki/workflows/frontend-project-bootstrap.md`
- `../docs/wiki/workflows/agent-assets-consolidation.md`
- `../docs/wiki/decisions/prompt-refinement-required.md`

## Open Questions

- When copied into a real product repository, product-specific package files,
  tests, routes, and source folders should be added by that project's first
  implementation task.
