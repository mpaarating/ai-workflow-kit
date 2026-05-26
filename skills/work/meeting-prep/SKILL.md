---
name: meeting-prep
description: Gather docs, previous notes, related tickets, and context for an upcoming meeting. Produces a scannable brief you can glance at 5 minutes before.
---

# Meeting Prep

## Trigger Phrases

- "prep for [meeting]"
- "prepare for [meeting]"
- "meeting prep"
- "get ready for [meeting]"

The argument can be a meeting title, an attendee name (implies their next 1:1), or a topic.

## Workflow

1. **Find the meeting** in {{calendar}}. Match by title, attendee, or description keywords. If multiple, show a numbered list. If none, ask to clarify. Extract title, time, attendees (with roles if available), agenda/description, and whether it's recurring (recurring meetings usually have prior notes).

2. **Find previous notes** in {{notes}} for prior instances. Search by title, attendees, and topic keywords. Take the most recent 2–3. From each, extract: action items (especially the user's), open questions, tabled topics.

3. **Find related tickets** in {{tasks}}. Search by title, description keywords, attendee names. Filter to: assigned to user or attendees, recently updated (last 2 weeks), still open. Capture ticket ID, title, status, assignee.

4. **Find related docs** in {{notes}} more broadly — design docs, RFCs, decision records, wiki pages tied to the topic. Keep the top 3–5.

5. **Compile the brief:**

   ```
   ## Meeting Brief: [Title]
   **When**: [date/time]
   **With**: [attendees]

   ### Agenda
   [From calendar, or "No agenda provided — consider adding one"]

   ### Open Items from Last Meeting
   - [action items, open questions, tabled topics]

   ### Related Tickets
   - [TICKET-123] Title — Status (Assignee)

   ### Related Docs
   - [Doc title](link) — one-line summary

   ### Suggested Talking Points
   - [Generated from open actions, stale tickets, and gaps in the agenda]
   ```

6. **Offer to save** the brief to today's daily page under a Meeting Prep section.

## Notes

- For 1:1s, bias toward the other person's recent tickets and shared context.
- For recurring meetings, prior notes are the most valuable input — prioritize finding them.
- Keep the brief scannable. The user will glance at this 5 minutes before, not study it.
- If {{calendar}} isn't configured, ask the user for the meeting details and proceed from step 2.
