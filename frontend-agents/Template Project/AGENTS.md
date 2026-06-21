# Codex Project Rules

<!-- BEGIN PROJECT-LOCAL-AGENT-ASSETS -->
## Project-Local Agent Assets

This project uses local agent assets from `agent-assets/`. Prefer these local skill files and bundled references before global or external instructions when working in this repository.

### Prompt Refinement

For every user prompt, read and apply `agent-assets/prompt-refiner/SKILL.md` before planning, editing files, running tools, answering, or delegating to other skills. Rewrite the user's raw message into a clear internal working request, preserve the user's scope and constraints, and only ask for clarification when a reasonable assumption would be risky or likely wrong.

### Superpowers

Use the local Superpowers Codex plugin mirror in `agent-assets/superpowers/` before relying on any globally installed Superpowers plugin. After prompt refinement and project wiki startup, read `agent-assets/superpowers/skills/using-superpowers/SKILL.md` to route applicable planning, debugging, implementation, review, and verification workflows.

- For source-code or product-behavior changes, use `agent-assets/superpowers/skills/test-driven-development/SKILL.md` before production edits.
- For defects or unclear failures, use `agent-assets/superpowers/skills/systematic-debugging/SKILL.md` before changing code.
- Before calling work complete, use `agent-assets/superpowers/skills/verification-before-completion/SKILL.md` and run the relevant checks.

### Claude Plugin Directory Registry

Use `agent-assets/claude-plugin-directory.config.json` as the single-file template registry for Claude directory plugins, MCP capability hints, and skill capability hints imported from `https://claude.com/plugins`. Use `agent-assets/claude-plugin-directory/plugins/` as the matching folder mirror, with one package folder per public directory entry. Treat both as catalog metadata only: entries are disabled by default, credentials must stay outside the repository, and every plugin must be installed and verified in the target environment before use.

### Code Review Graph Test Plugin

Use `agent-assets/code-review-graph/` as the local test bundle for the Code Review Graph MCP server, hooks, Python package, tests, docs, and review skills mirrored from `https://github.com/tirth8205/code-review-graph`. Its MCP config is `agent-assets/code-review-graph/.mcp.json` and runs `uvx code-review-graph serve`. Keep credentials and user-specific MCP client registration outside the repository; this folder is the project-local source/test bundle.

### Imported Standalone Skills

Prefer these local imported skill copies before relying on remote GitHub instructions:

- Use `agent-assets/ui-ux-pro-max/SKILL.md` for UI/UX design intelligence, visual QA, accessibility checks, product-specific palette/typography/layout choices, charts, and stack-specific UI guidance.
- Use `agent-assets/code-reviewer/SKILL.md` for code review, PR review, security audits, performance review, correctness review, and maintainability review.
- Use `agent-assets/backend-patterns/SKILL.md` for backend/API architecture, Node.js/Express/Next.js API routes, database optimization, caching, jobs, auth, rate limiting, logging, and server-side patterns.

### Backend Skill Pack

Use the local backend plugin in `agent-assets/backend/` before relying on remote marketplace instructions for backend design, implementation, or review:

