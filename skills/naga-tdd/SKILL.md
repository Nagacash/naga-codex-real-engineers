---
name: naga-tdd
description: >
  Red-green-refactor discipline for a single vertical slice. Use when adding
  behavior or fixing a bug that should stay fixed.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engineering
  tier: "A"
---

# Naga TDD

## Problem it fixes
Agents spray code, then hunt for tests. Feedback arrives too late; entropy wins.

## When to use
- New behavior with a clear pass/fail
- Bug fix that needs a regression lock
- Inside `naga-ship` at agreed seams

## Loop (one slice at a time)
1. **Specify** the slice in one sentence + examples
2. **Red** — write a failing test (or minimal repro) first
3. Prove red (run it)
4. **Green** — smallest code to pass
5. Prove green
6. **Refactor** — clean structure without changing behavior; tests stay green
7. Commit logical unit if user wants git history

## Rules
- No feature code before a failing check exists (unless user waives in writing)
- One slice per loop; do not boil the ocean
- If red is hard, the slice is too big — split
- Prefer tests through the public seam (deep module), not private guts
- Name tests in behavior language from `CONTEXT.md` when it exists

## Output per slice
```markdown
## Slice
**Behavior:** …
**Red proof:** command + failure
**Green proof:** command + pass
**Refactor notes:** …
```

## Out of scope
- Full coverage ideology
- Rewriting the test framework mid-slice
