#!/usr/bin/env bash
# Verify a Naga Codex eng install tree.
# Prefer: bash ./scripts/verify-install.sh /opt/data/skills/naga-codex-eng
set -euo pipefail

if [ -z "${BASH_VERSION:-}" ]; then
  exec bash "$0" "$@"
fi

TARGET="${1:-}"
if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
  echo "Usage: bash ./scripts/verify-install.sh <install-root>"
  echo "  e.g. bash ./scripts/verify-install.sh /opt/data/skills/naga-codex-eng"
  exit 2
fi

count="$(find "$TARGET" -type f -name SKILL.md | wc -l | tr -d ' ')"
echo "SKILL.md on disk: $count"

expect=""
manifest="$TARGET/INSTALL_MANIFEST.txt"
if [ -f "$manifest" ]; then
  if grep -q '^expected=' "$manifest" 2>/dev/null; then
    expect="$(grep '^expected=' "$manifest" | head -1 | cut -d= -f2 | tr -d '[:space:]')"
  else
    expect="$(grep '^skills=' "$manifest" | head -1 | cut -d= -f2 | tr -d '[:space:]' || true)"
  fi
  echo "Manifest: $manifest (expect=$expect)"
fi

if [ -z "$expect" ] || [ "$expect" = "0" ]; then
  ROOT="$(cd "$(dirname "$0")/.." && pwd)"
  if [ -d "$ROOT/skills" ]; then
    expect="$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
    echo "Fallback expect from repo skills/: $expect"
  fi
fi

if [ -z "$expect" ]; then
  echo "FAIL: could not determine expected skill count (no manifest, no repo skills/)"
  exit 1
fi

if [ "$count" -ne "$expect" ]; then
  echo "FAIL: expected $expect skills, found $count"
  find "$TARGET" -type f -name SKILL.md | sort
  exit 1
fi

# Frontmatter sanity (no process substitution — portable)
TMPF="$(mktemp)"
find "$TARGET" -type f -name SKILL.md | sort > "$TMPF"
bad=0
while IFS= read -r f; do
  [ -z "$f" ] && continue
  if ! grep -qE 'author:[[:space:]]*naga-codex' "$f" 2>/dev/null; then
    echo "WARN: missing author: naga-codex -> $f"
    bad=$((bad+1))
  fi
done < "$TMPF"
rm -f "$TMPF"

if [ "$bad" -gt 0 ]; then
  echo "FAIL: $bad skill(s) missing naga-codex author metadata"
  exit 1
fi

echo "OK: $count Naga eng skills under $TARGET"
exit 0
