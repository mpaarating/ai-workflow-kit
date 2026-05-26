---
name: standup
description: Draft and post an async standup from your current work context — in-progress tasks, recent completions, blockers. Supports a quick-mode one-liner.
---

# Async Standup

## Trigger Phrases

- "standup"
- "post update"
- "async update"
- "progress update"
- "team update"

## Workflow

1. **Gather work context** from {{tasks}}: in-progress items assigned to the user, plus recently completed (since the last standup, or last 2 days if no prior). Capture task ID, title, status. If {{tasks}} isn't configured, fall back to today's daily page in {{notes}}. If neither, ask directly.

2. **Collect updates per item.** For each in-progress item: one line of progress, one line of next step, blocker (yes/no + on whom).

   **Quick mode:** if the user provides everything inline ("standup: shipped auth migration, PR up for review, blocked on deploy access"), parse it directly and skip the interactive questions.

3. **Format the update:**

   ```
   **Done:**
   - [task title] ([task ID])

   **In Progress:**
   - [task title] ([task ID]) — [progress]. Next: [next step].

   **Blocked:**
   - [task title] ([task ID]) — blocked on [who/what]

   [optional: one-line availability note]
   ```

   Each bullet one line. Always include task IDs (they make updates searchable). Omit empty sections.

4. **Preview and confirm** before posting. Let the user edit, add, or remove items.

5. **Post to the team channel** in {{chat}}. If {{chat}} isn't configured, copy the formatted message to the clipboard. On first run, ask the user for the standup channel or thread convention and remember it.

6. **Confirm** where it was posted (or that it's on the clipboard).

## Notes

- Works best with **morning-kickoff** context, but runs standalone.
- Quick mode is the fast path: one-liner → formatted post in seconds.
- Don't over-format. Standups should be scannable, not essays.
- If the user says "standup" and nothing is in progress in {{tasks}}, ask directly rather than posting an empty update.
