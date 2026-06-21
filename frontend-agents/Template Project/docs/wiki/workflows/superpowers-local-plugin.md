---
type: workflow
status: current
updated: 2026-06-03
sources:
  - ../../AGENTS.md
  - ../../AgentMD.md
  - ../../agent-assets/superpowers/.codex-plugin/plugin.json
  - ../../agent-assets/superpowers/FEATURE.md
tags:
  - project-docs
  - wiki/workflow
  - superpowers
---

# Superpowers Local Plugin

## Purpose

This template includes a local Codex Superpowers plugin mirror at
`agent-assets/superpowers/` so copied projects can use planning, TDD, debugging,
review, verification, and delivery workflows without relying only on a global
plugin install.

## Startup Usage

Project work starts with `agent-assets/prompt-refiner/SKILL.md` and
`agent-assets/project-documentation-wiki/SKILL.md`. After that startup, read
`agent-assets/superpowers/skills/using-superpowers/SKILL.md` and the specific
Superpowers workflow skill that applies.

Use these local paths for common workflows:

- `agent-assets/superpowers/skills/test-driven-development/SKILL.md`
- `agent-assets/superpowers/skills/systematic-debugging/SKILL.md`
- `agent-assets/superpowers/skills/verification-before-completion/SKILL.md`
- `agent-assets/superpowers/skills/writing-plans/SKILL.md`
- `agent-assets/superpowers/skills/executing-plans/SKILL.md`
- `agent-assets/superpowers/skills/subagent-driven-development/SKILL.md`

## Verification

Run from the source `ai-tools` workspace before shipping template changes:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```
