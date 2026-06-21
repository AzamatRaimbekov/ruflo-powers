# Codex Project Rules

## Prompt Refinement

For every user prompt in this workspace:

- Use the `prompt-refiner` skill before planning, editing files, running tools, answering, or delegating to other skills.
- Treat the user's raw prompt as intent that should be clarified into a concrete internal working request while preserving the user's scope, language, constraints, and urgency.
- Do not ask the user to approve the refined prompt for routine tasks; act on the refined request unless a risky or likely-wrong assumption would be required.
- This refinement happens after Codex receives the message; do not claim it can technically intercept text before the model sees it.

## Project Documentation Wiki

For every project task in this workspace:

- Use the `project-documentation-wiki` skill at the start of the task.
- If `docs/wiki/` does not exist, let the skill create the wiki scaffold before relying on project memory.
- If `docs/wiki/` exists, read `docs/wiki/index.md`, `docs/wiki/schema.md`, recent `docs/wiki/log.md`, and relevant local `FEATURE.md` files before planning or editing.
- When a prompt changes project behavior, architecture, setup, APIs, UI flows, data models, config, tests, or feature files, update the central wiki and affected local feature docs before calling the work complete.
- For feature folders such as `app/feature/CreateProduct/CreateProduct.tsx`, keep a nearby `FEATURE.md` with the feature's purpose, behavior, dependencies, UX notes, verification, wiki links, and open questions.
- If Jira or Confluence MCP tools are connected, use them as live sources for relevant tickets/pages and summarize them under `docs/wiki/sources/jira/` or `docs/wiki/sources/confluence/`.

## Project-Local Agent Bootstrap

When starting or onboarding a frontend project from this workspace:

- Run `powershell -NoProfile -ExecutionPolicy Bypass -File tools\install-agent-assets.ps1 -TargetProject <project-path>` from this repository.
- The installer must create the target project's local `agent-assets/`, `AGENTS.md`, `docs/wiki/`, and `docs/frontend/` starter memory.
- After installation, work inside the target project through its local skill files first, especially `agent-assets/prompt-refiner/SKILL.md`, `agent-assets/project-documentation-wiki/SKILL.md`, `agent-assets/frontend/skills/frontend-agent/SKILL.md`, `agent-assets/frontend/skills/design-system-steward/SKILL.md`, and `agent-assets/frontend/skills/frontend-error-ux/SKILL.md`.
- During frontend project initialization, run the local `frontend-error-ux` startup audit immediately and verify the project has a 404 page, a blocking error modal/dialog pattern, a crash fallback, and an offline screen-blocking overlay that says there is no internet connection when connectivity is lost.
- Keep new local skills, agents, and rule/reference files inside the target project's `agent-assets/` folder rather than relying only on global Codex or Claude skill folders.
- Re-run the installer to refresh a project-local copy after changing this repository's bundled agent assets.

## Imported Skill Bundle

For work that matches these domains, prefer the local imported skill copies before relying on remote GitHub instructions:

- Use `agent-assets/ui-ux-pro-max/SKILL.md` for UI/UX design intelligence, visual QA, accessibility checks, product-specific palette/typography/layout choices, charts, and stack-specific UI guidance.
- Use `agent-assets/code-reviewer/SKILL.md` for code review, PR review, security audits, performance review, correctness review, and maintainability review.
- Use `agent-assets/backend-patterns/SKILL.md` for backend/API architecture, Node.js/Express/Next.js API routes, database optimization, caching, jobs, auth, rate limiting, logging, and server-side patterns.

## Backend Skill Pack

For backend design, implementation, and review, prefer the local backend plugin before relying on remote marketplace instructions:

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

## Local Code Review Graph Plugin

For Code Review Graph testing and review-graph workflows:

- Use `agent-assets/code-review-graph/` as the project-local test bundle mirrored from `https://github.com/tirth8205/code-review-graph`.
- Its MCP config is `agent-assets/code-review-graph/.mcp.json` and runs `uvx code-review-graph serve`.
- Use its local skills from `agent-assets/code-review-graph/skills/`, especially `agent-assets/code-review-graph/skills/review-pr/SKILL.md`, `agent-assets/code-review-graph/skills/review-changes/SKILL.md`, and `agent-assets/code-review-graph/skills/review-delta/SKILL.md`, when testing review workflows.
- Keep credentials and user-specific MCP client registration outside this repository.

## Local Superpowers Plugin

For planning, implementation, debugging, review, and verification workflows:

- Prefer the local Superpowers Codex plugin mirror at `agent-assets/superpowers/` before relying on a globally installed plugin.
- After prompt refinement and project wiki startup, read `agent-assets/superpowers/skills/using-superpowers/SKILL.md` to route applicable Superpowers workflows.
- For source-code or product-behavior changes, use `agent-assets/superpowers/skills/test-driven-development/SKILL.md` before production edits.
- For defects or unclear failures, use `agent-assets/superpowers/skills/systematic-debugging/SKILL.md` before changing code.
- Before calling work complete, use `agent-assets/superpowers/skills/verification-before-completion/SKILL.md` and run the relevant checks.

