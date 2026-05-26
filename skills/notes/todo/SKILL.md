---
name: todo
description: Quick task capture with priority detection, due-date parsing, and batch support. One task or many.
---

# Todo

## Trigger Phrases

- "todo: [text]"
- "remind me to [...]"
- "need to [...]"
- "don't forget to [...]"
- "add task: [text]"

## Workflow

1. **Parse input.** Single or batch. Split on commas or newlines when multiple tasks are present:
   - `todo: buy groceries` → one task
   - `todo: buy groceries, call dentist, review PR` → three tasks

2. **Detect priority** per task. Strip the priority keyword from the task text after detection.

   | Signal | Priority |
   |--------|----------|
   | "urgent", "asap", "critical", "today" | High |
   | "soon", "this week", "important" | Medium |
   | Everything else | Low |

3. **Detect due date.** Explicit ("by Friday", "due March 20") or relative ("tomorrow", "next Monday") — resolve to an absolute date. If no date, leave blank.

4. **Save to {{tasks}}** with fields: Task, Priority, Due Date, Status (default: Open). If {{tasks}} isn't configured, append to `~/.ai-workflow/todos.md`:

   ```
   - [ ] Buy groceries | Priority: Low | Due: —
   - [ ] Call dentist | Priority: Medium | Due: 2026-03-21
   ```

5. **Confirm one line per task.** No extra commentary.

   ```
   Added: "Buy groceries" (low)
   Added: "Call dentist" (medium, due Fri Mar 21)
   ```
