---
name: journal
description: Quick journal entries with mood detection, tagged and linked to your daily page. The confirmation is a nod, not a conversation.
---

# Journal

## Trigger Phrases

- "journal: [text]"
- "reflect: [text]"
- "today I [...]"
- "feeling [emotion]"
- "grateful for [...]"
- "on my mind:"

## Workflow

1. **Parse the entry.** Strip the trigger prefix. Preserve the user's exact words — never rewrite, summarize, or polish. If the entry is empty (e.g. just `journal:`), ask "What's on your mind?"

2. **Detect mood** silently. One primary mood per entry. Default to Neutral when ambiguous. Don't ask the user to confirm.

   | Mood | Signals |
   |------|---------|
   | Energized | excitement, momentum, breakthrough, shipped, crushed it |
   | Focused | deep work, flow state, locked in, making progress |
   | Neutral | status updates, factual observations |
   | Overwhelmed | too much, scattered, drowning, behind |
   | Tired | drained, exhausted, low energy, long day |
   | Frustrated | stuck, blocked, broken, doesn't work, ugh |
   | Grateful | thankful, appreciate, lucky, helped by |

3. **Detect 1–3 tags** based on content: `Work`, `Personal`, `Reflection`, `Gratitude`, `Learning`.

4. **Write the entry** to {{notes}}. If today's daily page exists, link a one-line reference under a Journal section there (mood + first line). If not, write the entry standalone — do not create a daily page just for journaling.

   ```
   Date: [today]
   Mood: [detected]
   Tags: [detected]

   [user's words, verbatim]
   ```

5. **Confirm in one line.** Tone is a nod, not a conversation.

   ```
   Logged — [Mood], [Tags]. [brief acknowledgment]
   ```

   Examples: "Logged — Energized, Work + Learning. Good solve." / "Logged — Overwhelmed, Work. Full plate today." / "Logged — Grateful, Work. Noted."

   Don't offer advice, ask follow-ups (unless empty), restate the entry, or add motivational commentary.

## Notes

- Journal entries are private by default. Never post them to {{chat}} or any shared space.
- Multiple sentences in one entry stay as one entry — don't split.
- Mood detection is convenience, not judgment. Keep it neutral.
- If {{notes}} isn't configured, fall back to `~/.ai-workflow/journal/[date].md`.
