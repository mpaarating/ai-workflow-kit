---
name: todo
description: Quick task capture with priority detection and batch support
---

# Todo

Capture tasks fast. One task or many, with smart priority and due date detection.

## Trigger Phrases

- "todo:"
- "remind me to"
- "need to"
- "don't forget to"
- "add task:"

## Workflow

### Step 1: Parse Input

Extract task(s) from the user's message. Handle both single and batch input.

- **Single**: `todo: buy groceries` → one task
- **Batch**: `todo: buy groceries, call dentist, review PR` → three tasks
- Split on commas or newlines when multiple tasks are present

### Step 2: Detect Priority

Scan each task for priority signals:

| Signal | Priority |
|--------|----------|
| "urgent", "asap", "critical", "today" | High |
| "soon", "this week", "important" | Medium |
| Everything else | Low |

Strip priority keywords from the task text after detection.

### Step 3: Detect Due Date

Look for date references:

- Explicit: "by Friday", "due March 20", "before 5pm"
- Relative: "today", "tomorrow", "this week", "next Monday"
- Convert to an actual date based on the current date
- If no date found, leave blank

### Step 4: Save

Add task(s) to the user's task system.

**Using {{notes}}**: Create or append to a tasks page/database with fields: Task, Priority, Due Date, Status (default: Open).

**Markdown fallback**: Append to `~/.ai-workflow/todos.md`:

```markdown
- [ ] Buy groceries | Priority: Low | Due: —
- [ ] Call dentist | Priority: Medium | Due: 2026-03-21
```

### Step 5: Confirm

Respond with a single confirmation line per task:

```
Added: "Buy groceries" (low)
Added: "Call dentist" (medium, due Fri Mar 21)
Added: "Review PR" (low)
```

Keep it to one line per task. No extra commentary.

## Examples

**Single task:**
> todo: schedule haircut

```
Added: "Schedule haircut" (low)
```

**With priority signal:**
> remind me to file taxes asap

```
Added: "File taxes" (high)
```

**Batch:**
> todo: buy groceries, call dentist by Friday, review PR

```
Added: "Buy groceries" (low)
Added: "Call dentist" (medium, due Fri Mar 21)
Added: "Review PR" (low)
```

**With due date:**
> don't forget to renew passport by next month

```
Added: "Renew passport" (low, due Apr 19)
```