- Use `agent-assets/backend/skills/backend-engineering/SKILL.md` when the task spans backend architecture, services, workers, data flows, scaling, reliability, security, performance, observability, or consistency.
- Use `agent-assets/backend/skills/backend-api-contracts/SKILL.md` for REST/OpenAPI contracts, HTTP semantics, pagination, filtering, error envelopes, webhooks, versioning, deprecation, and rate limits.
- Use `agent-assets/backend/skills/backend-data-persistence/SKILL.md` for schemas, migrations, indexes, transactions, query plans, connection pools, soft deletes, audit trails, partitioning, replication, and consistency.
- Use `agent-assets/backend/skills/backend-security-auth/SKILL.md` for authentication, authorization, sessions, JWT/OAuth/OIDC, API keys, secrets, validation, tenant isolation, and object-level permissions.
- Use `agent-assets/backend/skills/backend-reliability-observability/SKILL.md` for structured logs, metrics, tracing, health checks, SLI/SLOs, alerts, retries, timeouts, circuit breakers, idempotency, and partial-failure handling.
- Use `agent-assets/backend/skills/backend-performance-scaling/SKILL.md` for latency, throughput, p95/p99, caching, queues, backpressure, fan-out, payload size, connection pools, N+1 queries, load tests, and benchmarks.
- Use `agent-assets/backend/skills/backend-framework-patterns/SKILL.md` for FastAPI, Node.js, Express, Next.js API routes, controllers, services, middleware, validation, dependency injection, and error handling.
- Use `agent-assets/backend/skills/backend-code-review/SKILL.md` for backend code review across correctness, security, maintainability, production risk, performance, and tests.
- Use `agent-assets/backend/skills/backend-golang/SKILL.md` for Go/Golang services, REST/gRPC APIs, Gin/Echo/Fiber/Chi, GORM/sqlx/ent, goroutines, context propagation, workers, CLIs, tests, vet, lint, and pprof.
- Use `agent-assets/backend/skills/backend-fastapi/SKILL.md` for FastAPI routes, async endpoints, Pydantic v2, SQLAlchemy/SQLModel, Alembic, dependency injection, middleware, auth, OpenAPI, and pytest.
- Use `agent-assets/backend/skills/backend-django/SKILL.md` for Django/DRF models, migrations, managers, QuerySets, serializers, ViewSets, services, permissions, admin, Celery, caching, ORM optimization, tests, and security-sensitive behavior.

### Frontend Project Startup

For every frontend project task:

1. Read `agent-assets/prompt-refiner/SKILL.md` and refine the user's raw request into a concrete internal working prompt.
2. Read `agent-assets/project-documentation-wiki/SKILL.md`, run `python agent-assets/project-documentation-wiki/scripts/init_project_wiki.py --project .`, then read `docs/wiki/index.md`, `docs/wiki/schema.md`, recent `docs/wiki/log.md`, and relevant `FEATURE.md` files.
2.5. NEW PROJECT GATE — if this is a new project/app/service/epic/major feature, the folder is empty/near-empty, or it is the first substantive request here: read `agent-assets/superpowers/skills/project-kickoff/SKILL.md` and run it BEFORE anything else. It activates superpowers, refines intent, brainstorms, designs the architecture (Mermaid diagrams + ADR), and requires **explicit user approval of the architecture before any implementation code, scaffolding, or dependency install**. Do not write code until the user approves.
3. Read `agent-assets/superpowers/skills/using-superpowers/SKILL.md` and the specific Superpowers workflow skill that applies to the task.
4. Read `agent-assets/frontend/skills/frontend-agent/SKILL.md` as the main frontend router skill.
5. Immediately read `agent-assets/frontend/skills/frontend-error-ux/SKILL.md` and run its startup audit for the 404 page, error modal, and offline screen-blocking overlay, plus crash fallback. The project must show a no-internet state when connectivity is lost.
6. For design-system, token, palette, theme, component, screen, or mobile UI governance work, read `agent-assets/frontend/skills/design-system-steward/SKILL.md` and create or update the project `design.md`.
7. For React work, read `agent-assets/react-19-frontend-agent/skills/react-19-frontend-agent/SKILL.md` and its required sub-skills when routing, React patterns, or Next.js behavior is involved.
8. For UI or visual work, read `agent-assets/frontend-design-plugin/skills/frontend-design/SKILL.md`, `agent-assets/frontend-design-plugin/skills/frontend-design/PROJECT_EXTENSION.md`, and `agent-assets/ui-ux-pro-max/SKILL.md`.
9. Reuse project-local references from each skill's `references/` folder before adding new architecture, UI, or documentation rules.

### Test-First Development

Before changing source code or product behavior, use `agent-assets/superpowers/skills/test-driven-development/SKILL.md`, write or update the smallest failing automated test first, run it to confirm the expected failure, implement the change, rerun the targeted test, then run the relevant broader checks.

### Documentation And UI Memory

- Keep `docs/wiki/` current for project architecture, workflows, decisions, sources, concepts, and feature behavior.
- Keep `docs/frontend/` current for design-system values, detailed `design.md` rules, components, screens, and UI decisions.
- Add or update nearby `FEATURE.md` files for durable feature, module, route, UI, API, or workflow changes.

### Bundled Skills And Agents