## Test-First Development

For every new task that changes source code or product behavior:

- After the required project wiki startup check, use the local `agent-assets/superpowers/skills/test-driven-development/SKILL.md` skill before editing production code.
- The first implementation artifact must be tests: write or update failing tests and explicit test cases before writing the code that makes them pass.
- Cover the change with full automated tests, E2E tests for the affected user/API flow, and a concrete test case checklist for happy paths, edge cases, validation/errors, permissions/security when relevant, and regressions.
- For frontend changes, write tests in JavaScript or TypeScript using the project's existing JS test stack when one exists.
- For backend changes, write tests in Python using the project's existing Python test stack when one exists.
- Run the new targeted tests before implementation and confirm they fail for the expected reason. Then write the minimal production code, rerun the targeted tests, and finish with the relevant broader suite.
- If the repository has no suitable test harness, add the smallest appropriate harness first. If adding a harness is not safe or possible, document the blocker and ask the user before changing production code.
- Keep the durable test case checklist in the nearest relevant `FEATURE.md`, `TESTCASES.md`, or wiki workflow/decision page when the task changes feature behavior.

## Frontend Design

For any task that creates, edits, redesigns, reviews, or visually verifies frontend UI, pages, components, layouts, CSS, animations, dashboards, landing pages, tools, or browser apps:

- Use the `frontend-design` skill before implementing UI work.
- Treat the local mirror at `agent-assets/frontend-design-plugin/skills/frontend-design/SKILL.md` as the project copy of the official Anthropic frontend-design skill.
- Also apply the local UI governance extension at `agent-assets/frontend-design-plugin/skills/frontend-design/PROJECT_EXTENSION.md`.
- Use `agent-assets/ui-ux-pro-max/SKILL.md` alongside `frontend-design` when the task involves UX quality, accessibility, interaction states, responsive behavior, charts, product-type design choices, or stack-specific UI guidance.
- If there is any doubt whether a task is frontend-related, assume it is and apply the frontend-design workflow.
- Treat frontend output as production UI, not a generic scaffold.
- Before coding, pick a clear visual direction that fits the product, audience, and workflow.
- Use distinctive typography, intentional color, polished spacing, responsive layout, and meaningful motion where appropriate.
- Avoid generic AI-looking UI, predictable purple gradients, default system-font-only layouts, and cookie-cutter cards.
- Prefer real UI implementation over landing-page filler unless the user explicitly asks for a landing page.
- After frontend implementation, run the local dev server when the project supports it and inspect the result in the browser.
- Verify desktop and mobile layouts when practical.
- Fix obvious visual issues, overflow, clipped text, broken spacing, and console errors before calling the work complete.
- For design-system, token, palette, theme, component, screen, or mobile UI governance work, use `agent-assets/frontend/skills/design-system-steward/SKILL.md` and keep the project's `design.md` current.

When the user says "front", "frontend", "UI", "interface", "page", "site", "app", "dashboard", "landing", "component", or asks to run/check the frontend, assume these rules apply.

## Frontend UI Governance

For every frontend task, maintain `docs/frontend/` as the project UI memory:

- Read `docs/frontend/README.md`, `docs/frontend/design-system.md`, `docs/frontend/components.md`, and `docs/frontend/screens.md` before making UI changes when practical.
- Read `docs/frontend/design.md` when it exists, and create or update it through `design-system-steward` when design-system rules, palette intent, or mobile UI governance change.
- Reuse documented components, colors, typography, spacing, shadows, radii, motion, and breakpoints before adding new ones.
- Do not introduce new reusable UI components without updating `docs/frontend/components.md`.
- Do not introduce new colors, fonts, spacing scales, radii, shadows, motion patterns, or breakpoints without updating `docs/frontend/design-system.md`.
- Do not introduce or significantly change screens, routes, or major layouts without updating `docs/frontend/screens.md`.
- Record meaningful UI and design-system decisions in `docs/frontend/ui-decisions.md`.
- Use `docs/frontend/audit-checklist.md` before calling frontend work complete.

The agent should actively control and regulate UI consistency. If implementation and documentation disagree, update the docs or fix the implementation in the same task.

## Local Frontend Skill Mirror

The official Anthropic frontend-design plugin is mirrored into this repository at:

- `agent-assets/frontend-design-plugin/.claude-plugin/plugin.json`
- `agent-assets/frontend-design-plugin/README.md`
- `agent-assets/frontend-design-plugin/LICENSE`
- `agent-assets/frontend-design-plugin/skills/frontend-design/SKILL.md`
- `agent-assets/frontend-design-plugin/skills/frontend-design/PROJECT_EXTENSION.md`

When working in this repository, Codex should use the installed `frontend-design` skill from the active skill registry and cross-check the local mirror if the exact frontend-design rules need to be inspected.
