# AI Workflow Kit

A collection of agent skills that automate the non-coding parts of an engineer's day. Skills are organized into buckets and consumed by any agent that supports the Agent Skills spec (Claude Code, Codex CLI, Cursor, VS Code Copilot).

## Language

**Daily page:**
A single note in `{{notes}}` titled with today's date. Created by `/morning-kickoff`. Holds the day's focus areas, schedule, working notes, and end-of-day recap. Multiple skills read from and append to it.
_Avoid_: today's note, daily doc, daily log

**Focus areas:**
The 3 priorities chosen by `/morning-kickoff` and reconciled by `/tend` and `/eod-review`. Lives in the Focus Areas section of the daily page.
_Avoid_: priorities, top 3, goals (too generic)

**Working notes:**
The append-only section of the daily page where in-flight context lives. Skills like `/capture`, `/checkin`, and `/tend` add timestamped entries here.

**Carry-forward:**
An item from yesterday's daily page that didn't get done. Surfaced by `/morning-kickoff` and tracked by `/eod-review`.

**Integration layer:**
The `{{notes}} / {{tasks}} / {{calendar}} / {{chat}}` placeholders that skills reference instead of specific services. The active mapping is configured in `integrations/active.md`.
_Avoid_: backend, connector, provider

**Capture vs. save:**
`/capture` appends to today's daily page (fast, time-sensitive). `/save` routes content to the right long-term destination (project page, knowledge base, reference doc) and always asks where.

## Relationships

- A **daily page** holds many **focus areas**, **working notes** entries, and a schedule
- A **focus area** may persist across days as a **carry-forward**
- A **capture** lands in working notes; a **save** routes to a long-term destination
- The **integration layer** decouples skills from any specific service

## Flagged ambiguities

- "save" was previously used to mean both daily-page append *and* long-term routing — resolved: `/capture` is daily-page-only; `/save` is long-term routing with explicit destination prompt.
- "priorities" vs "focus areas" — resolved: the daily page uses **focus areas**; "priorities" is left as user-facing language only.