- `agent-assets/prompt-refiner/SKILL.md`
- `agent-assets/project-documentation-wiki/SKILL.md`
- `agent-assets/superpowers/skills/using-superpowers/SKILL.md`
- `agent-assets/superpowers/skills/brainstorming/SKILL.md`
- `agent-assets/superpowers/skills/writing-plans/SKILL.md`
- `agent-assets/superpowers/skills/executing-plans/SKILL.md`
- `agent-assets/superpowers/skills/dispatching-parallel-agents/SKILL.md`
- `agent-assets/superpowers/skills/subagent-driven-development/SKILL.md`
- `agent-assets/superpowers/skills/test-driven-development/SKILL.md`
- `agent-assets/superpowers/skills/systematic-debugging/SKILL.md`
- `agent-assets/superpowers/skills/requesting-code-review/SKILL.md`
- `agent-assets/superpowers/skills/receiving-code-review/SKILL.md`
- `agent-assets/superpowers/skills/verification-before-completion/SKILL.md`
- `agent-assets/superpowers/skills/finishing-a-development-branch/SKILL.md`
- `agent-assets/superpowers/skills/using-git-worktrees/SKILL.md`
- `agent-assets/superpowers/skills/writing-skills/SKILL.md`
- `agent-assets/frontend/skills/frontend-agent/SKILL.md`
- `agent-assets/frontend/skills/design-system-steward/SKILL.md`
- `agent-assets/frontend/skills/frontend-error-ux/SKILL.md`
- `agent-assets/frontend-design-plugin/skills/frontend-design/SKILL.md`
- `agent-assets/ui-ux-pro-max/SKILL.md`
- `agent-assets/code-reviewer/SKILL.md`
- `agent-assets/backend-patterns/SKILL.md`
- `agent-assets/backend/skills/backend-engineering/SKILL.md`
- `agent-assets/backend/skills/backend-api-contracts/SKILL.md`
- `agent-assets/backend/skills/backend-data-persistence/SKILL.md`
- `agent-assets/backend/skills/backend-security-auth/SKILL.md`
- `agent-assets/backend/skills/backend-reliability-observability/SKILL.md`
- `agent-assets/backend/skills/backend-performance-scaling/SKILL.md`
- `agent-assets/backend/skills/backend-framework-patterns/SKILL.md`
- `agent-assets/backend/skills/backend-code-review/SKILL.md`
- `agent-assets/backend/skills/backend-golang/SKILL.md`
- `agent-assets/backend/skills/backend-fastapi/SKILL.md`
- `agent-assets/backend/skills/backend-django/SKILL.md`
- `agent-assets/code-review-graph/skills/build-graph/SKILL.md`
- `agent-assets/code-review-graph/skills/debug-issue/SKILL.md`
- `agent-assets/code-review-graph/skills/explore-codebase/SKILL.md`
- `agent-assets/code-review-graph/skills/refactor-safely/SKILL.md`
- `agent-assets/code-review-graph/skills/review-changes/SKILL.md`
- `agent-assets/code-review-graph/skills/review-delta/SKILL.md`
- `agent-assets/code-review-graph/skills/review-pr/SKILL.md`
- `agent-assets/react-19-frontend-agent/skills/react-19-frontend-agent/SKILL.md`
- `agent-assets/react-19-frontend-agent/skills/react-19-patterns/SKILL.md`
- `agent-assets/react-19-frontend-agent/skills/typescript-react-routing/SKILL.md`
- `agent-assets/react-19-frontend-agent/skills/nextjs-app-router-practices/SKILL.md`
<!-- END PROJECT-LOCAL-AGENT-ASSETS -->

<!-- BEGIN RUFLO-CODEX -->
## Ruflo Multi-Agent Runtime (Codex)

This project ships the Ruflo harness for Codex too: `.agents/` holds the Codex config (`config.toml`) and 100+ skills (invoke with `$skill-name`), and `AGENTS.md` is the Codex entry point.

- On a freshly copied project, initialize the runtime first: `bash .claude/skills/ruflo-bootstrap/assets/init-ruflo.sh` (builds memory, swarm, daemon).
- Prefer the local `.agents/skills/` skills before remote instructions.
- For MCP in Codex, run `codex mcp add` after installing the Codex CLI; the Claude Code side uses `.mcp.json` (`claude-flow` server).
- Codex executes; Ruflo coordinates and learns. Keep `.codex/` local overrides out of version control.
<!-- END RUFLO-CODEX -->
