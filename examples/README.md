# Examples

## Smoke flow (Tier A)

```text
1. ask-naga: "I want to add password reset to our API"
2. naga-align → produce Alignment brief
3. naga-ship → tickets + naga-tdd per slice
4. naga-review → Standards + Spec verdict
```

## Hermes

```bash
export SKILLS_DIR=/opt/data/skills
./install.sh hermes
./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"
```

Namespace is **`naga-codex-eng`** so it does not collide with `naga-codex` (cyber pack).
