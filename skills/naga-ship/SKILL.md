---
name: naga-ship
description: >
  Orchestrate delivery: align if needed, optional context, slice to tickets,
  implement with TDD at seams, dual-axis review, done checklist. User-invoked.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engineering
  tier: "A"
---

# Naga Ship

## Problem it fixes
Agents jump straight to code. You get a pile of changes and no shared plan.

## When to use
- "Build this", "ship the feature", "close the loop on this brief"
- Work larger than one tight TDD slice

## Posture
You orchestrate; you do not imprison the user in ceremony. Skip steps that are
already satisfied. Never invent process debt.

## Pipeline
1. **Align** — If goal/scope unclear → `naga-align` until exit criteria met  
2. **Context** — If terms collide → `naga-context` (light touch)  
3. **Slice** — Break into tracer-bullet tickets (each shippable / testable)  
4. **Implement** — For each ticket: `naga-tdd` at the behavior seam  
5. **Review** — `naga-review` on the accumulated diff  
6. **Done** — Checklist below  

## Ticket shape
```markdown
### T1 — <title>
**Behavior:** …
**Done when:** …
**Blocked by:** none | T0
**Seam:** module/API/UI
```

## Done checklist
- [ ] Alignment brief exists (or user waived)
- [ ] Each ticket done or explicitly cut
- [ ] Tests green for changed behavior
- [ ] Review verdict not `request-changes` (or issues fixed)
- [ ] User-facing summary of what shipped

## Rules
- One ticket at a time unless user asks for parallel
- Prefer small vertical slices over horizontal layers
- If security-sensitive → pull Naga Codex Cyber skills for that slice
- Do not start ticket 2 while ticket 1 is red

## Output
Running log: plan → ticket statuses → review verdict → ship summary.
