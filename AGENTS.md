# AI Workflow Kit

This repository contains workflow automation skills for AI coding assistants. Skills automate the non-coding parts of an engineer's day: morning planning, EOD reviews, meeting prep, standups, journaling, and more.

## How to Use Skills

Skills are in the `skills/` directory. Each skill has a `SKILL.md` file with trigger phrases and a step-by-step workflow. When the user says a trigger phrase (e.g., "good morning", "eod review", "standup"), execute the matching skill.

## Integration Layer

Skills reference generic integration points (calendar, notes, tasks, chat) rather than specific services. Check `integrations/active.md` for which services are configured and how to call them.

## Shared Context

- `shared/context/about-me.md` — User's role, preferences, and coding philosophy
- `shared/context/instructions.md` — General behavioral instructions
- `shared/context/writing.md` — Writing voice and tone guidelines
- `shared/personas/` — Code review personas (Architect, Nitpicker)

## Skill Index

| Skill | Triggers | Description |
|-------|----------|-------------|
| morning-kickoff | "good morning", "start my day" | Daily page with calendar + tasks |
| eod-review | "eod", "wrapping up", "done for today" | Review work, prep tomorrow |
| checkin | "checkin", "how's my day" | Midday progress check |
| standup | "standup", "post update" | Async team updates |
| meeting-prep | "prep for [meeting]" | Gather context for meetings |
| journal | "journal:", "feeling" | Quick journal entries |
| code-review | "review this", "code review" | Multi-persona code review |
| research | "research [topic]" | Deep-dive with synthesis |
| todo | "todo:", "remind me" | Quick task capture |
| read-later | "read later:", "save article" | Save articles with summaries |
| plants | "water plants", "plant check" | Houseplant tracking |
| recipe | "recipe:", "save recipe" | Recipe management |
| watchlist | "want to watch", "rate [movie]" | Movie/show tracking |
| trip | "trip to", "plan trip" | Trip planning |
