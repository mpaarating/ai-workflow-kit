---
name: journal
description: Quick journal entries with mood detection, tagged and linked to your daily page
---

# Journal

## Trigger Phrases

- "journal:"
- "reflect:"
- "today I"
- "feeling [emotion]"
- "grateful for"
- "on my mind:"

## Inputs

The user provides a journal entry inline with the trigger phrase. The entry can be:
- A sentence or two: "journal: Had a breakthrough on the caching layer today"
- A mood expression: "feeling overwhelmed — too many threads open"
- A gratitude note: "grateful for Sarah's help debugging that race condition"
- A reflection: "reflect: I notice I default to building instead of asking for help"

## Workflow

### Step 1: Parse the Entry

Extract the journal content from the user's message.

- Strip the trigger prefix ("journal:", "reflect:", etc.)
- Preserve the user's exact words — do not rewrite, summarize, or polish
- If the entry is just a trigger phrase with no content (e.g., "journal:"), ask: "What's on your mind?"

### Step 2: Detect Mood

Analyze the entry for mood signals. Assign one primary mood:

| Mood | Signals |
|------|---------|
| Energized | excitement, momentum, breakthrough, shipped, crushed it |
| Focused | deep work, flow state, locked in, making progress |
| Neutral | status updates, factual observations, no strong emotion |
| Overwhelmed | too much, scattered, can't focus, drowning, behind |
| Tired | drained, exhausted, low energy, long day, need a break |
| Frustrated | stuck, blocked, annoyed, broken, doesn't work, ugh |
| Grateful | thankful, grateful, appreciate, lucky, helped by |

- If mood is ambiguous, default to Neutral
- Do not ask the user to confirm the mood — just detect it quietly

### Step 3: Detect Tags

Assign 1-3 tags based on content:

| Tag | Signals |
|-----|---------|
| Work | code, meeting, ticket, PR, deploy, team, project |
| Personal | family, health, hobby, weekend, home, friends |
| Reflection | I notice, pattern, thinking about, wondering, realized |
| Gratitude | grateful, thankful, appreciate, helped by |
| Learning | learned, TIL, figured out, discovery, insight |

### Step 4: Check for Today's Daily Page

Search `{{notes}}` for today's daily page.

- If it exists, the journal entry will be linked to it
- If it doesn't exist, create the entry standalone (don't create a daily page just for a journal entry)

### Step 5: Create the Journal Entry

Write the entry to `{{notes}}` with this structure:

```
Date: [today's date]
Mood: [detected mood]
Tags: [detected tags]

[User's journal entry, exactly as written]
```

- If today's daily page exists, also add a brief reference to the journal entry in the daily page under a "Journal" section
- Keep the reference minimal: just the mood and first line of the entry

### Step 6: Confirm

Respond with a single line confirming the save:

```
Logged — [Mood] [Tags]. [brief acknowledgment]
```

Examples of confirmations:
- "Logged — Energized, Work. Nice breakthrough."
- "Logged — Overwhelmed, Work. That's a lot of threads."
- "Logged — Grateful, Personal. Noted."

Do NOT:
- Offer advice or coaching
- Ask follow-up questions (unless entry was empty)
- Restate the journal entry back to the user
- Add motivational commentary

The confirmation should feel like a nod, not a conversation.

## Notes

- Journal entries are private by default. Never post them to `{{chat}}` or any shared space
- If the user writes multiple sentences, keep them as one entry — don't split into separate entries
- Mood detection is a convenience, not a judgment. Keep it neutral in tone
- If the `{{notes}}` integration is not configured, fall back to writing a local markdown file at `~/.ai-workflow/journal/[date].md`

## Examples

**User**: "journal: Had a breakthrough on the caching layer. The problem was stale invalidation keys — once I switched to content-based hashing, everything clicked."
**Mood**: Energized
**Tags**: Work, Learning
**Response**: "Logged — Energized, Work + Learning. Good solve."

**User**: "feeling overwhelmed — three PRs in review, two meetings back to back, and a production alert I haven't triaged yet"
**Mood**: Overwhelmed
**Tags**: Work
**Response**: "Logged — Overwhelmed, Work. Full plate today."

**User**: "grateful for Jordan pairing with me on that flaky test. Would've taken me hours solo."
**Mood**: Grateful
**Tags**: Gratitude, Work
**Response**: "Logged — Grateful, Work. Noted."

**User**: "reflect: I keep volunteering for tasks outside my sprint scope. Need to get better at saying 'not this sprint' without guilt."
**Mood**: Neutral
**Tags**: Reflection, Work
**Response**: "Logged — Reflection, Work."
