---
name: ask-naga
description: >
  Router for Naga Codex agent-engineering skills. Use when the user is unsure
  which discipline skill to run, or says "what skill", "how should we work",
  "pick a flow".
license: MIT
metadata:
  author: naga-codex
  version: "1.1.0"
  domain: engineering
  tier: "A"
---

# Ask Naga (router)

## When to use
- User is unsure which engineering skill fits
- Start of a messy request that could be align / ship / review / tdd

## Posture
Small, composable discipline — not a process takeover. User stays in control.

## Route table

| User signal | Skill |
|-------------|--------|
| Unclear goals, "build X" with no constraints | `naga-align` |
| Jargon drift, onboarding, "what do we mean by…" | `naga-context` |
| New feature/fix with testable behavior | `naga-tdd` |
| PR/diff quality check | `naga-review` |
| Multi-step delivery from idea → done | `naga-ship` |
| Just generated code / "is this good?" | `naga-verify` |
| Bug or slowness, need root cause | `naga-debug` |
| Security audit / AppSec / GDPR | hand off to **Naga Codex Cyber Security** pack |

## Output
Name the chosen skill, one sentence why, and the first question or step.
Do not run two orchestrators at once.
