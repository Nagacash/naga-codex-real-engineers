---
name: naga-verify
description: >
  Three-layer quality gate after the agent generates code: L1 mechanical,
  L2 functional/behavior, L3 architecture flags for the human. Use after
  implement, before merge, or when the user says "verify", "check quality",
  "did this break anything".
license: MIT
metadata:
  author: naga-codex
  version: "1.1.0"
  domain: engineering
  tier: "A"
---

# Naga Verify

## Problem it fixes
Agents declare "done" after generating code. Errors compound: types pass
while behavior is wrong, or behavior works while architecture rots.

## When to use
- Immediately after a generation or `naga-tdd` green
- Before `naga-review` merge verdict (or as its Standards engine)
- User: "verify this", "quality gate", "run the layers"

## Posture
AI is a **competent junior under protocols** — it runs L1/L2 rigorously and
**flags** L3 for the human. It does not self-approve architecture.

## Three layers (keep separate)

### L1 — Mechanical (run tools; report facts)
Execute what exists in the repo (skip missing tools, say so):
- Typecheck / compile
- Lint
- Unit/integration tests touched by the change
- Import/build resolution for changed entrypoints

Report: pass/fail + command + short log tail. No vibes.

### L2 — Functional (reason against the brief)
- Does the change meet the stated requirements / alignment brief?
- Edge cases and error paths
- Obvious perf footguns (N+1, unbounded lists, sync on hot path)
- Basic security hygiene (validation, authz on new endpoints, no new secrets)
  — deep AppSec → Naga Codex Cyber pack

### L3 — Architecture (flag for human; do not rubber-stamp)
- Pattern fit vs existing seams / CONTEXT.md
- Coupling / seam violations
- Testability and future change cost
- "Would I want this at 10× load / 10× team?"

## Output template
```markdown
## Verify report
**Change:** …
### L1 Mechanical
| Check | Result | Evidence |
|-------|--------|----------|
| typecheck | pass/fail/skip | …
| lint | … | …
| tests | … | …
**L1 verdict:** pass | fail
### L2 Functional
- Requirements: met / gaps: …
- Edges: …
- Perf notes: …
- Security hygiene: …
**L2 verdict:** pass | fail | needs-human
### L3 Architecture (human)
- Flags: …
**L3 verdict:** clear | discuss | block-until-human
### Overall
ship | fix-L1 | fix-L2 | wait-human-L3
```

## Rules
- Never skip L1 when tools exist
- Never bury L1 fails under prose
- L3 is **not** self-approved by the agent alone on non-trivial changes
- Pair with `naga-review` for PR narrative; this skill is the gate loop
