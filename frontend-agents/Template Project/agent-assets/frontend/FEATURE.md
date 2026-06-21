# Frontend Plugin

## Purpose

`agent-assets/frontend/` is a local Codex plugin that packages the project frontend agent and its references. It lets future Codex sessions use one `frontend-agent` skill for modular React, Next.js, UI governance, TanStack Router, TanStack Query, Zustand, shadcn fallback components, and verification workflows.

## Entry Points

- `.codex-plugin/plugin.json`: Codex plugin manifest.
- `.claude-plugin/plugin.json`: lightweight compatibility manifest for Claude-style plugin mirrors.
- `skills/frontend-agent/SKILL.md`: main frontend agent instructions.
- `skills/design-system-steward/SKILL.md`: design-system governance workflow for
  creating and maintaining detailed web/mobile `design.md` documentation.
- `skills/frontend-error-ux/SKILL.md`: startup and implementation rules for 404 pages, error modals, crash fallbacks, and offline no-internet blockers.
- `skills/frontend-agent/references/`: bundled project architecture, guardrails, React patterns, Next.js patterns, and frontend governance references.
- `../ui-ux-pro-max/SKILL.md`: imported UI/UX design intelligence skill used alongside `frontend-design` for accessibility, product-specific style choices, responsive behavior, charts, and stack-specific UI guidance.

## Behavior

- New or onboarded frontend projects should receive this plugin through
  `tools\install-agent-assets.ps1 -TargetProject <project-path>` from the
  source `ai-tools` workspace.
- Inside a target project, this skill should start with the project-local
  `agent-assets/project-documentation-wiki/SKILL.md` and then route frontend
  work through the local `agent-assets/frontend/skills/frontend-agent/SKILL.md`.
- The skill starts by reading project wiki/frontend docs and inspecting the existing stack.
- Design-system and UI-governance work should use `design-system-steward` to
  create or refresh `docs/frontend/design.md`, `docs/mobile/design.md`, or
  `docs/design.md` depending on project platform scope.
- UI and visual QA work should use the imported `ui-ux-pro-max` skill alongside
  the Anthropic `frontend-design` mirror when deeper UX, chart, accessibility,
  or stack-specific design guidance is useful.
- Frontend initialization immediately runs `frontend-error-ux` to check for a
  404 page, blocking error modal/dialog pattern, crash fallback, and offline
  screen-blocking overlay that shows a no-internet message.
- For generic React SPAs, it defaults new routing to TanStack Router.
- For explicit Next.js projects, it uses App Router conventions.
- TanStack Query is the default client-side server-state layer.
- Zustand is the maximum global client-state manager and is limited to small client-only stores.
- Project-owned or active skill-provided UI components are preferred before shadcn; shadcn is the fallback.
- Durable frontend changes require wiki/frontend docs and feature docs to stay current.

## Dependencies

- Project wiki under `docs/wiki/`.
- Frontend governance docs under `docs/frontend/`.
- Detailed design-system docs such as `docs/frontend/design.md`, generated or
  maintained by `design-system-steward`.
- Project-local documentation wiki skill under `agent-assets/project-documentation-wiki/`.
- The local shadcn skill/plugin when shadcn components are needed.
- Browser verification tooling when UI work needs rendered inspection.

## Verification

- Validate the skills with `python C:\Users\User\.codex\skills\.system\skill-creator\scripts\quick_validate.py agent-assets\frontend\skills\frontend-agent`, `python C:\Users\User\.codex\skills\.system\skill-creator\scripts\quick_validate.py agent-assets\frontend\skills\design-system-steward`, and `python C:\Users\User\.codex\skills\.system\skill-creator\scripts\quick_validate.py agent-assets\frontend\skills\frontend-error-ux`.
- Validate the plugin with `python C:\Users\User\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py agent-assets\frontend`.
- Validate the consolidated folder with `powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1`.

## Wiki Links

- `docs/wiki/workflows/frontend-agent-plugin.md`
- `docs/wiki/architecture/modular-frontend-architecture.md`
- `docs/wiki/decisions/frontend-architecture-guardrails.md`

## Open Questions

- Whether to add this plugin to a personal or repo marketplace is left to the user; the current task created the plugin files but did not install/register a marketplace entry.
