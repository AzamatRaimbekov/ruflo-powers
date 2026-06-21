#!/usr/bin/env bash
# ============================================================================
#  Ruflo Powers — one-command update & publish
#  Stages every change, commits, and pushes to the GitHub repo so anyone
#  installing from it gets the latest toolkit.
#
#  Usage:
#    bash update.sh                 # commit with an auto timestamp message
#    bash update.sh "your message"  # commit with your own message
#    bash update.sh -n "msg"        # dry-run: show what would happen, push nothing
# ============================================================================
set -euo pipefail

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DRY=0
if [[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]]; then DRY=1; shift; fi
MSG="${1:-update: $(date '+%Y-%m-%d %H:%M')}"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

echo "▸ Ruflo Powers — update"
echo "  branch  : $BRANCH"
echo "  message : $MSG"

# --- show what's changing ---------------------------------------------------
if git diff --quiet && git diff --cached --quiet && [[ -z "$(git status --porcelain)" ]]; then
  echo "  • working tree clean — nothing new to commit"
else
  echo "▸ Changes:"
  git status -s
  if [[ $DRY -eq 1 ]]; then
    echo "  [dry-run] would: git add -A && git commit -m \"$MSG\""
  else
    git add -A
    git commit -m "$MSG" >/dev/null
    echo "  ✓ committed"
  fi
fi

# --- push -------------------------------------------------------------------
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "✗ No 'origin' remote set. Add it once, e.g.:"
  echo "    git remote add origin git@github.com:AzamatRaimbekov/ruflo-powers.git"
  exit 1
fi

if [[ $DRY -eq 1 ]]; then
  echo "  [dry-run] would: git push -u origin $BRANCH"
  echo "✓ dry-run done."
  exit 0
fi

echo "▸ Pushing to $(git remote get-url origin) …"
if git push -u origin "$BRANCH" 2>&1; then
  echo "✓ Published. Users get it via:"
  echo "    git clone https://github.com/AzamatRaimbekov/ruflo-powers.git ~/ruflo-powers"
else
  echo "✗ Push failed. If the repo doesn't exist yet, create it first:"
  echo "    https://github.com/new  (name: ruflo-powers, Public, no README)"
  exit 1
fi
