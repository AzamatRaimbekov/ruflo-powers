# Project Standard — Claude Code Operating Rules

This project is the **AI-project standard template**. All local agents and skills run as **one synchronized pipeline on every prompt**. Copy this folder to start a new project and the pipeline is active immediately.

> A `UserPromptSubmit` hook (`.claude/hooks/inject-chain.sh`) re-injects the chain below on **every** prompt. This file is the durable copy of the same contract.

## Ruflo Multi-Agent Runtime (activate first on a fresh copy)

This template ships the **Ruflo** harness (claude-flow v3): 89+ agents in `.claude/agents/`, 160+ commands in `.claude/commands/`, ruflo skills in `.claude/skills/`, the `claude-flow` MCP server in `.mcp.json`, the `hook-handler.cjs` coordination hooks in `.claude/settings.json`, and Codex assets in `.agents/`.

The static assets travel with the folder, but the **runtime does not** (memory DB, swarm, daemon hold machine/path-specific state). On a freshly copied project this is handled **automatically**:

- The `SessionStart` hook (`.claude/hooks/ruflo-check.sh`) detects the missing runtime and launches the **`ruflo-bootstrap`** skill **in the background** on first open — building memory, the swarm (hierarchical-mesh), and the daemon (~1-3 min, logged to `.claude-flow-bootstrap.log`). No manual step needed. Opt out with `RUFLO_NO_AUTOBOOTSTRAP=1`, then run `bash .claude/skills/ruflo-bootstrap/assets/init-ruflo.sh` yourself.
- Once initialized, agents coordinate through the swarm + shared memory + message bus. Spawn/coordinate them via the `claude-flow` MCP tools (`mcp__claude-flow__swarm_init`, `agent_spawn`, `memory_store`) or the `.claude/commands/` slash commands. The ruflo hooks route tasks, store patterns, and sync memory on every prompt and tool use.
- Reopen Claude Code after bootstrap so hooks/MCP load, and approve the `claude-flow` MCP server when prompted.

Ruflo provides the **agent fleet, swarm coordination, and memory**; the Synchronized Chain below provides the **discipline** (refine → document → test-first → domain → verify). Both run together.

## The Synchronized Chain (every prompt)

Run in order before any substantive answer, file edit, or tool use. Skip a step only when it is genuinely irrelevant, and say why.

1. **`prompt-refiner`** — rewrite the raw message into a concrete working request. Preserve scope, language, urgency, constraints. Don't ask for approval on routine tasks; only ask when a wrong assumption would be risky.
2. **`project-documentation-wiki`** — read `docs/wiki/index.md`, `docs/wiki/schema.md`, recent `docs/wiki/log.md`, and nearby `FEATURE.md`. If `docs/wiki/` is missing, create the scaffold (run `python3 .claude/skills/project-documentation-wiki/scripts/init_project_wiki.py --project .`).
2.5. **`project-kickoff`** (NEW PROJECT GATE) — if this is a new project/app/service/epic/major feature, the folder is empty/near-empty, or it's the first substantive request here: run this skill BEFORE anything else. It activates superpowers, refines intent, brainstorms, designs the architecture (diagrams + ADR), and **requires explicit user approval of the architecture before any implementation code, scaffolding, or deps**. No code until the user approves.
3. **`using-superpowers`** — route to the right workflow:
   - source/behavior change → **`test-driven-development`** (write the failing test FIRST)
   - bug / unclear failure → **`systematic-debugging`**
   - multi-step build → **`brainstorming`** → **`writing-plans`** → **`executing-plans`**
