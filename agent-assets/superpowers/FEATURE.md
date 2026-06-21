# Superpowers Local Plugin

## Purpose

`agent-assets/superpowers/` is the local Codex plugin mirror for Superpowers.
It bundles planning, TDD, debugging, code review, verification, and delivery
workflow skills so projects created from this repository do not depend only on a
global Codex plugin install.

## Entry Points

- `.codex-plugin/plugin.json`: Codex plugin manifest for the local mirror.
- `skills/using-superpowers/SKILL.md`: Superpowers skill-routing bootstrap.
- `skills/test-driven-development/SKILL.md`: red-green-refactor workflow for
  implementation tasks.
- `skills/systematic-debugging/SKILL.md`: root-cause debugging workflow.
- `skills/verification-before-completion/SKILL.md`: evidence-before-completion
  gate.
- `skills/writing-plans/SKILL.md`, `skills/executing-plans/SKILL.md`, and
  `skills/subagent-driven-development/SKILL.md`: planning and execution flows.

## Behavior

- Project-local startup rules should prefer this folder before relying on a
  globally installed Superpowers plugin.
- `prompt-refiner` remains the first project step in this repository, followed
  by project wiki startup and then applicable Superpowers workflows.
- For source-code or product-behavior changes, use the local
  `test-driven-development` skill before production edits.
- Before calling work complete, use the local
  `verification-before-completion` skill and run the relevant checks.

## Dependencies

- Source mirror: `C:\Users\User\.codex\plugins\cache\openai-curated\superpowers\83d1f0d2`.
- Installer: `../../tools/install-agent-assets.ps1`.
- Verification scripts: `../../tools/verify-agent-assets.ps1`,
  `../../tools/test-install-agent-assets.ps1`, and
  `../../tools/test-template-project.ps1`.

## Verification

Run from the source `ai-tools` workspace:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-install-agent-assets.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\test-template-project.ps1
```

## Test Case Checklist

- Happy path: `agent-assets/superpowers/` contains the Codex manifest, README,
  license, assets, all Superpowers `SKILL.md` files, and their `openai.yaml`
  metadata.
- Bootstrap: `install-agent-assets.ps1` copies Superpowers into target projects.
- Template: `Template Project/` contains Superpowers and lists its skills in
  `AGENTS.md` and `AgentMD.md`.
- TDD: project rules point source-code changes at the local
  `test-driven-development` skill.
- Verification: completion rules point final claims at the local
  `verification-before-completion` skill.

## Wiki Links

- `../../docs/wiki/workflows/agent-assets-consolidation.md`
- `../../docs/wiki/workflows/template-project.md`

## Open Questions

- Which additional important plugins should be mirrored after Superpowers.
