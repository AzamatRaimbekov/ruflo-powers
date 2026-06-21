# Agent Assets

This folder is the canonical home for local agent-facing assets in this
workspace: skills, agent prompts/configuration, and rule/reference files.

## Contents

- `prompt-refiner/`: mandatory prompt clarification skill that rewrites rough
  user prompts into clear internal working requests before execution.
- `project-documentation-wiki/`: local copy of the documentation wiki skill,
  its OpenAI agent metadata, wiki init script, and LLM wiki reference.
- `superpowers/`: local Codex plugin mirror for Superpowers, including
  planning, TDD, debugging, review, and verification workflow skills.
- `frontend/`: Codex-first frontend plugin with the `frontend-agent`,
  `design-system-steward`, and `frontend-error-ux` skills, OpenAI agent
  configs, and bundled architecture/UI governance references.
- `react-19-frontend-agent/`: earlier React 19 frontend agent plugin with
  React, routing, and Next.js sub-skills.
- `frontend-design-plugin/`: local mirror of the frontend design skill and its
  project extension rules.
- `ui-ux-pro-max/`: imported UI/UX design intelligence skill with searchable
  data and scripts for accessibility, palettes, typography, product patterns,
  charts, and stack-specific UI guidance.
- `code-reviewer/`: imported code review skill with security, performance,
  correctness, and maintainability rules.
- `backend-patterns/`: imported backend architecture skill for API, database,
  caching, auth, rate limiting, jobs, logging, and server-side patterns.
- `backend/`: Codex-first backend plugin with skills for backend architecture,
  API contracts, persistence, security/auth, reliability/observability,
  performance/scaling, Go/Golang, FastAPI, Django/DRF, framework patterns, and
  backend code review.
- `code-review-graph/`: project-local test bundle for the Code Review Graph
  MCP server, Python package, hooks, tests, docs, and review skills.
- `claude-plugin-directory.config.json`: single-file catalog of the public
  Claude Plugins directory, including plugin URLs, works-with targets,
  install counts, verification status, and MCP/skill capability hints.
- `claude-plugin-directory/`: folder-based mirror with one package folder per
  public Claude plugin directory entry.

## Maintenance

- Keep skill folders, `agents/`, and `references/` together inside the same
  plugin package.
- Add new local agent plugins under this folder instead of creating new
  top-level plugin folders.
- Keep Superpowers available locally through `superpowers/` so TDD, debugging,
  planning, and verification workflows travel with the template.
- Use `tools/install-agent-assets.ps1 -TargetProject <project-path>` from the
  source `ai-tools` workspace to install this folder into another project.
- Keep `prompt-refiner` first in project startup chains when adding new agent
  bundles or templates.
- Keep `claude-plugin-directory.config.json` catalog-only: entries stay disabled
  by default, credentials stay outside the repository, and target projects
  verify each plugin after installation.
- Keep `claude-plugin-directory/plugins/` in sync with the registry. Each public
  directory entry should have a folder with manifest, plugin, MCP, and skill
  capability files as applicable.
- Keep imported standalone skills such as `ui-ux-pro-max`, `code-reviewer`,
  and `backend-patterns` bundled with their `SKILL.md`, `agents/`, scripts,
  data, and rule resources.
- Keep the backend plugin as the project-owned synthesis of SkillsMP backend
  patterns. Marketplace source notes live in `backend/references/`, while the
  skills themselves stay concise and local-rule compatible.
- Keep `code-review-graph/` as a project-local test bundle. Its `.mcp.json`
  runs `uvx code-review-graph serve`; MCP client registration and credentials
  stay outside the repository.
- Update project wiki and affected `FEATURE.md` files when this structure
  changes.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1`
  after moving or adding agent assets.
