# Naga Codex — Real Engineers

**Repo:** [`Nagacash/-Real-Engineers`](https://github.com/Nagacash/-Real-Engineers)  
_Pack name: Naga Codex Agent Engineering (Tier A)_


**Tier A+** — small, original agent skills for real engineering discipline.  
Align · Context · TDD · Dual-axis review · Ship  

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Tier](https://img.shields.io/badge/Tier-A%20(8%20skills)-0B3D5C.svg)](docs/why-tier-a.md)
[![Hermes](https://img.shields.io/badge/Hermes-naga--codex--eng-green.svg)](examples/README.md)

<p align="center">
  <img src="assets/hero-banner-photo.svg" alt="Naga Codex Real Engineers" width="100%" />
</p>


> Not vibe coding. Not a process cult. Composable skills you control.

## Skills (8)

| Skill | Invoke when |
|-------|-------------|
| [`ask-naga`](skills/ask-naga/) | Unsure which skill fits |
| [`naga-align`](skills/naga-align/) | Requirements fuzzy — grill before build |
| [`naga-context`](skills/naga-context/) | Need shared language / CONTEXT.md |
| [`naga-tdd`](skills/naga-tdd/) | Red → green → refactor one slice |
| [`naga-review`](skills/naga-review/) | PR/diff: Standards ∥ Spec |
| [`naga-ship`](skills/naga-ship/) | Orchestrate idea → done |
| [`naga-verify`](skills/naga-verify/) | L1/L2/L3 quality gate after generation |
| [`naga-debug`](skills/naga-debug/) | Hypothesis-driven bug/perf diagnosis |

## Install

```bash
git clone https://github.com/Nagacash/-Real-Engineers.git
cd -- -Real-Engineers

# Use bash explicitly (scripts may not have +x depending on clone/fs)
bash ./install.sh claude           # ~/.claude/skills
bash ./install.sh project-claude   # ./.claude/skills
bash ./install.sh agents           # ./.agents/skills

# Hermes (namespaced — no foreign-pack pollution)
export SKILLS_DIR=/opt/data/skills
bash ./install.sh hermes
bash ./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"
# expect: OK: N Naga eng skills  (N = count of skills/ dirs; from INSTALL_MANIFEST)

# Optional: enable ./install.sh without bash prefix
# chmod +x install.sh scripts/*.sh
```

**Notes:** `install.sh hermes` **replaces** the whole `$SKILLS_DIR/naga-codex-eng/` namespace (pack-owned — do not store other files there). Foreign-pack root guard is basename-based (`cybersecurity|omh|security|naga-codex`).


## Install friction notes

| Topic | Behavior |
|-------|----------|
| Exec bit | Prefer `bash ./install.sh` — Git checkouts may not preserve `+x` |
| Verify count | Reads `expected=` / `skills=` from `INSTALL_MANIFEST.txt` (not hardcoded) |
| Namespace wipe | Hermes install clears `naga-codex-eng/` then reinstalls — pack-owned only |
| Foreign roots | Basename blocklist only; renamed packs can slip through |

## Pair with Cyber

Security audits stay in **[NagaCodex-cyber-security](https://github.com/Nagacash/NagaCodex-cyber-security)**  
(`naga-codex/` on Hermes). This pack is `naga-codex-eng/`.

Typical combo: `naga-align` on engagement scope → cyber `full-security-audit`.

## Inspiration (not a fork)

Failure-mode framing is common in modern agent-engineering practice (including
ideas discussed around mattpocock/skills and quality-gate patterns from the vibe-coding-playbook tradition, MIT where applicable). **All skill text here is original
Naga Codex.** See [NOTICE](NOTICE).


## Visual assets

| File | Use |
|------|-----|
| [`assets/hero-banner-photo.svg`](assets/hero-banner-photo.svg) | README hero |
| [`assets/og-card-photo.svg`](assets/og-card-photo.svg) | Social / Open Graph (export JPG for GitHub Settings → Social preview) |
| [`assets/hero-banner.svg`](assets/hero-banner.svg) · [`og-card.svg`](assets/og-card.svg) | Lightweight vector fallbacks |

**GitHub Social preview:** Settings → General → Social preview → upload a PNG/JPG export of `og-card-photo.svg`.

---
## Naga Codex

nagacodex.cloud · AI management · Cybersecurity · Film
