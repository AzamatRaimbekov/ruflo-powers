# SkillsMP Backend Source Notes

This backend pack is a project-local synthesis, not a verbatim copy of marketplace skills. Use these sources as provenance and for deeper inspection when a task needs more detail.

## Selection Criteria

- Backend relevance over raw repository popularity.
- Concrete triggers and actionable checklists.
- Broad production value across Node, Python, and service backends.
- Avoid repo-only skills unless they contain transferable rules.
- Prefer sources that cover tradeoffs, validation, testing, observability, security, and performance evidence.

## Primary Sources

| Source | Useful Patterns | URL |
| --- | --- | --- |
| SkillsMP Backend category | Marketplace category and ranking context for backend skills. | https://skillsmp.com/categories/backend |
| SkillsMP search API | Candidate discovery by backend, API, database, observability, security, performance, FastAPI, and Node queries. | https://skillsmp.com/api/v1/skills/search?q=backend&limit=10&sortBy=stars |
| affaan-m backend-patterns | Existing imported Node/Express/Next API, repository, service, caching, auth, jobs, logging patterns. | https://skillsmp.com/skills/affaan-m-ecc-agents-skills-backend-patterns-skill-md |
| AbsolutelySkilled backend-engineering | Production backend tradeoffs across schema, scaling, observability, performance, security, API design, failure handling. | https://github.com/AbsolutelySkilled/AbsolutelySkilled/tree/main/skills/backend-engineering |
| AbsolutelySkilled database-engineering | Schema design, indexes, EXPLAIN, migrations, pooling, partitioning, replication, locking. | https://github.com/AbsolutelySkilled/AbsolutelySkilled/tree/main/skills/database-engineering |
| 1Mangesh1 api-design | REST resource naming, HTTP semantics, status codes, pagination, errors, OpenAPI, versioning. | https://github.com/1Mangesh1/dev-skills-collection/tree/main/skills/api-design |
| curiositech logging-observability | Structured logs, correlation IDs, OpenTelemetry, metrics, SLI/SLO alerting, anti-patterns. | https://github.com/curiositech/some_claude_skills/tree/main/.claude/skills/logging-observability |
| cohen-liel fastapi-backend | FastAPI routing, Pydantic validation, dependencies, service layer, response models. | https://github.com/cohen-liel/hivemind/tree/main/.claude/skills/fastapi-backend |
| cohen-liel nodejs-express | Express middleware, async handlers, Zod validation, config validation, error handling. | https://github.com/cohen-liel/hivemind/tree/main/.claude/skills/nodejs-express |
| Langflow backend-code-review | Backend review scope and checklist shape for security, maintainability, performance, and tests. | https://skillsmp.com/skills/langflow-ai-langflow-agents-skills-backend-code-review-skill-md |
| MadAppGang golang | Go backend service triggers for goroutines, channels, idiomatic errors, tests, APIs, and CLI tools. | https://skillsmp.com/skills/madappgang-claude-code-plugins-dev-skills-backend-golang-skill-md |
| mujez golang-backend | Go services, APIs, microservices, CLI, concurrency, testing, database patterns, gRPC, REST, and error handling. | https://skillsmp.com/skills/mujez-claude-skills-skills-golang-backend-skill-md |
| Mindrally fastapi-python | FastAPI/Python best practices for typed APIs, async operations, Pydantic, dependency injection, error handling, and performance. | https://skillsmp.com/skills/mindrally-skills-fastapi-python-skill-md |
| majiayu000 fastapi-python-expert | FastAPI design, endpoint creation, database integration, auth, deployment strategy, architecture, and optimization. | https://skillsmp.com/skills/majiayu000-claude-skill-registry-skills-data-fastapi-python-expert-skill-md |
| Vinta django-expert | Django models, views, serializers, APIs, ORM, migrations, performance, auth, tests, and DRF best practices. | https://skillsmp.com/skills/vintasoftware-django-ai-plugins-plugins-django-expert-skills-skill-md |
| Fujigo django-skills | Django/DRF sub-skill map covering database, security, API, error handling, testing, and performance patterns. | https://skillsmp.com/skills/fujigo-software-f5-framework-claude-plugins-f5-stacks-skills-backend-django-skill-md |
| barkbarkgoose django-backend-dev | Secure Django backend development with thin views, service layer, validation, permissions, admin, and edge cases. | https://skillsmp.com/skills/barkbarkgoose-ai-agents-skills-django-backend-dev-skill-md |

## Source Hygiene

- Do not install marketplace code blindly into production projects.
- Do not copy instructions that conflict with project `AGENTS.md`, such as forced emoji, install prompts, or marketplace-specific commands.
- Prefer official framework documentation through Context7 or primary docs when exact API syntax matters.
- Keep credentials, marketplace API keys, and MCP client registration outside this repository.
