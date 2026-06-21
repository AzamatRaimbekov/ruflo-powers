# Code Review Graph Test Plugin

## Purpose

`agent-assets/code-review-graph/` is the project-local test bundle for
`tirth8205/code-review-graph`. It mirrors the upstream Python package, MCP
config, hooks, docs, tests, and review skills so this repository and copied
template projects can test review-graph workflows without fetching the source
again.

## Included Files

- `manifest.json`: local source, version, commit, MCP, and skill metadata.
- `.mcp.json`: MCP server config for `uvx code-review-graph serve`.
- `.codex-plugin/plugin.json` and `.claude-plugin/plugin.json`: local plugin
  metadata wrappers for this workspace.
- `code_review_graph/`: upstream Python package.
- `skills/`: upstream Code Review Graph skills.
- `hooks/hooks.json`: upstream session and post-tool hook definitions.
- `tests/`, `docs/`, `scripts/`, `uv.lock`, and project metadata for local
  testing and inspection.

## Behavior

- The bundle is copied into target projects by
  `tools/install-agent-assets.ps1`.
- The matching template copy lives at
  `Template Project/agent-assets/code-review-graph/`.
- MCP client registration and credentials stay outside the repository.
- Use the local review skills, especially `skills/review-pr/SKILL.md`,
  `skills/review-changes/SKILL.md`, and `skills/review-delta/SKILL.md`, for
  test review workflows.

## Verification

Run from the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-install-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```

## Wiki Links

- `../../docs/wiki/sources/code-review-graph-plugin.md`
- `../../docs/wiki/workflows/agent-assets-consolidation.md`
- `../../docs/wiki/workflows/frontend-project-bootstrap.md`
