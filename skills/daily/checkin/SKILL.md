---
name: checkin
description: Midday progress check — compare morning plan to actual work, surface pivots, refocus the afternoon
---

# Midday Check-in

## Trigger Phrases

- "checkin"
- "midday checkin"
- "midday check-in"
- "afternoon checkin"
- "how's my day going"

## Workflow

### Step 1: Read Today's Daily Page

Fetch today's daily page from {{notes}}.

- If no daily page exists, tell the user and offer to run **morning-kickoff** first.
- Extract the Focus Areas section (the morning plan).
- Read any Working Notes added during the morning.

### Step 2: Assess Progress on Focus Areas

For each item in the morning Focus Areas, determine status:

- **Done**: Completed since the morning.
- **In Progress**: Actively being worked on.
- **Not Started**: Hasn't been touched yet.

Present as a checklist so the user can quickly confirm or correct.

### Step 3: Detect Pivots

Compare the morning plan to the Working Notes content and ask the user what they've actually been doing.

If work doesn't align with morning priorities, flag it neutrally:

> "Looks like you spent the morning on [X] instead of [planned item]. Intentional pivot or got pulled in?"

Pivots aren't bad — they just need to be acknowledged so the afternoon can be re-planned.

### Step 4: Show Remaining Schedule

Query {{calendar}} for events in the remainder of today.

- List upcoming meetings with times.
- Calculate remaining deep work hours: time left in the workday minus remaining meeting time.

If {{calendar}} is not configured, ask the user how many meetings they have left.

### Step 5: Collect Reflection

Ask the user for a brief midday reflection. Prompt with one of these:

- "How's your energy? Anything you want to adjust for the afternoon?"
- "What's the one thing you want to make sure gets done before EOD?"
- "Anything blocking you right now?"

Keep it lightweight — one or two sentences is fine.

### Step 6: Update the Daily Page

Add a timestamped midday note to the Working Notes section of today's page in {{notes}}.

Format:

```
### Midday Check-in ([time])
**Progress:**
- [x] [Focus item 1] — done
- [ ] [Focus item 2] — in progress
- [ ] [Focus item 3] — not started

**Pivot:** [description, if any]

**Afternoon plan:** [adjusted priorities based on remaining time]

**Note:** [user's reflection]
```

### Step 7: Summarize

Print a brief summary:
- Progress snapshot (e.g., "1 of 3 focus items done")
- Remaining deep work hours
- Adjusted top priority for the afternoon

## Notes

- This skill reads the page created by **morning-kickoff** and adds to it.
- Keep the check-in fast — it should take under 2 minutes.
- Don't judge pivots. The goal is awareness, not guilt.
- If {{calendar}} is not configured, skip schedule lookup and just ask about remaining time.

## Examples

**User**: "checkin"

**Assistant**: Here's where you're at:

**Morning focus areas:**
- [x] Auth migration — done (nice!)
- [ ] PR #482 review — in progress (comments posted, waiting on response)
- [ ] 1:1 prep — not started

You have 2 meetings this afternoon (1.5h), leaving about 2.5h of deep work.

What's the top priority for this afternoon — finishing the PR review or prepping for the 1:1?

**User**: "PR review, the 1:1 got moved"

**Assistant**: Got it. I've added a midday note to your daily page with the updated plan. The 1:1 prep moves to tomorrow's carry-forward.
