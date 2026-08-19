# Examples

## Smoke flow (Tier A)

```text
1. ask-naga: "I want to add password reset to our API"
2. naga-align → Alignment brief
3. naga-ship → plan gate → tickets + naga-tdd per slice
4. naga-verify → L1/L2/L3 after green
5. naga-review → Standards ∥ Spec verdict
```

Bug path: `naga-debug` → red check → fix → `naga-verify` L1.


## Hermes

```bash
export SKILLS_DIR=/opt/data/skills
bash ./install.sh hermes
bash ./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"
```

Namespace is **`naga-codex-eng`** so it does not collide with `naga-codex` (cyber pack).
