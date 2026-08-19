---
name: naga-review
description: >
  Dual-axis review of a diff or change set: Standards (quality/smells) and Spec
  (did we build what was agreed). Use on PRs, before merge, after naga-ship.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engineering
  tier: "A"
---

# Naga Review

## Problem it fixes
Single-pass reviews mix "is the code nice?" with "is it the right thing?" and
do both badly.

## When to use
- After implementation, before merge
- On a PR URL, branch diff, or patch
- End of `naga-ship`

## Inputs
- Diff range or files
- Spec / alignment brief / ticket text (if any)
- Repo standards (linters, CONTEXT.md, ADRs)

## Method — two axes (keep separate)

### Axis A — Standards
- Correctness risks, edge cases, error handling
- Security basics (secrets, injection, authz) — escalate to Cyber pack if deep
- Readability, naming, dead code, duplication
- Tests present for behavior change?
- Smells: long methods, feature envy, shotgun surgery (plain language)

### Axis B — Spec
- Each requirement traced to evidence in the diff
- Missing requirements called out
- Extra unrequested scope flagged
- Alignment brief contradictions

## Rules
- Do **not** merge the axes into one mushy list
- Prefer findings with file references
- Severity: block / should / nit
- If no spec exists, say so and review Standards only + recommend `naga-align`

## Output
```markdown
## Review
**Scope:** …
### Standards
| ID | Sev | Finding | Where |
|----|-----|---------|-------|
### Spec
| Req | Status | Evidence |
|-----|--------|----------|
### Verdict
approve | approve-with-nits | request-changes
```
