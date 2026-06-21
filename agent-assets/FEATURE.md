# Agent Assets

## Purpose

`agent-assets/` is the canonical folder for local agent-facing packages in this
workspace. It keeps skills, agent configs, and rule/reference resources together
instead of spreading plugin folders across the repository root.

## Entry Points

- `README.md`: short maintainer guide for the consolidated folder.
- `prompt-refiner/`: mandatory prompt clarification skill and OpenAI agent
  metadata.
- `project-documentation-wiki/`: documentation wiki skill, OpenAI agent
  metadata, wiki init script, and LLM wiki reference.
- `superpowers/`: local Codex plugin mirror with planning, TDD, debugging,
  code review, verification, and delivery workflow skills.
- `claude-plugin-directory.config.json`: single-file catalog of Claude
  directory plugins from `https://claude.com/plugins`, including plugin URLs,
  works-with targets, install counts, verification status, and MCP/skill
  capability hints.
- `claude-plugin-directory/`: generated folder mirror with one package folder
  for each Claude plugin directory entry.
- `ui-ux-pro-max/`: imported UI/UX design intelligence skill with searchable
  data/scripts for accessibility, palettes, typography, product patterns,
  chart guidance, and stack-specific UI rules.
- `code-reviewer/`: imported code review skill with security, performance,
  correctness, maintainability, and testing review rules.
- `backend-patterns/`: imported backend architecture skill for API design,
  database optimization, caching, auth, rate limiting, jobs, logging, and
  server-side patterns.
- `backend/`: local backend engineering plugin synthesized from SkillsMP
  backend candidates, with skills for architecture, API contracts, data
  persistence, security/auth, reliability/observability, performance/scaling,
  Go/Golang, FastAPI, Django/DRF, framework patterns, and backend code review.
- `code-review-graph/`: project-local test bundle for the Code Review Graph
  MCP server, Python package, hooks, tests, docs, and review skills.
- `frontend/`: Codex-first frontend plugin with `frontend-agent`,
  `design-system-steward`, and `frontend-error-ux` skills.
- `react-19-frontend-agent/`: earlier React 19 frontend agent plugin and
  supporting sub-skills.
- `frontend-design-plugin/`: local mirror of the frontend design skill and
  project extension rules.
- `../tools/install-agent-assets.ps1`: installer that copies this bundle into
  another project and creates project-local startup rules.
- `../tools/verify-agent-assets.ps1`: structure verification script.

## Behavior

- New local agent plugins should be added under `agent-assets/`.
- `prompt-refiner` should stay first in root and project-local startup rules so
  raw user prompts are clarified before planning, tool use, or downstream skill
  routing.
- Superpowers should stay available under `agent-assets/superpowers/` so
  projects can use local planning, TDD, debugging, review, and verification
  workflows before falling back to a global Codex plugin install.
- The frontend plugin should keep `design-system-steward` available so target
  projects can create and maintain detailed `design.md` design-system docs for
  web and mobile UI.
- `claude-plugin-directory.config.json` should remain the one-file template
  registry for imported Claude directory plugins. Treat it as catalog metadata:
  entries are disabled by default, credentials are never stored in the file, and
  target projects must install and verify plugins in their own environment.
- `claude-plugin-directory/plugins/` should contain a physical package folder
  for every registry entry. Package folders are disabled-by-default metadata
  mirrors, not authenticated live installs.
- Imported standalone skills such as `ui-ux-pro-max`, `code-reviewer`, and
  `backend-patterns` should remain local source-of-truth copies with their
  `SKILL.md`, `agents/`, scripts, data, and rule resources bundled together.
- The backend plugin should remain the local source-of-truth synthesis for
  SkillsMP-derived backend patterns. Use `backend/references/skillsmp-sources.md`
  for source provenance and `backend/references/backend-quality-checklist.md`
  for cross-cutting backend checks.
- `code-review-graph/` should remain a local test bundle with source code,
  tests, hooks, `.mcp.json`, and review skills bundled together. Its MCP
  command is `uvx code-review-graph serve`; client registration and credentials
  stay outside the repository.
- New frontend projects should receive this folder through
  `../tools/install-agent-assets.ps1 -TargetProject <project-path>` so skills,
  agents, wiki startup, and frontend docs are created inside that project.
- The bundled frontend project startup includes `frontend-error-ux`, which must
  immediately audit the initialized app for a 404 page, blocking error
  modal/dialog, and offline screen blocker that tells the user there is no
  internet connection.
- Skill folders should keep their `SKILL.md`, `agents/`, and `references/`
  together inside the owning plugin package.
