#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-}"
[ -n "$TARGET" ] && [ -d "$TARGET" ] || { echo "Usage: $0 <install-root>"; exit 2; }
count="$(find "$TARGET" -type f -name SKILL.md | wc -l | tr -d ' ')"
echo "SKILL.md: $count"
expect=6
[ "$count" -eq "$expect" ] || { echo "FAIL expected $expect"; exit 1; }
echo "OK: $expect Naga eng skills under $TARGET"
