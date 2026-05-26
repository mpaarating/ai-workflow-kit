---
name: checkin
description: Midday progress check — compares morning plan to actual work, surfaces pivots, refocuses the afternoon. Should take under 2 minutes.
---

# Midday Check-in

## Trigger Phrases

- "checkin"
- "midday checkin"
- "afternoon checkin"
- "how's my day going"

## Workflow

1. **Read today's daily page** from {{notes}}. Pull Focus Areas and any Working Notes added during the morning. If no page exists, suggest **morning-kickoff** first.

2. **Assess progress** on each focus area: Done / In Progress / Not Started. Present as a checklist for the user to confirm or correct.

3. **Detect pivots.** If work in Working Notes doesn't align with morning priorities, flag it neutrally — pivots aren't bad, but they need to be visible so the afternoon can be re-planned. Example phrasing:

   > "Looks like you spent the morning on [X] instead of [planned item]. Intentional pivot or got pulled in?"

4. **Show what's left.** Query {{calendar}} for remaining events. Compute remaining deep work hours (time left in the workday − remaining meeting time). If {{calendar}} isn't configured, ask how many meetings are left.

5. **Collect a one-sentence reflection** with a lightweight prompt: "Energy?" / "One thing you want done before EOD?" / "Anything blocking you?"

6. **Append a midday note** to Working Notes:

   ```
   ### Midday Check-in ([time])
   **Progress:**
   - [x] [Focus item 1] — done
   - [ ] [Focus item 2] — in progress
   - [ ] [Focus item 3] — not started

   **Pivot:** [description, if any]
   **Afternoon plan:** [adjusted priorities]
   **Note:** [user's reflection]
   ```

7. **Summarize**: progress snapshot ("1 of 3 done"), remaining deep work hours, the one thing for the afternoon. If the page looks messy or stale, suggest **tend**.

## Notes

- Reads what **morning-kickoff** wrote; appends to the same page.
- Don't judge pivots. The goal is awareness, not guilt.
