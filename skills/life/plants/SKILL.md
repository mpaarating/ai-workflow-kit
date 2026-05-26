---
name: plants
description: Track houseplants — watering schedule, status, and care needs. One skill, multiple modes (check, log, add, update).
---

# Plants

## Trigger Phrases

- "how are my plants" / "plant check"
- "water plants" / "watered [plant]"
- "new plant: [name]"
- "plant update" / "[plant] is [status]"

## Workflow

Pick the mode based on the trigger.

### Mode: status check ("how are my plants")

Read the plant database from {{notes}} (fallback: `~/.ai-workflow/plants.md`) and display:

```
| Plant       | Status     | Last Watered | Water Needs | Light  |
|-------------|------------|--------------|-------------|--------|
| Pothos      | Thriving   | Mar 17       | Weekly      | Low    |
| Fiddle Leaf | Struggling | Mar 10       | Biweekly    | Bright |
```

Flag plants overdue for watering based on schedule + last watered.

### Mode: log watering ("water plants" / "watered Pothos")

Update Last Watered to today for the named plant(s). If no plant named, ask: "Which plants did you water? Or all of them?" Confirm: `Logged: Watered Pothos, Snake Plant (Mar 19)`.

### Mode: add ("new plant: monstera")

Ask for (or infer) Water Needs (Weekly / Biweekly / Monthly), Light (Low / Medium / Bright / Any), Pet-friendly (Y/N). Status defaults to **New**, Last Watered to today. If the user gives just a name, look up common care defaults and confirm before saving.

```
Added: "Monstera" — Bright light, weekly water, not pet-friendly. Status: New
```

### Mode: status update ("fiddle leaf is struggling")

Valid statuses: **Thriving** / **Healthy** / **Struggling** / **New**. Update the record and confirm.

```
Updated: Fiddle Leaf → Struggling. Notes: yellowing leaves.
```

## Storage

{{notes}} as a database/table: Name, Status, Water Needs, Light Needs, Last Watered, Next Repot, Pet-Friendly. Fallback: a markdown table in `~/.ai-workflow/plants.md`.
