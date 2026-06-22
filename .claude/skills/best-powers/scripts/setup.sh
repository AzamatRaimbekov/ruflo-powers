#!/usr/bin/env bash
# best-powers: replicate the full Ruflo / Claude Code "best powers" setup
# from the master AI-TOOLS template into the current (or given) folder.
#
# Usage: setup.sh [target-folder] [--no-mcp] [--no-doctor] [--force]
#   target-folder  defaults to $PWD
#   --no-mcp       skip registering the claude-flow MCP server
#   --no-doctor    skip running `ruflo doctor --fix`
#   --force        overwrite an existing CLAUDE.md/AGENTS.md without warning
set -euo pipefail

MASTER="${BEST_POWERS_MASTER:-/Users/raimbekov/Desktop/AI-TOOLS}"
TARGET=""
DO_MCP=1; DO_DOCTOR=1; FORCE=0

for arg in "$@"; do
  case "$arg" in
    --no-mcp)    DO_MCP=0 ;;
    --no-doctor) DO_DOCTOR=0 ;;
    --force)     FORCE=1 ;;
    -*)          echo "⚠  unknown flag: $arg"; exit 2 ;;
    *)           TARGET="$arg" ;;
  esac
done
TARGET="${TARGET:-$PWD}"

if [[ "$(cd "$TARGET" 2>/dev/null && pwd)" == "$MASTER" ]]; then
  echo "⚠  Target is the master template itself — nothing to copy. Aborting."
  exit 1
fi

echo "▶ best-powers"
echo "  master : $MASTER"
echo "  target : $TARGET"
mkdir -p "$TARGET"

if [[ $FORCE -eq 0 && ( -f "$TARGET/CLAUDE.md" || -f "$TARGET/AGENTS.md" ) ]]; then
  echo "  • note: target already has CLAUDE.md/AGENTS.md — they will be overwritten (use --force to silence)."
fi

copy() { # src-relative
  local rel="$1"
  if [[ -e "$MASTER/$rel" ]]; then
    mkdir -p "$TARGET/$(dirname "$rel")"
    cp -R "$MASTER/$rel" "$TARGET/$(dirname "$rel")/"
    echo "  ✓ $rel"
  fi
}

echo "▶ Copying project config…"
copy "CLAUDE.md"           # rules + frontend standard + connectivity map
copy "AGENTS.md"           # Codex twin of CLAUDE.md
copy ".mcp.json"           # claude-flow (ruflo v3) MCP server
copy ".gitignore"
copy ".agents"             # agent config + skills (ruflo)
copy ".codex"             # Codex config + AGENTS override
copy ".rtk"                # RTK token-killer filter config
copy "agent-assets"        # frontend bundle (ui-ux-pro-max, design-system, wiki, react-19…)
copy "frontend-agents"     # standard Template Project starter (own wired .claude/)
copy ".claude/agents"      # all custom agent definitions
copy ".claude/commands"    # all slash commands
copy ".claude/helpers"     # helper scripts
copy ".claude/skills"      # full skill library (frontend, backend, swarm, github, sparc…)
copy ".claude/settings.json"

if [[ $DO_MCP -eq 1 ]]; then
  echo "▶ Registering claude-flow MCP server in target scope (idempotent)…"
  ( cd "$TARGET" && claude mcp add claude-flow -- npx -y ruflo@latest mcp start 2>/dev/null ) \
    && echo "  ✓ MCP added (scope: $TARGET)" || echo "  • MCP already present / skipped"
else
  echo "▶ Skipping MCP registration (--no-mcp); .mcp.json was still copied."
fi

if [[ $DO_MCP -eq 1 ]] && command -v claude >/dev/null 2>&1; then
  echo "▶ Ensuring superpowers plugin (user scope, global; idempotent)…"
  if claude plugin list 2>/dev/null | grep -q "superpowers@claude-plugins-official"; then
    echo "  • superpowers already installed"
  else
    claude plugin install superpowers@claude-plugins-official 2>/dev/null \
      && echo "  ✓ superpowers installed" || echo "  • superpowers install skipped (marketplace not configured?)"
  fi
fi

if [[ $DO_DOCTOR -eq 1 ]]; then
  echo "▶ Running ruflo doctor --fix…"
  ( cd "$TARGET" && npx -y ruflo@latest doctor --fix ) || echo "  • doctor reported issues (non-fatal)"
else
  echo "▶ Skipping ruflo doctor (--no-doctor)."
fi

# Summary
SKILLS=$(ls "$TARGET/.claude/skills" 2>/dev/null | wc -l | tr -d ' ')
AGENTS=$(ls "$TARGET/.claude/agents" 2>/dev/null | wc -l | tr -d ' ')
CMDS=$(ls "$TARGET/.claude/commands" 2>/dev/null | wc -l | tr -d ' ')
LAW="$TARGET/.claude/skills/frontend-agent/references/react-senior-standard.md"
echo "▶ Summary"
echo "  • skills: $SKILLS  • agent groups: $AGENTS  • commands: $CMDS"
[[ -f "$LAW" ]] && echo "  • frontend standard: present ($(wc -l < "$LAW" | tr -d ' ') lines)" \
                || echo "  • frontend standard: MISSING ⚠"
[[ -d "$TARGET/agent-assets" ]] && echo "  • agent-assets: installed"

echo "✅ best-powers initialized in: $TARGET"
echo "   Restart Claude Code in this folder so it picks up CLAUDE.md, skills, agents and the MCP server."
