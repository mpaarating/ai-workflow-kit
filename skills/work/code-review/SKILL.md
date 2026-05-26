---
name: code-review
description: Multi-persona code review of the current branch — Architect (system fit, patterns, reuse) + Nitpicker (naming, magic values, dead code). Runs in parallel and merges.
---

# Code Review

## Trigger Phrases

- "code review"
- "review this branch"
- "review my code"
- "review my changes"

Optional modifiers: "against develop", "just the test files", "focus on architecture".

## Workflow

1. Diff the current branch against the base branch (default `main`, fall back to `master`). If no changes, stop and say so. If the diff is huge (50+ files / 2000+ lines), offer to review a subset first.

2. Run two personas in parallel:
   - **Architect** — pattern consistency, reuse, simplification, abstraction level, responsibility, dependency injection, dependency direction, API design. Full persona: `shared/personas/architect.md`. Prefix findings with `Arch:`.
   - **Nitpicker** — naming, boolean naming, test naming, comment quality, magic values, dead code, consistent patterns, variable clustering. Full persona: `shared/personas/nitpicker.md`. Prefix findings with `Nit:`.

   Each finding is tagged with a focus area and rated High / Medium / Low. Every finding includes a concrete suggestion.

3. Merge: deduplicate, sort High → Low, group by file. Cap at 15 issues; note any omitted minor items.

4. Report. Lead with what's good. State explicitly when there are no High issues. Then offer to fix auto-fixable items (naming, magic values) or refocus on a specific file.

## Modifiers

- "against `<branch>`" — diff against that branch instead of the default
- "just the test files" — filter the diff to `*.test.*` / `*.spec.*`; Nitpicker's TestNaming focus becomes primary
- "focus on architecture" / "focus on nits" — run only one persona

## Report Format

```
## Code Review: [branch]
Files: [n] | Lines: +[added] / -[removed]

### High
[blocking issues]

### Medium
[worth addressing]

### Low
[polish]

### Summary
[2-3 sentences: what's good, what needs attention]
```

## Notes

- Uses local git only. No platform integration.
- If persona files are missing, use the focus areas above as the review criteria.
