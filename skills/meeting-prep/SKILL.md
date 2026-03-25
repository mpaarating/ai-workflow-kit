---
name: meeting-prep
description: Gather docs, previous notes, related tickets, and context for an upcoming meeting
---

# Meeting Prep

## Trigger Phrases

- "prep for [meeting]"
- "prepare for [meeting]"
- "meeting prep"
- "get ready for [meeting]"

## Inputs

The user provides a meeting name, topic, or attendee name. This can be:
- An exact meeting title: "prep for Sprint Retrospective"
- A person's name (implies their next 1:1): "prep for my meeting with Sarah"
- A topic: "prep for the API migration discussion"

## Workflow

### Step 1: Find the Meeting

Search `{{calendar}}` for upcoming events matching the user's input.

- Match by title, attendee name, or description keywords
- If multiple matches, show a numbered list and ask which one
- If no matches, ask the user to clarify the meeting name or date
- Extract from the matched event:
  - **Title**
  - **Date and time**
  - **Attendees** (names and roles if available)
  - **Description/agenda** (if present in the calendar event)
  - **Recurring?** (note if this is a recurring meeting — previous notes are more likely to exist)

### Step 2: Find Previous Meeting Notes

Search `{{notes}}` for notes from prior instances of this meeting.

- Search by meeting title, attendee names, and topic keywords
- Look for the most recent 2-3 instances
- Extract:
  - **Action items** from the last meeting (especially any assigned to the user)
  - **Open questions** or decisions that were deferred
  - **Topics that were tabled** for follow-up
- If no previous notes exist, note this and move on

### Step 3: Find Related Tickets

Search `{{tasks}}` for tickets related to the meeting topic.

- Use the meeting title, description keywords, and attendee names as search terms
- Filter to tickets that are:
  - Assigned to the user or attendees
  - Recently updated (last 2 weeks)
  - In active states (not closed/done)
- Extract ticket ID, title, status, and assignee for each match

### Step 4: Find Related Documents

Search `{{notes}}` more broadly for documents related to the meeting topic.

- Search by topic keywords, project names, or technical terms from the meeting description
- Look for: design docs, RFCs, decision records, relevant wiki pages
- Keep to the top 3-5 most relevant results

### Step 5: Compile the Brief

Assemble findings into a structured meeting brief:

```
## Meeting Brief: [Title]
**When**: [date/time]
**With**: [attendee list]

### Agenda
[From calendar event description, or "No agenda provided — consider adding one"]

### Open Items from Last Meeting
- [Action items, open questions, tabled topics]
- [Or "First meeting / no previous notes found"]

### Related Tickets
- [TICKET-123] Title — Status (Assignee)
- [Or "No related tickets found"]

### Related Docs
- [Doc title](link) — one-line summary
- [Or "No related docs found"]

### Suggested Talking Points
- [Generated from open action items, stale tickets, and gaps in the agenda]
```

### Step 6: Offer to Save

Ask the user: "Want me to add this brief to today's daily page?"

- If yes, append the brief to today's page in `{{notes}}` under a "Meeting Prep" section
- If no, the brief stays in the conversation

## Notes

- For 1:1 meetings, bias toward finding the other person's recent tickets and shared project context
- For recurring meetings, previous notes are the most valuable input — prioritize finding them
- Keep the brief scannable. The user will glance at this 5 minutes before the meeting, not study it
- If the calendar integration is not configured, ask the user to provide the meeting details manually and continue from Step 2

## Examples

**User**: "prep for my 1:1 with Sarah"
**Action**: Search calendar for meetings with "Sarah" or "1:1" in the next few days. Find previous 1:1 notes. Pull Sarah's recent tickets. Compile brief with open action items and talking points.

**User**: "meeting prep for Sprint Retrospective"
**Action**: Find the next Sprint Retrospective on the calendar. Search for previous retro notes. Pull recently completed tickets for the sprint. Suggest discussion topics based on what shipped and what carried over.

**User**: "get ready for the API migration discussion tomorrow"
**Action**: Find tomorrow's meeting about API migration. Search for any migration-related docs, RFCs, or design documents. Pull tickets tagged with migration work. Compile brief with technical context and open decisions.
