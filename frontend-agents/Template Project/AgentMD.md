# AgentMD

AGENTS.md is the Codex-readable source of truth for this template. This file is
a human-facing mirror so the startup chain is visible before copying the
template into a real project.

## Startup Chain

Every frontend task in a project created from this template must start through
the project-local skills in this order:

1. `agent-assets/prompt-refiner/SKILL.md`
2. `agent-assets/project-documentation-wiki/SKILL.md`
3. `agent-assets/superpowers/skills/using-superpowers/SKILL.md`
4. `agent-assets/superpowers/skills/brainstorming/SKILL.md`
5. `agent-assets/superpowers/skills/writing-plans/SKILL.md`
6. `agent-assets/superpowers/skills/executing-plans/SKILL.md`
7. `agent-assets/superpowers/skills/dispatching-parallel-agents/SKILL.md`
8. `agent-assets/superpowers/skills/subagent-driven-development/SKILL.md`
9. `agent-assets/superpowers/skills/test-driven-development/SKILL.md`
10. `agent-assets/superpowers/skills/systematic-debugging/SKILL.md`
11. `agent-assets/superpowers/skills/requesting-code-review/SKILL.md`
12. `agent-assets/superpowers/skills/receiving-code-review/SKILL.md`
13. `agent-assets/superpowers/skills/verification-before-completion/SKILL.md`
14. `agent-assets/superpowers/skills/finishing-a-development-branch/SKILL.md`
15. `agent-assets/superpowers/skills/using-git-worktrees/SKILL.md`
16. `agent-assets/superpowers/skills/writing-skills/SKILL.md`
17. `agent-assets/frontend/skills/frontend-agent/SKILL.md`
18. `agent-assets/frontend/skills/design-system-steward/SKILL.md`
19. `agent-assets/frontend/skills/frontend-error-ux/SKILL.md`
20. `agent-assets/react-19-frontend-agent/skills/react-19-frontend-agent/SKILL.md`
21. `agent-assets/react-19-frontend-agent/skills/react-19-patterns/SKILL.md`
22. `agent-assets/react-19-frontend-agent/skills/typescript-react-routing/SKILL.md`
23. `agent-assets/react-19-frontend-agent/skills/nextjs-app-router-practices/SKILL.md`
24. `agent-assets/frontend-design-plugin/skills/frontend-design/SKILL.md`
25. `agent-assets/frontend-design-plugin/skills/frontend-design/PROJECT_EXTENSION.md`
26. `agent-assets/ui-ux-pro-max/SKILL.md`
27. `agent-assets/code-reviewer/SKILL.md`
28. `agent-assets/backend-patterns/SKILL.md`
29. `agent-assets/backend/skills/backend-engineering/SKILL.md`
30. `agent-assets/backend/skills/backend-api-contracts/SKILL.md`
31. `agent-assets/backend/skills/backend-data-persistence/SKILL.md`
32. `agent-assets/backend/skills/backend-security-auth/SKILL.md`
33. `agent-assets/backend/skills/backend-reliability-observability/SKILL.md`
34. `agent-assets/backend/skills/backend-performance-scaling/SKILL.md`
35. `agent-assets/backend/skills/backend-framework-patterns/SKILL.md`
36. `agent-assets/backend/skills/backend-code-review/SKILL.md`
37. `agent-assets/backend/skills/backend-golang/SKILL.md`
38. `agent-assets/backend/skills/backend-fastapi/SKILL.md`
39. `agent-assets/backend/skills/backend-django/SKILL.md`
40. `agent-assets/code-review-graph/skills/build-graph/SKILL.md`
41. `agent-assets/code-review-graph/skills/debug-issue/SKILL.md`
42. `agent-assets/code-review-graph/skills/explore-codebase/SKILL.md`
43. `agent-assets/code-review-graph/skills/refactor-safely/SKILL.md`
44. `agent-assets/code-review-graph/skills/review-changes/SKILL.md`
45. `agent-assets/code-review-graph/skills/review-delta/SKILL.md`
46. `agent-assets/code-review-graph/skills/review-pr/SKILL.md`

## Required Project Flow

1. Apply `prompt-refiner` to turn the raw user prompt into a concrete internal
   working request.
2. Run the local wiki initializer:

   ```powershell
   python agent-assets/project-documentation-wiki/scripts/init_project_wiki.py --project .
   ```

3. Read `docs/wiki/index.md`, `docs/wiki/schema.md`, recent
   `docs/wiki/log.md`, and relevant `FEATURE.md` files.
4. Use `frontend-agent` as the main frontend router skill.
5. Use `agent-assets/claude-plugin-directory.config.json` as the single-file
   catalog for Claude directory plugins, MCP capability hints, and skill
   capability hints. Entries are disabled by default and never store secrets.
   The matching folders live in `agent-assets/claude-plugin-directory/plugins/`.
