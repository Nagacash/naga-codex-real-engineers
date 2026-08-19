# Install notes

## Exec bit
GitHub file API pushes often land as `100644`. Documented entrypoint is:

```bash
bash ./install.sh hermes
bash ./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"
```

Optional: `chmod +x install.sh scripts/*.sh` after clone.

## Dynamic skill count
`install.sh` counts `skills/*/` and writes `expected=N` + `skills=N` into
`INSTALL_MANIFEST.txt`. `verify-install.sh` reads that manifest (fallback: count
repo `skills/` next to the script). Adding a 9th skill no longer requires
editing a hardcoded `expect=8`.

## Namespace wipe
Hermes mode treats `naga-codex-eng/` as **pack-owned**. Each install removes
direct children then recopies. Do not co-locate unrelated files there.

## Foreign-pack guard
Basename string match only (`cybersecurity|omh|security|naga-codex`). A renamed
pack directory is not detected — pass the multi-pack root (`SKILLS_DIR`) explicitly.

## Flat collision / author field
Flat mode replaces existing dirs only when `SKILL.md` matches
`author: naga-codex`. All pack skills declare this under `metadata:`.
