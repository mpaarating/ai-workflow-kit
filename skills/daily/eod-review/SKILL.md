---
name: eod-review
description: Review your day, compare plan to outcomes, identify carry-forwards, and prep tomorrow
---

# End-of-Day Review

## Trigger Phrases

- "eod review"
- "end of day"
- "wrapping up"
- "done for today"
- "signing off"
- "goodnight"

## Workflow

### Step 1: Read Today's Daily Page

Fetch today's daily page from {{notes}}.

- If no daily page exists, tell the user and offer to create a quick recap from scratch instead.
- Extract the Focus Areas section (the morning plan) for comparison.
- Extract the Working Notes section for context on what actually happened.

### Step 2: Gather Task Activity

Query {{tasks}} for tasks that changed status today (completed, moved to in-progress, or newly created).

- Include: task ID, title, old status, new status.
- This gives an objective view of what moved, independent of what the user wrote down.

### Step 3: Compare Plan to Outcomes

For each item in the morning Focus Areas:
- Mark as: **Done**, **In Progress**, or **Not Started**.
- If the user worked on things not in the morning plan, note those as **Unplanned Work**.

Present this as a simple table or checklist so the user can confirm or correct.

### Step 4: Categorize the Day

Organize the day's work into four categories:

- **Shipped**: Work that is complete and delivered (merged PRs, closed tickets, sent deliverables).
- **Moved Forward**: Work that progressed but isn't done yet (open PRs, in-progress tickets, drafts).
- **Blocked**: Work that couldn't progress and needs something from someone else.
- **Carry Forward**: Items to pick up tomorrow, with brief context on where they left off.

Ask the user to confirm or add anything missing from each category.

### Step 5: Draft the Recap

Write a concise end-of-day recap. Format:

```
## End-of-Day Recap

### Shipped
- [item] ([task ID if applicable])

### Moved Forward
- [item] — [current state / next step]

### Blocked
- [item] — blocked on [who/what]

### Tomorrow
- [carry-forward item 1]
- [carry-forward item 2]
- [any new priority for tomorrow]
```

### Step 6: Update the Daily Page

Write the recap into the "End-of-Day Recap" section of today's daily page in {{notes}}.

- Do not overwrite existing content in other sections.
- If the Carry-Forward section has items, merge them into the Tomorrow list (avoid duplicates).

### Step 7: Update Task Statuses (Optional)

If the user confirmed that tasks were completed or blocked, offer to update their statuses in {{tasks}}.

- Only update statuses the user explicitly confirmed.
- Don't auto-close anything without confirmation.

### Step 8: Closing Summary

Print a brief summary:
- Count of items shipped vs. carried forward
- Any blockers that need attention tomorrow morning
- A one-line note if the day had significant unplanned work (useful for spotting patterns over time)

## Notes

- This skill fills in the "End-of-Day Recap" section created by **morning-kickoff**.
- Carry-forward items are picked up by tomorrow's **morning-kickoff** run.
- If {{tasks}} is not configured, skip task activity gathering and rely on the user's input.
- Keep the recap concise. Bullet points, not paragraphs.

## Examples

**User**: "wrapping up"

**Assistant**: Let me review your day.

**Morning plan vs. actual:**
- Auth migration: **Done** (PR merged)
- PR #482 review: **Done**
- 1:1 prep with Taylor: **Not Started** (meeting got cancelled)

**Unplanned work:**
- Hotfix for login timeout bug (2h)

Here's the recap I'll add to your daily page:

**Shipped:** Auth migration (ENG-312), PR #482 review
**Moved Forward:** Login timeout hotfix (PR open, needs review)
**Blocked:** Nothing
**Tomorrow:** Taylor 1:1 prep (rescheduled to Thursday), continue hotfix review

Want me to update ENG-312 to Done in your task tracker?
