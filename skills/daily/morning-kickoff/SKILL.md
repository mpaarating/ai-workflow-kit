---
name: morning-kickoff
description: Create your daily page with calendar events, task priorities, and yesterday's carry-forwards
---

# Morning Kickoff

## Trigger Phrases

- "good morning"
- "morning"
- "start my day"
- "morning kickoff"
- "what's on today"
- "today's plan"

## Workflow

### Step 1: Check for Existing Daily Page

Search {{notes}} for a page titled with today's date (e.g., "2026-03-19" or "March 19, 2026").

- If a daily page already exists, tell the user and ask if they want to refresh it or skip.
- If no page exists, continue to Step 2.

### Step 2: Fetch Today's Calendar

Query {{calendar}} for all events happening today.

- Include: event title, start/end time, attendees, and any linked docs or agendas.
- Sort chronologically.
- Calculate total meeting hours by summing event durations (round to nearest 15 min).
- Calculate available deep work hours: `8h - meeting hours`.

### Step 3: Fetch Assigned Tasks

Query {{tasks}} for tasks assigned to the user with status "In Progress" or "To Do".

- Sort by priority (highest first), then by due date (soonest first).
- Include: task ID, title, status, and priority.
- Limit to 15 most relevant tasks.

### Step 4: Check Yesterday's Page

Read the most recent daily page before today from {{notes}}.

- Look for an "End-of-Day Recap" or "Carry Forward" section.
- Extract any items marked as carry-forwards, incomplete, or blocked.
- If no previous page exists, skip this step.

### Step 5: Suggest Top 3 Priorities

Analyze calendar density and task urgency to suggest the day's top 3 focus areas.

Rules:
- If meeting load is heavy (>4h), prioritize quick wins and meeting prep over deep work.
- If meeting load is light (<2h), prioritize the highest-impact deep work task.
- Always surface carry-forward items that have been deferred more than once.
- If a task is due today or overdue, it gets priority regardless of meeting load.

Present priorities as a numbered list with brief rationale for each.

### Step 6: Create the Daily Page

Create a new page in {{notes}} titled with today's date. Use this structure:

```
# [Today's Date]

## Focus Areas
1. [Priority 1] — [rationale]
2. [Priority 2] — [rationale]
3. [Priority 3] — [rationale]

Deep work available: [X]h ([Y]h in meetings)

## Schedule
- [time] — [event name] ([attendees])
- [time] — [event name] ([attendees])
- ...

## Carry-Forward
- [item from yesterday, if any]

## Working Notes
[empty — fill during the day]

## End-of-Day Recap
[empty — filled by eod-review]
```

### Step 7: Summarize

Print a brief summary to the user:
- Top 3 priorities
- Number of meetings and deep work hours available
- Any carry-forward items to watch

## Notes

- This skill pairs with **eod-review** (fills the recap section) and **checkin** (midday progress check).
- If {{calendar}} is not configured, skip schedule and assume 8h of deep work time.
- If {{tasks}} is not configured, skip task fetch and ask the user what they plan to work on.

## Examples

**User**: "good morning"

**Assistant**: Good morning! Let me set up your day.

You have 3 meetings today (2.5h), leaving about 5.5h of deep work time.

**Top 3 priorities:**
1. Finish auth migration (due today, carry-forward from yesterday)
2. Review PR #482 (Jordan requested review 2 days ago)
3. Prep for 1:1 with Taylor at 2pm

I've created your daily page with the full schedule and task list. Anything you want to adjust?
