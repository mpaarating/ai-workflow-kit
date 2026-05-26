---
name: eod-review
description: Review your day, compare plan to outcomes, identify carry-forwards, prep tomorrow. Writes the End-of-Day Recap section of today's daily page.
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

1. **Read today's daily page** from {{notes}}. Pull Focus Areas (the morning plan) and Working Notes (what actually happened). If no page exists, offer to create a quick recap from scratch.

2. **Gather objective signal** from {{tasks}}: any task that changed status today (completed, moved to in-progress, newly created). This catches what got done that the user didn't write down.

3. **Compare plan to outcomes.** For each focus area: Done / In Progress / Not Started. Note any Unplanned Work the user took on. Present as a checklist for the user to confirm or correct.

4. **Categorize the day's work** into four buckets:
   - **Shipped** — complete and delivered (merged PRs, closed tickets, sent deliverables)
   - **Moved Forward** — progressed but not done (open PRs, in-progress tickets, drafts)
   - **Blocked** — couldn't progress; needs something from someone else
   - **Carry Forward** — pick up tomorrow, with brief context on where it left off

5. **Write the recap** into the End-of-Day Recap section of today's page (don't overwrite other sections):

   ```
   ## End-of-Day Recap

   ### Shipped
   - [item] ([task ID if applicable])

   ### Moved Forward
   - [item] — [current state / next step]

   ### Blocked
   - [item] — blocked on [who/what]

   ### Tomorrow
   - [carry-forward 1]
   - [carry-forward 2]
   - [any new priority for tomorrow]
   ```

   If the page already has a Carry-Forward section, merge — don't duplicate.

6. **Offer to update task statuses** in {{tasks}} for anything the user explicitly confirmed as done or blocked. Don't auto-close anything.

7. **Closing summary**: count shipped vs carried forward, surface any blocker that needs attention tomorrow, note significant unplanned work (useful pattern over time).

## Notes

- Pairs with **morning-kickoff** (creates the recap section) and **tend** (which flags items for EOD during the afternoon).
- Carry-forward items become input for tomorrow's morning-kickoff.
- If {{tasks}} isn't configured, skip objective signal gathering and rely on user input.
- Recap is bullet points, not paragraphs. Keep it scannable.
