---
name: naga-align
description: >
  Alignment grilling before build. Use when requirements are fuzzy, stakeholders
  disagree, or the agent is about to code from a vague brief. Kills misalignment.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engineering
  tier: "A"
---

# Naga Align

## Problem it fixes
Most bad agent output is **misalignment**, not bad syntax. You thought the goal
was clear; the build proves it was not.

## When to use
- Before non-trivial implementation
- After a vague "make it better" / "add X"
- Before `naga-ship` or large refactors

## Rules
1. **Do not write production code** until the exit criteria below are met (spikes OK if labeled throwaway).
2. Ask **one hard question at a time** (or a tight batch of ≤3 if dependent).
3. Prefer concrete choices over open essays.
4. Challenge silent assumptions (users, scale, platforms, must-have vs nice-to-have).
5. Stop when the design tree has no open branches that would change the build.

## Question lenses (pick what fits)
- **Outcome:** What does done look like in one sentence?
- **User:** Who is blocked today, and what do they do after?
- **Out of scope:** What will we refuse even if easy?
- **Constraints:** time, budget, stack, compliance, brand
- **Success metric:** How do we know it worked in 7 days?
- **Failure:** What would make this a waste?
- **Interfaces:** APIs, data, auth, who owns the seam?
- **Non-goals:** performance theater, extra platforms, polish levels

## Exit criteria (all true)
- [ ] Goal in one sentence
- [ ] In scope / out of scope listed
- [ ] Constraints named
- [ ] Success check named
- [ ] Open questions = 0 or parked with owner

## Output template
```markdown
## Alignment brief
**Goal:** …
**In scope:** …
**Out of scope:** …
**Constraints:** …
**Success check:** …
**Decisions log:** …
**Ready for:** naga-ship | naga-tdd | naga-context | stop
```

## Pairing
- Fuzzy domain words → run `naga-context` next
- Clear vertical slice → `naga-tdd` or `naga-ship`
