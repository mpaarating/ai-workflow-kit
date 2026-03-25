---
name: code-review
description: Multi-persona code review with Architect and Nitpicker perspectives
---

# Code Review

## Trigger Phrases

- "code review"
- "review this branch"
- "review my code"
- "review my changes"

## Inputs

No input required. The skill reviews the current branch's changes against the base branch.

Optional inputs:
- A specific base branch: "review my code against develop"
- A file filter: "review just the test files"
- A focus area: "review with focus on naming" or "review the architecture"

## Workflow

### Step 1: Gather the Diff

Using local git commands:

1. Identify the current branch name: `git branch --show-current`
2. Identify the base branch (default: `main`): check if `main` exists, fall back to `master`
3. Get the full diff: `git diff [base]...HEAD`
4. List changed files: `git diff --name-only [base]...HEAD`
5. Get a stat summary: `git diff --stat [base]...HEAD`

If there are no changes, tell the user: "No changes found against [base]. Are you on the right branch?"

If the diff is very large (50+ files or 2000+ lines changed), warn the user and offer to review a subset (e.g., by directory or file type).

### Step 2: Run Reviews in Parallel

Run two review perspectives simultaneously. Each persona is defined in a shared file — read the persona definition before starting the review.

#### Architect Review

Read `shared/personas/architect.md` for the full persona definition.

Focus areas:
- **Pattern Consistency**: Does the code follow established patterns in the codebase?
- **Reusability**: Is there existing code that should be reused?
- **Simplification**: Is there a simpler approach?
- **Abstraction Level**: Right level of abstraction for the use case?
- **Responsibility**: Single responsibility per function/class?
- **Dependency Injection**: Dependencies injectable and testable?
- **Dependency Direction**: Dependencies flowing correctly?
- **API Design**: Public interfaces intuitive and consistent?

Review the diff and identify issues. For each issue:
- Prefix with `Arch:`
- Tag the focus area: `[PatternConsistency]`, `[Reusability]`, etc.
- Rate importance: High, Medium, or Low
- Include a specific suggestion or question

#### Nitpicker Review

Read `shared/personas/nitpicker.md` for the full persona definition.

Focus areas:
- **Naming**: Precise, intention-revealing, consistent names?
- **Boolean Naming**: Booleans read as yes/no questions?
- **Test Naming**: Test names describe scenario and outcome?
- **Comment Quality**: Comments explain why, not what?
- **Magic Values**: No unexplained literals?
- **Dead Code**: No commented-out code, stale TODOs, debug statements?
- **Consistent Patterns**: Similar operations follow similar patterns?
- **Variable Clustering**: Related variables grouped together?

Review the diff and identify issues. For each issue:
- Prefix with `Nit:`
- Tag the focus area: `[Naming]`, `[MagicValues]`, etc.
- Rate importance: High, Medium, or Low
- Include a concrete fix suggestion

### Step 3: Merge and Deduplicate

Combine findings from both perspectives.

- Remove duplicates (same issue flagged by both personas — keep the more detailed one)
- Sort by importance: High first, then Medium, then Low
- Group by file for readability

### Step 4: Write the Review Report

Present findings in this format:

```
## Code Review: [branch-name]
**Files changed**: [count] | **Lines**: +[added] / -[removed]

### High Priority
[Issues that should be addressed before merging]

### Medium Priority
[Issues worth addressing but not blocking]

### Low Priority
[Polish items — address if time permits]

### Summary
[2-3 sentence overview: what's good about the changes, what needs attention]
```

Rules for the report:
- Lead with what's good. Acknowledge solid work before listing issues
- Every issue must have a concrete suggestion, not just criticism
- If there are no High issues, say so explicitly — that's a good sign
- Cap the report at 15 issues. If there are more, prioritize and note "additional minor items omitted"

### Step 5: Offer Next Steps

After presenting the review, offer:
- "Want me to fix any of these?" (for auto-fixable issues like naming, magic values)
- "Want me to focus on a specific file or area?"

## Notes

- This skill uses local git commands only. It does not interact with any git hosting platform
- The skill reviews code, not commits. It looks at the total diff, not individual commit messages
- For large diffs, suggest reviewing in chunks rather than skipping the review entirely
- If persona files (`shared/personas/architect.md`, `shared/personas/nitpicker.md`) are not found, use the focus areas listed in Step 2 as the review criteria
- If the user asks to focus on just one perspective ("review the architecture only"), run only that persona

## Examples

**User**: "code review"
**Action**: Diff current branch against main. Run Architect and Nitpicker reviews in parallel. Present merged findings sorted by priority.

**User**: "review my code against develop"
**Action**: Same flow, but diff against `develop` instead of `main`.

**User**: "review just the test files"
**Action**: Filter the diff to only `*.test.*` and `*.spec.*` files. Run both reviews on the filtered set. Nitpicker's TestNaming focus becomes especially relevant.

**User**: "review with focus on architecture"
**Action**: Run only the Architect perspective. Skip Nitpicker. Present findings focused on patterns, abstractions, and dependencies.
