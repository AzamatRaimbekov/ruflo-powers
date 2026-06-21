---
type: overview
status: current
updated: 2026-06-03
sources:
  - ../../AGENTS.md
  - ../../AgentMD.md
  - ../../agent-assets/superpowers/FEATURE.md
  - ../../agent-assets/backend/FEATURE.md
  - ../../agent-assets/backend/.codex-plugin/plugin.json
  - ../../agent-assets/code-review-graph/manifest.json
  - ../../agent-assets/code-review-graph/.mcp.json
tags:
  - project-docs
  - wiki/overview
---

# Template Project Overview

## Purpose

This folder is a ready-to-copy Codex project template. It provides local agent
rules, skills, plugin metadata, wiki memory, and frontend governance docs for
new projects.

## Main Systems

- `AGENTS.md` is the Codex-readable project rule source.
- `AgentMD.md` mirrors the startup chain for humans before copying the
  template.
- `agent-assets/` contains project-local skills, agents, references, and plugin
  mirrors.
- `agent-assets/claude-plugin-directory.config.json` is the single-file
  catalog for Claude directory plugins, MCP capability hints, and skill
  capability hints.
- `agent-assets/claude-plugin-directory/plugins/` is the folder mirror with one
  package folder per public Claude plugin directory entry.
- `agent-assets/backend/` is the SkillsMP-derived backend engineering skill
  pack for architecture, API contracts, data persistence, security/auth,
  reliability/observability, performance/scaling, Go/Golang, FastAPI,
  Django/DRF, framework patterns, and backend code review.
- `agent-assets/code-review-graph/` is the local Code Review Graph MCP/test
  plugin bundle. Its `.mcp.json` runs `uvx code-review-graph serve`.
- [[superpowers-local-plugin]] documents the local Codex Superpowers mirror for
  planning, TDD, debugging, review, verification, and delivery workflows.
- `docs/frontend/` contains starter UI governance memory.