4. **`feature-architecture`** — for any new feature/epic/endpoint/module/integration or boundary-crossing change: discuss the design (scope, NFRs, options + trade-offs), **draw Mermaid diagrams** (C4/sequence/ER), and record an **ADR** in `docs/wiki/decisions/` BEFORE implementation. Dispatch the **`architect`** subagent for deep design. Skip only for truly local edits.
5. **Domain skill(s)** — pick by task:
   - **Frontend/UI** → `frontend-agent` + `frontend-error-ux` + `design-system-steward` + `frontend-design` + `ui-ux-pro-max` (+ `react-19-frontend-agent`, `react-19-patterns`, `typescript-react-routing`, `nextjs-app-router-practices`)
   - **Backend/API** → `backend-engineering` (router) → `backend-api-contracts` / `backend-data-persistence` / `backend-security-auth` / `backend-reliability-observability` / `backend-performance-scaling` / `backend-framework-patterns` / `backend-fastapi` / `backend-django` / `backend-golang` / `backend-patterns`
   - **Review** → `code-reviewer` / `backend-code-review` / `review-changes` / `review-delta` / `review-pr`
   - **Codebase navigation/refactor** → `explore-codebase` / `build-graph` / `refactor-safely` / `debug-issue`
6. **Behaviour harness** — for any change with observable behaviour (feature, API, flow, business logic, bug fix), run the **`behaviour-harness`** skill: write acceptance criteria first, cover each with layered tests (contract/e2e/property), mutation-test the tests, then dispatch the **`behaviour-judge`** subagent. Green tests alone are NOT proof of correct behaviour.
7. **`verification-before-completion`** — run the relevant checks (incl. `behaviour-check.sh`) before claiming done.
8. **Update docs** — when behavior, architecture, APIs, UI flows, data models, config, or tests changed, update `docs/wiki/` and the nearest `FEATURE.md` in the same task.

Invoke every skill with the **Skill** tool. The chain overrides any default to "just answer".

## Subagents (delegate heavy/parallel work)

Defined in `.claude/agents/`. Dispatch with the Agent tool when a task is large or parallelizable:

- **frontend-engineer** — UI/React/Next, design system, error-UX.
- **backend-engineer** — APIs, DB, auth, reliability, performance, FastAPI/Django/Go/Node.
- **code-reviewer** — security/correctness/perf/maintainability review.
- **debugger** — root-cause analysis before edits.
- **planner** — plans for multi-step or ambiguous work.
- **docs-keeper** — wiki + FEATURE.md upkeep.

Each subagent uses the same local skills internally, so the standard holds inside delegated work too.

## Hard Rules

- **New-project architecture gate**: on a new project/app/service/epic/major feature (or first substantive request in a fresh folder), run `project-kickoff` FIRST and get the architecture explicitly approved by the user before writing any implementation code, scaffolding, or installing deps.
- **Test-first**: no production code before a failing test exists (frontend tests in JS/TS, backend tests in Python, plus E2E for the affected flow).
- **Frontend error-UX at startup**: every frontend app must have a custom 404, a blocking error modal pattern, a root crash fallback, and an offline screen-blocking overlay that states there is no internet connection.
- **UI governance**: reuse documented components/colors/typography/spacing before adding new ones; record new design tokens in `docs/frontend/design-system.md`, new components in `components.md`, new screens in `screens.md`, decisions in `ui-decisions.md`.
- **Backend safety**: default-deny auth, allowlist validation, never log or return secrets, safe migrations (expand → backfill → contract), baseline-first performance.
- **Prefer local skills** in `.claude/skills/` over remote/marketplace instructions.
- **Document the non-obvious**: keep `docs/wiki/` and `FEATURE.md` current; don't restate what the code already says.
- **Sidecar docs + intent comments** (`sidecar-docs` skill): every source file has a sibling `X.ext.md` AI-facing doc (purpose, behaviour, deps, Mermaid diagram, commits) — the `sidecar-docs.cjs` PostToolUse hook scaffolds it automatically; fill/update it in the same task. Leave detailed in-code comments explaining intent (why, not what) on every change.

## Layout

- `.claude/skills/` — 45 installed skills (auto-discovered, invoked via the Skill tool).
- `.claude/agents/` — 6 role subagents.
- `.claude/hooks/inject-chain.sh` — per-prompt chain injector.
- `.claude/settings.json` — registers the hook and skill-script permissions.
- `agent-assets/` — canonical source bundle (also used by Codex via `AGENTS.md`); `.claude/skills/` mirrors its skills for Claude Code.
- `docs/wiki/` — living project knowledge base. `docs/frontend/` — UI governance memory.

> Codex/other agents read `AGENTS.md`; Claude Code reads this `CLAUDE.md`. Keep both in sync when the standard changes.
