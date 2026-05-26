---
name: plants
description: Track houseplants — watering, status, and care needs
---

# Plants

Keep your houseplants alive. Track watering, status, and care needs in one place.

## Trigger Phrases

- "water plants"
- "plant update"
- "plant check"
- "how are my plants"
- "new plant: [name]"

## Workflow

### On "plant check" / "how are my plants"

Read the plant database and display a status table:

```
| Plant          | Status     | Last Watered | Water Needs | Light   |
|----------------|------------|--------------|-------------|---------|
| Pothos         | Thriving   | Mar 17       | Weekly      | Low     |
| Fiddle Leaf    | Struggling | Mar 10       | Biweekly    | Bright  |
| Snake Plant    | Healthy    | Mar 15       | Monthly     | Any     |
```

Flag any plants that are overdue for watering based on their schedule and last watered date.

### On "water plants" / "watered [plant]"

Update the "Last Watered" date for the specified plant(s) to today.

- If no specific plant named, ask: "Which plants did you water? Or all of them?"
- If "all", update every plant
- Confirm: `Logged: Watered Pothos, Snake Plant (Mar 19)`

### On "new plant: [name]"

Add a new plant to the database. Ask for (or infer from the plant name):

- **Water needs**: Weekly, Biweekly, Monthly
- **Light needs**: Low, Medium, Bright, Any
- **Pet-friendly**: Yes/No

Set initial status to "New" and last watered to today.

If the user provides just a name, look up common care requirements for that plant species and suggest defaults. Confirm before saving.

```
Added: "Monstera" — Bright light, weekly water, not pet-friendly. Status: New
```

### On "plant update" / status change

Update a plant's status. Valid statuses:

- **Thriving** — Growing well, new leaves
- **Healthy** — Normal, no concerns
- **Struggling** — Yellowing, drooping, pests
- **New** — Recently acquired

Ask what changed if not specified. Update the record and confirm.

### Storage

**Using {{notes}}**: Store as a database/table with columns: Name, Status, Water Needs, Light Needs, Last Watered, Next Repot, Pet-Friendly.

**Markdown fallback**: Store in `~/.ai-workflow/plants.md` as a markdown table.

## Examples

**Check status:**
> how are my plants

Displays the status table. Flags: "Fiddle Leaf is 9 days overdue for watering (biweekly schedule)."

**Log watering:**
> watered the pothos and snake plant

```
Logged: Watered Pothos, Snake Plant (Mar 19)
```

**Add new plant:**
> new plant: monstera

```
Monstera — common care: bright indirect light, water weekly, not pet-friendly.
Sound right? (yes / adjust)
```

**Update status:**
> fiddle leaf is looking rough, yellowing leaves

```
Updated: Fiddle Leaf → Struggling. Notes: yellowing leaves.
```
