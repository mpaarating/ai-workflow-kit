---
name: standup
description: Draft and post async standup updates from your current work context
---

# Async Standup

## Trigger Phrases

- "standup"
- "post update"
- "async update"
- "progress update"
- "team update"

## Workflow

### Step 1: Gather Work Context

Query {{tasks}} for the user's in-progress and recently completed items.

- **In Progress**: Tasks with "In Progress" or equivalent status, assigned to the user.
- **Recently Completed**: Tasks completed since the last standup (or in the last 2 days if no prior standup is found).
- Include: task ID, title, status.

If {{tasks}} is not configured, check today's daily page in {{notes}} for context instead. If neither is available, ask the user what they're working on.

### Step 2: Collect Updates Per Item

For each in-progress item, ask the user:

1. **Progress**: What did you do on this? (one line)
2. **Next**: What's the next step? (one line)
3. **Blocked?**: Anything blocking progress? (yes/no, and on whom if yes)

For recently completed items, just note them as done.

**Quick mode**: If the user provides all context inline (e.g., "standup: finished auth migration, working on PR review, blocked on deploy access"), parse it directly and skip the interactive questions.

### Step 3: Format the Update

Draft the standup message using this structure:

```
**Done:**
- [task title] ([task ID])
- [task title] ([task ID])

**In Progress:**
- [task title] ([task ID]) — [progress note]. Next: [next step].

**Blocked:**
- [task title] ([task ID]) — blocked on [who/what]

[optional: one-line note about priorities or availability]
```

Rules:
- Keep each bullet to one line.
- Always include task IDs when available — they make updates searchable.
- If nothing is blocked, omit the Blocked section entirely.
- If the user mentions availability changes (OOO, half-day, meetings), add a brief note at the end.

### Step 4: Preview and Confirm

Show the formatted message to the user and ask for confirmation before posting.

- Let them edit, add, or remove items.
- Don't post until they say it's good.

### Step 5: Post to Team Channel

Post the confirmed message to the team channel in {{chat}}.

- If {{chat}} is not configured, copy the formatted message to the clipboard and tell the user it's ready to paste.
- If the team has a specific standup channel or thread convention, ask the user on first run and remember the preference.

### Step 6: Confirm

Tell the user the update was posted (or copied to clipboard) and where.

## Notes

- This skill works best when **morning-kickoff** or daily page context exists, but it also works standalone.
- Quick mode is the fast path: the user gives a one-liner and gets a formatted post in seconds.
- Don't over-format. Standup updates should be scannable, not essays.
- If the user says "standup" and there's nothing in-progress in {{tasks}}, ask them directly rather than posting an empty update.

## Examples

**Standard flow:**

**User**: "standup"

**Assistant**: I see 3 items in your task tracker:

- **ENG-312**: Auth migration (In Progress)
- **ENG-318**: Login timeout fix (In Progress)
- **ENG-301**: Dashboard redesign (To Do)

Quick progress update on each?

**User**: "312 is done, 318 has an open PR needs review, not starting 301 yet"

**Assistant**: Here's your standup:

> **Done:**
> - Auth migration (ENG-312)
>
> **In Progress:**
> - Login timeout fix (ENG-318) — PR open, needs review

Post to #team-standup?

---

**Quick mode:**

**User**: "standup: shipped auth migration, login timeout PR up for review, blocked on deploy access from infra"

**Assistant**: Here's your standup:

> **Done:**
> - Auth migration
>
> **In Progress:**
> - Login timeout fix — PR up for review
>
> **Blocked:**
> - Deploy access — waiting on infra team

Post to your team channel?
