# Backend Skill Pack

## Purpose

`agent-assets/backend/` is the local backend engineering plugin package. It turns high-signal backend skills discovered through SkillsMP into project-owned Codex skills and agent metadata for repeatable backend design, implementation, review, and verification, including Go/Golang, FastAPI, and Django/DRF backend work.

## Entry Points

- `.codex-plugin/plugin.json`: Codex plugin metadata and UI prompts.
- `.claude-plugin/plugin.json`: compatibility metadata for Claude-style plugin mirrors.
- `skills/backend-engineering/SKILL.md`: architecture tradeoffs and production backend decision flow.
- `skills/backend-api-contracts/SKILL.md`: REST/OpenAPI contracts, pagination, errors, versioning, and webhooks.
- `skills/backend-data-persistence/SKILL.md`: schemas, migrations, indexes, transactions, and pooling.
- `skills/backend-security-auth/SKILL.md`: authentication, authorization, secrets, validation, and threat checks.
- `skills/backend-reliability-observability/SKILL.md`: structured logs, metrics, tracing, SLOs, retries, timeouts, and idempotency.
- `skills/backend-performance-scaling/SKILL.md`: measurement, caching, queues, backpressure, and capacity.
- `skills/backend-framework-patterns/SKILL.md`: FastAPI, Node/Express, and Next.js backend implementation patterns.
- `skills/backend-code-review/SKILL.md`: backend review checklist for correctness, security, maintainability, performance, and tests.
- `skills/backend-golang/SKILL.md`: idiomatic Go backend services, APIs, workers, data access, concurrency, tests, and profiling.
- `skills/backend-fastapi/SKILL.md`: production FastAPI routes, schemas, dependencies, SQLAlchemy/SQLModel, Alembic, auth, and pytest patterns.
- `skills/backend-django/SKILL.md`: Django/DRF models, serializers, views, services, permissions, ORM optimization, migrations, and tests.
- `references/skillsmp-sources.md`: source provenance and selection criteria.
- `references/backend-quality-checklist.md`: shared quality checklist across backend skills.

## Behavior

- Prefer these local skills before remote marketplace instructions for backend design and review.
- Use `backend-engineering` first when the task spans more than one backend concern.
- Use narrower skills for implementation or review once the affected concern is clear.
- Keep marketplace sources as provenance. Do not copy third-party skill files verbatim into target projects.
- Use official framework documentation when exact API syntax or version behavior matters.

## Verification

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-install-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```

## Test Case Checklist

- Happy path: all eleven backend skills exist with `SKILL.md` and `agents/openai.yaml`.
- Packaging: Codex and Claude plugin manifests parse as JSON and include names.
- Bootstrap: installer copies the backend plugin into a target project and lists the skills in the managed `AGENTS.md` block.
- Template: `Template Project` includes the backend plugin and lists skill paths in both `AGENTS.md` and `AgentMD.md`.
- Validation: every backend skill passes `quick_validate.py`.
- Source hygiene: source references cite SkillsMP/GitHub without storing secrets or copied third-party bodies.

## Wiki Links

- `../docs/wiki/sources/skillsmp-backend-skills.md`
- `../docs/wiki/workflows/backend-skill-pack.md`
- `../docs/wiki/workflows/agent-assets-consolidation.md`

## Open Questions

- Whether to later add stack-specific backend packs for Laravel, Rails, Go, or Java depends on future target projects.
