# Claude Plugin Directory Mirror

## Purpose

`agent-assets/claude-plugin-directory/` is the folder-based local mirror of the
public Claude Plugins directory. It turns the single registry file into one
template package folder per public plugin entry.

## Entry Points

- `../claude-plugin-directory.config.json`: source registry with 100 plugin
  entries and their local package paths.
- `README.md`: short policy note for the directory mirror.
- `plugins/<slug>/manifest.json`: per-plugin local package metadata.
- `plugins/<slug>/.claude-plugin/plugin.json`: disabled template manifest.
- `plugins/<slug>/capabilities/plugin.json`: plugin capability hint.
- `plugins/<slug>/capabilities/mcp.json`: MCP capability hint when the public
  directory card indicates MCP/server behavior.
- `plugins/<slug>/capabilities/skill.md`: skill capability hint when the public
  directory card indicates skills, agents, commands, hooks, or workflows.

## Behavior

- There are 100 package folders generated from `https://claude.com/plugins`.
- Local folders are installed into copied projects by
  `../../tools/install-agent-assets.ps1`.
- Entries are disabled by default and are not authenticated live plugin installs.
- The mirror does not store credentials, OAuth grants, API tokens, private
  package payloads, or target-environment secrets.
- Target projects must install and verify each real plugin in their own
  environment before treating the local folder as active.

## Verification

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-install-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```

## Test Case Checklist

- Happy path: every registry entry has a matching `plugins/<slug>/` folder.
- Manifest coverage: every package has `manifest.json`, `README.md`, and
  `.claude-plugin/plugin.json`.
- Capability coverage: every package has `capabilities/plugin.json`; MCP and
  skill hints create their respective files.
- Template coverage: `Template Project/agent-assets/claude-plugin-directory/`
  contains the same folder mirror.
- Security: no generated folder contains credentials or enabled-by-default
  live server configuration.

## Wiki Links

- `../../docs/wiki/sources/claude-plugin-directory.md`
- `../../docs/wiki/workflows/agent-assets-consolidation.md`
- `../../docs/wiki/workflows/template-project.md`
