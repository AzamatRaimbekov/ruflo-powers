#!/usr/bin/env bash
# ============================================================================
#  Ruflo Powers — installer
#  Copies the full Claude Code "best powers" toolkit (skills, agents, commands,
#  helpers, MCP config, frontend bundle, rules) into a target project.
#
#  Usage:
#    git clone <this-repo> ruflo-powers
#    cd /path/to/your-project
#    bash /path/to/ruflo-powers/install.sh            # install into current dir
#    bash /path/to/ruflo-powers/install.sh ~/my-app   # install into a target dir
#
#  Flags:
#    --force     overwrite existing files without creating .bak backups
#    --no-mcp    skip registering the claude-flow MCP server
#    --dry-run   print what would happen, change nothing
# ============================================================================
set -euo pipefail

# --- resolve where this script (and the payload) lives ----------------------
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- parse args -------------------------------------------------------------
TARGET_DIR=""
FORCE=0
NO_MCP=0
DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --force)   FORCE=1 ;;
    --no-mcp)  NO_MCP=1 ;;
    --dry-run) DRY_RUN=1 ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)         TARGET_DIR="$arg" ;;
  esac
done
TARGET_DIR="${TARGET_DIR:-$PWD}"

if [[ "$SOURCE_DIR" == "$TARGET_DIR" ]]; then
  echo "✗ Source and target are the same directory. Run from your project, pointing at the cloned repo." >&2
  exit 1
fi

# --- payload: what gets copied ----------------------------------------------
# Directories copied wholesale (runtime junk excluded via rsync filter below).
PAYLOAD_DIRS=(
  ".claude"
  ".codex"
  ".agents"
  ".rtk"
  "agent-assets"
  "frontend-agents"
)
# Single files (CLAUDE.md / AGENTS.md are backed up, never silently clobbered).
PAYLOAD_FILES=(
  ".mcp.json"
  ".gitignore"
  "CLAUDE.md"
  "AGENTS.md"
)
# Never copy these (secrets / local / regenerable runtime state).
EXCLUDES=(
  "--exclude=*.db"
  "--exclude=.swarm"
  "--exclude=.claude-flow/data"
  "--exclude=.claude-flow/logs"
  "--exclude=memory/"
  "--exclude=*.log"
  "--exclude=.env"
  "--exclude=.env.*"
  "--exclude=CLAUDE.local.md"
  "--exclude=settings.local.json"
  "--exclude=.DS_Store"
  "--exclude=node_modules"
  "--exclude=.git"
)

run() { if [[ $DRY_RUN -eq 1 ]]; then echo "  [dry-run] $*"; else eval "$@"; fi; }

echo "▸ Ruflo Powers installer"
echo "  source: $SOURCE_DIR"
echo "  target: $TARGET_DIR"
[[ $DRY_RUN -eq 1 ]] && echo "  (dry-run — no changes will be made)"
echo

command -v rsync >/dev/null 2>&1 || { echo "✗ rsync is required but not found." >&2; exit 1; }
mkdir -p "$TARGET_DIR"

# --- copy directories -------------------------------------------------------
for d in "${PAYLOAD_DIRS[@]}"; do
  if [[ -d "$SOURCE_DIR/$d" ]]; then
    echo "▸ $d/"
    run rsync -a "${EXCLUDES[@]}" "\"$SOURCE_DIR/$d/\"" "\"$TARGET_DIR/$d/\""
  fi
done

# --- copy single files (with backup) ----------------------------------------
for f in "${PAYLOAD_FILES[@]}"; do
  [[ -f "$SOURCE_DIR/$f" ]] || continue
  if [[ -f "$TARGET_DIR/$f" && $FORCE -eq 0 ]]; then
    echo "▸ $f  (existing → $f.bak)"
    run cp "\"$TARGET_DIR/$f\"" "\"$TARGET_DIR/$f.bak\""
  else
    echo "▸ $f"
  fi
  run cp "\"$SOURCE_DIR/$f\"" "\"$TARGET_DIR/$f\""
done

# --- make hooks/helpers executable ------------------------------------------
if [[ -d "$TARGET_DIR/.claude/helpers" && $DRY_RUN -eq 0 ]]; then
  find "$TARGET_DIR/.claude/helpers" -type f \( -name '*.sh' -o -name 'pre-commit' -o -name 'post-commit' \) \
    -exec chmod +x {} \; 2>/dev/null || true
fi

# --- register the claude-flow MCP server ------------------------------------
if [[ $NO_MCP -eq 0 ]]; then
  echo
  echo "▸ MCP (claude-flow / ruflo)"
  if command -v claude >/dev/null 2>&1; then
    run "(cd \"$TARGET_DIR\" && claude mcp add claude-flow -- npx -y ruflo@latest mcp start)" || \
      echo "  ⚠ MCP registration skipped (already present or 'claude' refused) — .mcp.json is in place regardless."
  else
    echo "  ⚠ 'claude' CLI not found — .mcp.json copied; the MCP server will load when you open Claude Code."
  fi
fi

echo
echo "✓ Done."
echo
echo "Next steps:"
echo "  1. Open the project in Claude Code."
echo "  2. (optional) npx -y ruflo@latest doctor --fix"
echo "  3. Review CLAUDE.md — it carries binding rules (frontend standard, etc.)."
[[ -f "$TARGET_DIR/CLAUDE.md.bak" ]] && echo "  • Your previous CLAUDE.md was saved as CLAUDE.md.bak — merge anything you need."
