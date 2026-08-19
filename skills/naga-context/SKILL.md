---
name: naga-context
description: >
  Build or sharpen a project CONTEXT.md shared language so agents and humans
  use the same terms. Use for glossaries, onboarding, and jargon collisions.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engineering
  tier: "A"
---

# Naga Context

## Problem it fixes
Agents and humans use the same words for different things. Output looks confident
and is wrong.

## When to use
- New repo / new teammate / new agent session on a complex domain
- Terms keep colliding (e.g. "tenant", "workspace", "org")
- Before long `naga-ship` work

## Deliverable
Create or update `CONTEXT.md` at repo root (or path the user names).

## CONTEXT.md skeleton
```markdown
# CONTEXT

## One-liner
What this product is (1–2 sentences).

## Glossary
| Term | Meaning here | Not to be confused with |
|------|--------------|-------------------------|
| … | … | … |

## Actors
Who uses the system and what they can do.

## Core flows
3–7 named flows in plain language.

## Invariants
Rules that must not break (auth, money, data residency, brand).

## Stack & seams
Languages, services, and where modules meet.

## Do / Don't
Agent-facing guardrails for this repo.
```

## Method
1. Scan existing README, code names, and user language
2. Propose glossary entries; **confirm contested terms** with the user
3. Write short definitions (1–2 lines)
4. Add invariants that affect implementation
5. Keep the file short enough to load every session

## Rules
- Prefer project truth over generic industry definitions
- Mark unknowns as `TBD` with owner
- Do not invent product strategy the user did not confirm
