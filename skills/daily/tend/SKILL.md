---
name: tend
description: Mid-afternoon page tending. Audits today's daily page for accuracy, checks off completed items, surfaces buried action items, flags stale carry-forwards. Best run 2–4pm.
---

# Page Tending

Gardening for the daily page. Audits state, identifies stale or resolved content, tidies up.

## Trigger Phrases

- "tend"
- "tidy page"
- "clean up page"
- "page health"
- "housekeeping"

## Workflow

1. **Read today's daily page** from {{notes}}. If no page exists → suggest **morning-kickoff** and stop. If the page is fresh with no Working Notes → say "Page is still fresh, check back after lunch" and stop.

2. **Audit in parallel:**

   - **Focus area reconciliation** — for each focus area, look in Working Notes and {{tasks}} for evidence. Categorize as Done / In Progress / Not Started / Dropped (explicit pivot).
   - **Section health** — flag empty stubs that should have content by now, resolved items still showing as pending, and buried action items ("need to", "should", "TODO", "follow up", unchecked items).
   - **Task status sync** — for any task IDs on the page, compare {{tasks}} current status to what the page says. Flag mismatches.
   - **Carry-forward staleness** — items deferred 3+ days need a decision (timebox, drop, or escalate).

3. **Present the tending report:**

   ```
   ## Page Tending — [time]

   ### Focus Areas
   - Done: [item] — [evidence]
   - In Progress: [item]
   - Not Started: [item]
   - Dropped: [item] — [pivot detected]

   ### Needs Decision
   - [carry-forward] — Day [N], no progress. Timebox, drop, or escalate?

   ### Buried Action Items
   - From [section]: [action]

   ### Drift
   - [task]: page says "[status]", {{tasks}} says "[status]"
   - [meeting]: happened [N]h ago, notes not captured
   ```

4. **Offer actions** as a numbered list — apply only what the user confirms:
   1. Check off completed focus areas based on evidence
   2. Annotate stale carry-forwards with `[Day N — needs decision]`
   3. Add a "Needs Attention" cluster to Working Notes
   4. Flag items for EOD review
   5. Suggest follow-up skills (e.g., **capture** for missing meeting notes, **checkin** if no midday status)

5. **Append a tending summary** to Working Notes once actions are confirmed:

   ```
   ### Page Tending — [time]
   - Focus areas: [N] done, [N] in progress, [N] not started, [N] dropped
   - Actions taken: [list of updates applied]
   - Flagged for EOD: [items to surface tonight]
   - Stale items: [decisions still needed]
   ```

## Notes

- **Audits and tidies.** Does not generate new content — that's what **capture**, **checkin**, and **morning-kickoff** are for.
- Some {{notes}} backends (e.g., Notion) can't reorder or delete blocks via API. Tend works by annotating and appending, not restructuring. Be transparent if asked.
- Pairs with **checkin** (which can suggest tend if the page looks messy) and **eod-review** (which uses flagged items).
- The "3+ days" threshold is a default — anything carried that long without progress usually needs a decision, not another attempt.