6. Use local Superpowers workflows for planning, TDD, debugging, review, and
   verification before falling back to a global plugin install.
7. Run the `frontend-error-ux` startup audit before UI implementation.
8. Use `design-system-steward` for design-system, token, palette, theme,
   component, screen, or mobile UI governance work and keep `design.md` current.
9. Use React 19, routing, and Next.js sub-skills when the task touches those
   areas.
10. Use the frontend-design skill and project extension for UI, design-system,
   screen, component, and visual QA work.
11. Use `ui-ux-pro-max` for deeper UI/UX design intelligence, accessibility,
   chart guidance, responsive behavior, and product-specific visual choices.
12. Use `code-reviewer` for code review, PR review, security, performance,
   correctness, maintainability, and testing review.
13. Use `backend-patterns` for backend/API architecture, database optimization,
   caching, auth, rate limiting, jobs, logging, and server-side patterns.
14. Use the backend skill pack in `agent-assets/backend/` for architecture, API
   contracts, data persistence, security/auth, reliability/observability,
   performance/scaling, framework patterns, and backend code review.
15. Use `agent-assets/code-review-graph/` as the local Code Review Graph test
   plugin bundle. Its MCP config is `agent-assets/code-review-graph/.mcp.json`
   and runs `uvx code-review-graph serve`; use its review skills for
   review-graph workflow tests.
16. Keep `docs/wiki/`, `docs/frontend/`, and local `FEATURE.md` files current.

## Bundled Agent Metadata

OpenAI agent metadata is bundled next to the relevant skills:

- `agent-assets/project-documentation-wiki/agents/openai.yaml`
- `agent-assets/prompt-refiner/agents/openai.yaml`
- `agent-assets/superpowers/skills/using-superpowers/agents/openai.yaml`
- `agent-assets/superpowers/skills/brainstorming/agents/openai.yaml`
- `agent-assets/superpowers/skills/writing-plans/agents/openai.yaml`
- `agent-assets/superpowers/skills/executing-plans/agents/openai.yaml`
- `agent-assets/superpowers/skills/dispatching-parallel-agents/agents/openai.yaml`
- `agent-assets/superpowers/skills/subagent-driven-development/agents/openai.yaml`
- `agent-assets/superpowers/skills/test-driven-development/agents/openai.yaml`
- `agent-assets/superpowers/skills/systematic-debugging/agents/openai.yaml`
- `agent-assets/superpowers/skills/requesting-code-review/agents/openai.yaml`
- `agent-assets/superpowers/skills/receiving-code-review/agents/openai.yaml`
- `agent-assets/superpowers/skills/verification-before-completion/agents/openai.yaml`
- `agent-assets/superpowers/skills/finishing-a-development-branch/agents/openai.yaml`
- `agent-assets/superpowers/skills/using-git-worktrees/agents/openai.yaml`
- `agent-assets/superpowers/skills/writing-skills/agents/openai.yaml`
- `agent-assets/frontend/skills/frontend-agent/agents/openai.yaml`
- `agent-assets/frontend/skills/design-system-steward/agents/openai.yaml`
- `agent-assets/frontend/skills/frontend-error-ux/agents/openai.yaml`
- `agent-assets/ui-ux-pro-max/agents/openai.yaml`
- `agent-assets/code-reviewer/agents/openai.yaml`
- `agent-assets/backend-patterns/agents/openai.yaml`
- `agent-assets/backend/skills/backend-engineering/agents/openai.yaml`
- `agent-assets/backend/skills/backend-api-contracts/agents/openai.yaml`
- `agent-assets/backend/skills/backend-data-persistence/agents/openai.yaml`
- `agent-assets/backend/skills/backend-security-auth/agents/openai.yaml`
- `agent-assets/backend/skills/backend-reliability-observability/agents/openai.yaml`
- `agent-assets/backend/skills/backend-performance-scaling/agents/openai.yaml`
- `agent-assets/backend/skills/backend-framework-patterns/agents/openai.yaml`
- `agent-assets/backend/skills/backend-code-review/agents/openai.yaml`
- `agent-assets/backend/skills/backend-golang/agents/openai.yaml`
- `agent-assets/backend/skills/backend-fastapi/agents/openai.yaml`
- `agent-assets/backend/skills/backend-django/agents/openai.yaml`
- `agent-assets/react-19-frontend-agent/skills/react-19-frontend-agent/agents/openai.yaml`
- `agent-assets/react-19-frontend-agent/skills/react-19-patterns/agents/openai.yaml`
- `agent-assets/react-19-frontend-agent/skills/typescript-react-routing/agents/openai.yaml`
- `agent-assets/react-19-frontend-agent/skills/nextjs-app-router-practices/agents/openai.yaml`
