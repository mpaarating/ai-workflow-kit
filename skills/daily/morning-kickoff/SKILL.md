---
name: morning-kickoff
description: Create today's daily page with calendar events, task priorities, and yesterday's carry-forwards. The first skill of the day.
---

# Morning Kickoff

## Trigger Phrases

- "good morning"
- "morning"
- "start my day"
- "morning kickoff"
- "what's on today"

## Workflow

1. **Check for existing page.** Search {{notes}} for a page titled with today's date. If one exists, ask whether to refresh or skip.

2. **Fetch today's calendar** from {{calendar}}. For each event capture title, start/end, attendees, linked docs. Sort chronologically. Compute meeting hours (rounded to nearest 15 min) and deep-work hours (`8h − meeting hours`).

3. **Fetch assigned tasks** from {{tasks}} with status "In Progress" or "To Do". Sort by priority then due date. Cap at 15.

4. **Read yesterday's page** from {{notes}}. Pull anything in End-of-Day Recap or Carry-Forward sections.

5. **Pick the top 3 focus areas** using these rules:
   - Meeting load > 4h → prioritize quick wins and meeting prep over deep work
   - Meeting load < 2h → prioritize the highest-impact deep work task
   - Any task due today or overdue → it gets a slot regardless of meeting load
   - Any carry-forward deferred 2+ times → surface it with a flag

6. **Create the daily page** in {{notes}}:

   ```
   # [Today's Date]

   ## Focus Areas
   1. [Priority 1] — [rationale]
   2. [Priority 2] — [rationale]
   3. [Priority 3] — [rationale]

   Deep work available: [X]h ([Y]h in meetings)

   ## Schedule
   - [time] — [event] ([attendees])

   ## Carry-Forward
   - [item from yesterday, if any]

   ## Working Notes

   ## End-of-Day Recap
   ```

7. **Summarize back**: top 3 priorities, meeting hours, deep work hours, anything carrying forward.

## Notes

- Pairs with **eod-review** (which fills End-of-Day Recap) and **checkin** (midday).
- If {{calendar}} isn't configured, skip schedule and assume 8h deep work.
- If {{tasks}} isn't configured, skip the fetch and ask the user what they plan to work on.
