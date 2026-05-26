# AI Workflow Kit

This repository contains workflow automation skills for AI coding assistants. Skills automate the non-coding parts of an engineer's day: morning planning, EOD reviews, meeting prep, standups, journaling, and more.

Install via [skills.sh](https://skills.sh): `npx skills@latest add mpaarating/ai-workflow-kit`. After install, run `/setup-workflow-kit` inside your agent to configure backends.

## How to Use Skills

Skills live in `skills/<bucket>/<skill-name>/SKILL.md`. Each skill has trigger phrases and a workflow. When the user says a trigger phrase (e.g., "good morning", "eod review", "standup"), execute the matching skill.

Buckets: `daily/`, `notes/`, `work/`, `life/`. See `CLAUDE.md` for repo conventions and `CONTEXT.md` for the shared language used across skills.

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
| top-priority | "what's next", "top priority", "what now" | Read-only "what should I do right now" |
| checkin | "checkin", "how's my day" | Midday progress check |
| tend | "tend", "tidy page", "housekeeping" | Mid-afternoon page audit + cleanup |
| eod-review | "eod", "wrapping up", "done for today" | Review work, prep tomorrow |
| standup | "standup", "post update" | Async team updates |
| meeting-prep | "prep for [meeting]" | Gather context for meetings |
| capture | "capture:", "note:", "link [TICKET]" | Quick append to today's page |
| save | "save:", "save this", "bookmark" | Route content to long-term destination |
| journal | "journal:", "feeling" | Quick journal entries |
| code-review | "review this", "code review" | Multi-persona code review |
| research | "research [topic]" | Deep-dive with synthesis |
| todo | "todo:", "remind me" | Quick task capture |
| read-later | "read later:", "save article" | Save articles with summaries |
| plants | "water plants", "plant check" | Houseplant tracking |
| recipe | "recipe:", "save recipe" | Recipe management |
| watchlist | "want to watch", "rate [movie]" | Movie/show tracking |
| trip | "trip to", "plan trip" | Trip planning |
