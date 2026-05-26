---
name: top-priority
description: Read-only "what should I work on right now?" Reads today's daily page, cross-references time and progress, and surfaces a single recommendation. Fast, no side effects.
---

# Top Priority

## Trigger Phrases

- "what's next"
- "what should I do"
- "top priority"
- "what now"
- "what should I focus on"

## Workflow

1. **Read today's daily page** from {{notes}}. Pull Focus Areas, Working Notes, Schedule, Carry-Forward. Note current time. If no page exists, suggest **morning-kickoff**. If the page is an empty shell, suggest **morning-kickoff** to populate.

2. **Apply the decision rules in order.** First match wins — stop at the first rule that fires.

   1. **Imminent meeting** — a meeting starts in under 30 minutes → "[Meeting] in [X] min — review prep notes."
   2. **Blocker on someone else** — Working Notes mention someone waiting on the user → "Unblock [person]: [item] — quick response frees them up."
   3. **Highest unfinished focus area** — first focus item not marked done in Working Notes → "Focus: [area] — [rationale from morning plan]."
   4. **Stale carry-forward** — an item deferred 2+ days → "Decide: [item] has been carried [N] days. Timebox, drop, or escalate."
   5. **Deep work fallback** — all focus areas done, nothing blocking → "All clear — good window for deep work. Consider: [first carry-forward or backlog item]."

3. **Add one line of temporal context** after the recommendation: time until next meeting, or "no more meetings today". If the recommended item has appeared on the page multiple days, add "Day N on this — consider timeboxing."

4. **Output**, ultra-concise:

   ```
   ## Right Now

   [Primary recommendation — one sentence, action-oriented]

   [temporal context — one line]
   ```

   No lists, no summary, no history. Just the answer.

## Notes

- **Read-only.** Does not modify the daily page.
- Designed to be cheap to invoke — no sub-agents, minimal tool calls.
- Pairs well with: after a meeting, between tasks, after a Slack check.
- If the page is missing morning-kickoff content, fall back to {{tasks}} (highest-priority open task) and {{calendar}} (next meeting).
