#!/usr/bin/env bash
# UserPromptSubmit hook — injects the mandatory synchronized skill chain on EVERY prompt.
# Whatever this script prints to stdout is added to the model's context for this turn.
# Keep it short, deterministic, and dependency-free so the template works after a plain copy.

cat <<'CHAIN'
<synchronized-agent-chain priority="must-follow">
This project runs all local agents/skills as ONE synchronized pipeline. For THIS prompt, before any substantive answer, file edit, or tool use, run the chain in order and skip a step only when it is genuinely irrelevant (say why if you skip):

0. ruflo runtime — the SessionStart hook auto-bootstraps the runtime (memory, swarm, daemon) in the background on a fresh copy; if it reported a failure, run the `ruflo-bootstrap` skill. Once up, prefer the Ruflo agents/swarm + `claude-flow` MCP tools for fan-out and coordination.
1. prompt-refiner — turn the raw request into a concrete working request (preserve scope, language, constraints).
2. project-documentation-wiki — read docs/wiki/index.md, schema.md, recent log.md, and nearby FEATURE.md; create the wiki scaffold if missing.
2.5 NEW PROJECT GATE — if this is a new project/app/service/epic/major feature, OR the folder is empty/near-empty, OR it's the first substantive request here: run the `project-kickoff` skill. It activates superpowers, refines intent, brainstorms, designs the architecture (Mermaid + ADR), and REQUIRES explicit user approval of that architecture BEFORE any implementation code, scaffolding, or deps. No code until the user says "approved".
3. using-superpowers — route the task to the right workflow skill:
   - source/behavior change  -> test-driven-development (failing test FIRST)
   - bug / unclear failure    -> systematic-debugging
   - multi-step build         -> brainstorming -> writing-plans -> executing-plans
3.5 feature-architecture — for a new feature/module/endpoint/integration or boundary-crossing change: discuss design (scope, NFRs, options+tradeoffs), DRAW Mermaid diagrams (C4/sequence/ER), record an ADR in docs/wiki/decisions/ BEFORE coding (or dispatch the `architect` subagent).
4. Domain skill(s):
   - frontend/UI -> frontend-agent + frontend-error-ux (404, blocking error modal, crash fallback, offline overlay) + design-system-steward + frontend-design + ui-ux-pro-max
   - backend/API -> backend-engineering (router) -> the matching backend-* skill(s)
   - review      -> code-reviewer / backend-code-review / review-changes
5. behaviour-harness — for any observable behaviour change (feature/API/flow/logic/bugfix): acceptance criteria first → layered tests (contract/e2e/property) → mutation-test the tests → behaviour-judge subagent. Green tests are NOT proof of correct behaviour.
6. verification-before-completion — run the relevant checks (incl. behaviour-check.sh) BEFORE claiming done.
7. Update docs/wiki/ and the nearest FEATURE.md when behavior, architecture, APIs, UI, data, config, or tests changed.

Invoke skills with the Skill tool. This chain is mandatory and overrides any default to "just answer".
</synchronized-agent-chain>
CHAIN
exit 0
