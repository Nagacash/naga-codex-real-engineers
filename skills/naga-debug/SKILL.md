---
name: naga-debug
description: >
  Hypothesis-driven diagnosis for bugs and performance issues. Use when
  something is broken or slow and shotgun fixes would make it worse.
license: MIT
metadata:
  author: naga-codex
  version: "1.1.0"
  domain: engineering
  tier: "A"
---

# Naga Debug

## Problem it fixes
Agents guess fixes. You get random patches and no proof of root cause.

## When to use
- Production/staging bug, flaky test, performance regression
- User: "why is this slow", "fix this properly", "bisect"

## Method
1. **Symptoms** — what, when, metrics, recent changes (facts only)
2. **Hypotheses** — top 3 ranked causes; each needs disproof evidence
3. **Loop** — for best hypothesis:
   - Make a **red** check that fails on this bug (test, metric, repro)
   - Instrument or bisect
   - Confirm or kill hypothesis
4. **Fix** — smallest change that turns red → green
5. **Lock** — leave the regression check in the suite when possible

## Output
```markdown
## Debug brief
**Symptom:** …
**Hypotheses:**
1. … (evidence for/against)
2. …
3. …
**Active check (red):** …
**Root cause:** … | still-open
**Fix:** …
**Regression lock:** …
```

## Rules
- No multi-file "while I'm here" refactors during diagnosis
- Prefer parallel safe observations; serialize risky prod actions
- If security incident → hand off to Cyber `incident-triage`