- Root-level project rules remain in `../AGENTS.md` so Codex can still discover
  them automatically.
- Project wiki pages and affected local `FEATURE.md` files should be updated
  whenever agent assets move or new packages are added.

## Dependencies

- `../AGENTS.md` for project-wide operating rules.
- `../docs/wiki/` for central project memory.
- `../docs/frontend/` for frontend UI governance memory used by the packaged
  frontend skills.

## Verification

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-install-agent-assets.ps1
```

Expected result:

- `agent-assets/` exists.
- The `frontend`, `react-19-frontend-agent`, and `frontend-design-plugin`
  packages are under `agent-assets/`.
- The `prompt-refiner` skill is under `agent-assets/` and installed globally to
  `C:\Users\User\.codex\skills\prompt-refiner`.
- The `project-documentation-wiki` skill is under `agent-assets/`.
- The Superpowers Codex plugin mirror is under `agent-assets/superpowers/` with
  its `.codex-plugin/plugin.json`, workflow skills, and OpenAI agent metadata.
- The Claude plugin directory registry exists at
  `agent-assets/claude-plugin-directory.config.json`, points to
  `https://claude.com/plugins`, declares plugin/MCP/skill capability types, and
  contains at least 80 directory entries.
- The Claude plugin directory folder mirror exists at
  `agent-assets/claude-plugin-directory/plugins/` and contains package folders
  for every registry entry.
- Imported skills exist at `agent-assets/ui-ux-pro-max/`,
  `agent-assets/code-reviewer/`, and `agent-assets/backend-patterns/`, with
  OpenAI agent metadata and their bundled resources.
- The backend plugin exists at `agent-assets/backend/` with Codex and Claude
  manifests, eleven backend skills, OpenAI agent metadata, and source/checklist
  references.
- The Code Review Graph test plugin exists at
  `agent-assets/code-review-graph/`, includes `.mcp.json`, hooks, Python
  package files, local wrapper manifests, and all seven review-graph skills.
- Root-level `frontend`, `react-19-frontend-agent`, and
  `frontend-design-plugin` folders are absent.
- At least 42 skill files, 34 agent config files, and 20 reference/rule files are
  found under `agent-assets/`.

## Test Case Checklist

- Happy path: consolidated folder contains every expected local plugin package.
- Prompt refinement: root rules, installer output, template output, and global
  Codex skill install include `prompt-refiner` as the first startup step.
- Superpowers: consolidated folder includes the local Superpowers Codex plugin
  mirror, all 14 Superpowers skills, and their `openai.yaml` files.
- Imported skills: UI/UX Pro Max, Code Reviewer, and Backend Patterns are
  present, validate as Codex skills, and are copied by project bootstrap.
- Backend plugin: all eleven SkillsMP-derived backend skills are present,
  validate as Codex skills, and are copied by project bootstrap.
- Code Review Graph: the local test bundle contains `.mcp.json`,
  `.codex-plugin/plugin.json`, `.claude-plugin/plugin.json`, hooks, source,
  tests, docs, and seven review-graph skills, and is copied by bootstrap.
- Claude plugin directory: the single registry file contains public Claude
  plugin catalog metadata with plugin/MCP/skill capability hints and no secrets.
- Claude plugin folders: every registry entry has a physical package folder
  with manifest, README, template plugin manifest, and applicable capability
  files.
- Bootstrap: installer creates project-local `agent-assets/`, `AGENTS.md`,
  `docs/wiki/`, and `docs/frontend/` in a new target project.
- Error UX bootstrap: installer includes the `frontend-error-ux` skill and
  managed startup rule for 404, error modal, and offline blocker checks.
- Regression: old root plugin folders are not recreated after consolidation.
- Validation: plugin manifests remain parseable JSON and include names.
- Coverage: skills, agent configs, and reference/rule files are counted by the
  verification script.
- Documentation: wiki, root rules, frontend design docs, and local feature docs
  point at `agent-assets/` paths.
- Template: `Template Project/` includes Superpowers and lists its local skill
  paths in both `AGENTS.md` and `AgentMD.md`.

## Wiki Links

- `../docs/wiki/workflows/agent-assets-consolidation.md`
- `../docs/wiki/sources/claude-plugin-directory.md`
- `../docs/wiki/sources/code-review-graph-plugin.md`
- `claude-plugin-directory/FEATURE.md`
- `../docs/wiki/workflows/frontend-agent-plugin.md`
- `../docs/wiki/decisions/prompt-refinement-required.md`

## Open Questions

- Whether these local packages should later be installed into a personal or
  shared plugin marketplace remains separate from this folder consolidation.
