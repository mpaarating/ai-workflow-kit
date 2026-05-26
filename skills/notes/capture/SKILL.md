---
name: capture
description: Lightweight append to today's daily page — free-form notes, chat threads, ticket references, document links. Always lands on today's page. For long-term routing use **save** instead.
---

# Capture

## Trigger Phrases

- "capture: [text]"
- "note: [text]"
- "remember: [text]"
- "jot down [text]"
- "capture this thread [url]"
- "link [TICKET-ID]"
- "capture doc [url]"

If the user says "save..." instead, route to the **save** skill.

## Workflow

1. **Find today's daily page** in {{notes}}. If none exists, create a minimal shell (today's date as the title, Working Notes section) — or suggest **morning-kickoff** for the full setup.

2. **Detect capture type** from the input:
   - Free-form text (`capture:`, `note:`, `remember:`, `jot down`) — use as-is
   - Chat thread URL — fetch title, participants, messages from {{chat}}
   - Ticket pattern (e.g., `ABC-123`) — fetch summary + status from {{tasks}}
   - Document URL — fetch title (and short description if available)

3. **Append to Working Notes.** If the page uses a different ad-hoc section (e.g., "Scratch"), append there — match the user's existing structure, don't impose a new one. Hyperlink ticket IDs and URLs.

   ```
   - [time] [free-form text]
   - [time] [TICKET-ID]: [title] — [status]
   - [time] Doc: [title]
   - [time] Thread in #[channel] with [participants]
     - [first message excerpt]
     - [follow-up excerpt]
   ```

4. **Confirm in one line.** Don't echo content back unless asked. If you created the page from scratch, say so and suggest **morning-kickoff** for the full setup.

## Notes

- Intentionally lightweight. Don't analyze, summarize, or restructure — just append.
- For deeper analysis or long-term storage (project pages, knowledge base), use **save** instead.
