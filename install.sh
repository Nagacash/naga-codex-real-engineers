#!/usr/bin/env bash
# Naga Codex Agent Engineering — installer (Tier A)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-claude}"
DEST_OVERRIDE="${2:-}"
TMP_LIST="$(mktemp)"
trap 'rm -f "$TMP_LIST"' EXIT

grn() { printf 'OK: %s\n' "$*"; }
ylw() { printf 'NOTE: %s\n' "$*"; }
red() { printf 'ERROR: %s\n' "$*" >&2; }

build_list() {
  find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d | sort > "$TMP_LIST"
}

skill_count() {
  build_list
  wc -l < "$TMP_LIST" | tr -d ' '
}

install_flat() {
  local dest="$1"
  mkdir -p "$dest"
  build_list
  local n=0 skilldir name
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    if [ -e "$dest/$name" ]; then
      if [ -f "$dest/$name/SKILL.md" ] && grep -q 'author: naga-codex' "$dest/$name/SKILL.md" 2>/dev/null; then
        rm -rf "$dest/$name"
      else
        ylw "skip collision: $dest/$name"
        continue
      fi
    fi
    cp -R "$skilldir" "$dest/$name"
    echo "  + $name"
    n=$((n+1))
  done < "$TMP_LIST"
  grn "Installed $n skills (flat) -> $dest"
}

install_namespaced() {
  local skills_root="$1"
  local ns="${2:-naga-codex-eng}"
  local base
  base="$(basename "$skills_root")"
  case "$base" in
    cybersecurity|omh|security|naga-codex)
      ylw "Refusing foreign/other pack dir as root: $skills_root"
      skills_root="$(dirname "$skills_root")"
      ylw "Using parent: $skills_root"
      ;;
  esac
  local dest="$skills_root/$ns"
  mkdir -p "$dest"
  if [ -d "$dest" ]; then
    find "$dest" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  fi
  build_list
  local n=0 skilldir name
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    cp -R "$skilldir" "$dest/$name"
    echo "  + $name"
    n=$((n+1))
  done < "$TMP_LIST"
  cat > "$dest/INSTALL_MANIFEST.txt" <<EOF
naga-codex-agent-engineering
namespace=$ns
skills=$n
tier=A
posture=engineering-discipline
source=https://github.com/Nagacash/-Real-Engineers
EOF
  grn "Installed $n skills (namespaced) -> $dest"
  echo "Verify: ./scripts/verify-install.sh \"$dest\""
}

echo "Naga Codex Agent Engineering installer (Tier A)"
echo "Skills: $(skill_count) | Mode: $MODE"

case "$MODE" in
  claude) install_flat "${DEST_OVERRIDE:-$HOME/.claude/skills}" ;;
  project-claude) install_flat "${DEST_OVERRIDE:-.claude/skills}" ;;
  agents) install_flat "${DEST_OVERRIDE:-.agents/skills}" ;;
  hermes)
    SKILLS_ROOT="${DEST_OVERRIDE:-${SKILLS_DIR:-/opt/data/skills}}"
    echo "Hermes root: $SKILLS_ROOT | ns: naga-codex-eng"
    install_namespaced "$SKILLS_ROOT" "naga-codex-eng"
    ;;
  namespaced)
    install_namespaced "${DEST_OVERRIDE:-.}" "${3:-naga-codex-eng}"
    ;;
  *)
    cat <<'U'
Usage: ./install.sh <claude|project-claude|agents|hermes|namespaced> [dest]
  hermes -> $SKILLS_DIR/naga-codex-eng/<skill>
U
    exit 1
    ;;
esac
echo "Done."
