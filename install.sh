#!/usr/bin/env bash
# Naga Codex Agent Engineering — installer (Tier A+)
# Prefer: bash ./install.sh hermes
# Optional after clone: chmod +x install.sh scripts/*.sh  → then ./install.sh works
set -euo pipefail

# Re-exec under bash if invoked via sh
if [ -z "${BASH_VERSION:-}" ]; then
  exec bash "$0" "$@"
fi

ROOT="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-claude}"
DEST_OVERRIDE="${2:-}"
TMP_LIST="$(mktemp)"
trap 'rm -f "$TMP_LIST"' EXIT

grn() { printf 'OK: %s\n' "$*"; }
ylw() { printf 'NOTE: %s\n' "$*"; }
red() { printf 'ERROR: %s\n' "$*" >&2; }

is_naga_skill_dir() {
  # True if dir looks like our pack skill (metadata author)
  local d="$1"
  [ -f "$d/SKILL.md" ] || return 1
  grep -qE 'author:[[:space:]]*naga-codex' "$d/SKILL.md" 2>/dev/null
}

build_list() {
  find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d | sort > "$TMP_LIST"
}

skill_count() {
  build_list
  wc -l < "$TMP_LIST" | tr -d ' '
}

EXPECTED="$(skill_count)"

install_flat() {
  local dest="$1"
  mkdir -p "$dest"
  build_list
  local n=0 skipped=0 skilldir name
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    if [ -e "$dest/$name" ]; then
      if is_naga_skill_dir "$dest/$name"; then
        rm -rf "$dest/$name"
      else
        ylw "skip collision (not a Naga skill): $dest/$name"
        skipped=$((skipped+1))
        continue
      fi
    fi
    cp -R "$skilldir" "$dest/$name"
    echo "  + $name"
    n=$((n+1))
  done < "$TMP_LIST"
  grn "Installed $n / $EXPECTED skills (flat) -> $dest"
  if [ "$skipped" -gt 0 ]; then
    ylw "$skipped basename collision(s). Prefer: bash ./install.sh hermes"
  fi
  if [ "$n" -ne "$EXPECTED" ] && [ "$skipped" -eq 0 ]; then
    red "Expected $EXPECTED, installed $n"
    exit 1
  fi
}

install_namespaced() {
  local skills_root="$1"
  local ns="${2:-naga-codex-eng}"
  local base
  base="$(basename "$skills_root")"
  # Basename guard only — renamed packs can slip through (documented)
  case "$base" in
    cybersecurity|omh|security|naga-codex)
      ylw "Refusing foreign/other pack dir as root: $skills_root"
      skills_root="$(dirname "$skills_root")"
      ylw "Using parent: $skills_root"
      ;;
  esac

  local dest="$skills_root/$ns"
  mkdir -p "$dest"

  # Warn before wipe if unexpected contents
  if [ -d "$dest" ]; then
    local foreign=0
    local entry
    for entry in "$dest"/*; do
      [ -e "$entry" ] || continue
      local b
      b="$(basename "$entry")"
      case "$b" in
        INSTALL_MANIFEST.txt|ask-naga|naga-align|naga-context|naga-tdd|naga-review|naga-ship|naga-verify|naga-debug)
          ;;
        *)
          if [ -d "$entry" ] && is_naga_skill_dir "$entry"; then
            :
          else
            ylw "non-pack entry will be removed: $entry"
            foreign=$((foreign+1))
          fi
          ;;
      esac
    done
    if [ "$foreign" -gt 0 ]; then
      ylw "Wiping $dest ($foreign non-pack entr(y/ies)). Do not store other files in this namespace."
    fi
    # Remove only direct children (namespace is pack-owned)
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
expected=$EXPECTED
tier=A+
posture=engineering-discipline
source=https://github.com/Nagacash/-Real-Engineers
installed_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF

  if [ "$n" -ne "$EXPECTED" ]; then
    red "Expected $EXPECTED skills from repo, installed $n"
    exit 1
  fi
  grn "Installed $n skills (namespaced) -> $dest"
  echo "Verify: bash \"$ROOT/scripts/verify-install.sh\" \"$dest\""
}

echo "Naga Codex Agent Engineering installer (Tier A+)"
echo "Skills in pack: $EXPECTED | Mode: $MODE"

case "$MODE" in
  claude) install_flat "${DEST_OVERRIDE:-$HOME/.claude/skills}" ;;
  project-claude) install_flat "${DEST_OVERRIDE:-.claude/skills}" ;;
  agents) install_flat "${DEST_OVERRIDE:-.agents/skills}" ;;
  hermes)
    SKILLS_ROOT="${DEST_OVERRIDE:-${SKILLS_DIR:-/opt/data/skills}}"
    echo "Hermes root: $SKILLS_ROOT | ns: naga-codex-eng"
    echo "NOTE: install replaces the entire naga-codex-eng/ namespace (pack-owned)."
    install_namespaced "$SKILLS_ROOT" "naga-codex-eng"
    ;;
  namespaced)
    install_namespaced "${DEST_OVERRIDE:-.}" "${3:-naga-codex-eng}"
    ;;
  *)
    cat <<'U'
Usage: bash ./install.sh <mode> [dest]

  claude | project-claude | agents   Flat install by skill basename
  hermes [SKILLS_DIR]                -> SKILLS_DIR/naga-codex-eng/<skill>
  namespaced <root> [ns]             Custom namespaced install

Hermes:
  export SKILLS_DIR=/opt/data/skills
  bash ./install.sh hermes
  bash ./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"

Optional (enables ./install.sh without bash prefix):
  chmod +x install.sh scripts/*.sh
U
    exit 1
    ;;
esac
echo "Done."
