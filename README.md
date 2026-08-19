# Naga Codex — Real Engineers

**Repo:** [`Nagacash/-Real-Engineers`](https://github.com/Nagacash/-Real-Engineers)  
_Pack name: Naga Codex Agent Engineering (Tier A)_


**Tier A** — small, original agent skills for real engineering discipline.  
Align · Context · TDD · Dual-axis review · Ship  

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Tier](https://img.shields.io/badge/Tier-A%20(6%20skills)-0B3D5C.svg)](docs/why-tier-a.md)
[![Hermes](https://img.shields.io/badge/Hermes-naga--codex--eng-green.svg)](examples/README.md)

> Not vibe coding. Not a process cult. Composable skills you control.

## Skills (6)

| Skill | Invoke when |
|-------|-------------|
| [`ask-naga`](skills/ask-naga/) | Unsure which skill fits |
| [`naga-align`](skills/naga-align/) | Requirements fuzzy — grill before build |
| [`naga-context`](skills/naga-context/) | Need shared language / CONTEXT.md |
| [`naga-tdd`](skills/naga-tdd/) | Red → green → refactor one slice |
| [`naga-review`](skills/naga-review/) | PR/diff: Standards ∥ Spec |
| [`naga-ship`](skills/naga-ship/) | Orchestrate idea → done |

## Install

```bash
git clone https://github.com/Nagacash/-Real-Engineers.git
cd -- -Real-Engineers

./install.sh claude           # ~/.claude/skills
./install.sh project-claude   # ./.claude/skills
./install.sh agents           # ./.agents/skills

# Hermes (namespaced — no foreign-pack pollution)
export SKILLS_DIR=/opt/data/skills
./install.sh hermes
./scripts/verify-install.sh "$SKILLS_DIR/naga-codex-eng"
```

## Pair with Cyber

Security audits stay in **[NagaCodex-cyber-security](https://github.com/Nagacash/NagaCodex-cyber-security)**  
(`naga-codex/` on Hermes). This pack is `naga-codex-eng/`.

Typical combo: `naga-align` on engagement scope → cyber `full-security-audit`.

## Inspiration (not a fork)

Failure-mode framing is common in modern agent-engineering practice (including
ideas discussed around mattpocock/skills, MIT). **All skill text here is original
Naga Codex.** See [NOTICE](NOTICE).

## Naga Codex

nagacodex.cloud · AI management · Cybersecurity · Film
