# I Built 50 AI Skills for the Parts of My Day I Never Got Around To

The biggest productivity gap in my day isn't writing code. It's everything around it.

Context gathering before I start working. Note-taking during and after meetings. Status updates my team actually needs. End-of-day reviews that help tomorrow-me hit the ground running. Meeting prep so I'm not winging every 1:1.

Each of these takes maybe 15 minutes. None of them are hard. And I almost never do them consistently.

Here's what my mornings used to look like: open Jira, then Slack, then my calendar, then yesterday's notes — clicking around trying to reconstruct where I left off. That's 20-30 minutes gone before I write a single line of code. End-of-day reviews? I'd do them twice a week if I was disciplined. Standups? I'd write them in a rush right before the meeting, missing half of what I actually did.

The pattern was obvious: high-value, low-effort tasks that I perpetually defer because there's always something more urgent. A PR to review. A bug to investigate. A Slack thread that needs a response.

At some point I realized — I'm spending my best thinking hours on things a structured prompt could handle. Not the thinking itself. I still decide what to prioritize, what to write, what matters. But the gathering, formatting, and scaffolding? That's just a checklist with API calls.

So I started building skills. Small markdown files that tell an AI assistant exactly how to run these workflows. One skill at a time, whenever a gap bugged me enough. Over a few months, that turned into about 50 skills covering my entire day — from "good morning" to "signing off."

Let me show you what that looks like.

## What I Built

The skills fall into three buckets:

**Workflow** — the daily rhythm stuff. Morning kickoff, midday check-in, EOD review, standup, meeting prep, journal. These run almost every day and account for most of the value.

**Dev** — tools for the actual work. Multi-persona code review, git commits with context, research synthesis. Less frequent, but high impact when they fire.

**Personal** — the fun ones. Plants, recipes, watchlist, trip planning, read-later, todo. Yes, I track my houseplants with AI. More on that later.

Each skill is a markdown file — a `SKILL.md` that follows the [agentskills.io specification](https://agentskills.io/specification) (an open format I co-created for portable AI skills). No custom runtime, no framework, no dependencies. Just a structured prompt that works with any AI coding assistant that reads markdown — I've tested with Claude Code, Cursor, and Codex.

The repo ships with 14 ready-to-use skills — the general-purpose ones that work regardless of your team or tooling. The rest of my ~50 are customized for my specific setup at Zapier (my team's Jira project, my Notion databases, our standup format). The point of the repo isn't to give you all 50 — it's to give you the foundation and show you how easy it is to build your own.

## How It Works: 3 Skills in Detail

### Morning Kickoff — The Hero Skill

This is the one that changed my mornings. Instead of the 20-minute context-gathering ritual, I type "good morning" in my terminal and the assistant builds my day.

Here's what a real interaction looks like:

```
> good morning

Checking your calendar... 4 meetings today (3.5h), leaving 4.5h of deep work.

Pulling tasks from Jira... 8 active items, 2 due today.

Checking yesterday's page... 2 carry-forward items found.

Your top 3 priorities for today:

1. Finish ENG-1847 migration script — due today, been in progress since Monday
2. Prep for 1:1 with Sarah (2pm) — haven't prepped yet, last 1:1 had 2 follow-ups
3. Review Jamie's MR on search ranking — carry-forward from yesterday, he's waiting on it

Deep work available: 4.5h (3.5h in meetings)

Creating daily page...
Done — page created with schedule, priorities, and carry-forwards.
```

Under the hood, the skill follows a seven-step workflow. It checks if today's page exists, fetches the calendar, pulls assigned tasks, reads yesterday's page for carry-forwards. Then it analyzes meeting density to suggest priorities, creates the daily page, and summarizes everything. (You can see the [full skill definition in the repo](https://github.com/mpaarating/ai-workflow-kit/tree/main/skills/morning-kickoff).)

The carry-forward logic is the killer feature. If I didn't finish something yesterday — and especially if it's been deferred more than once — it bubbles up automatically. Things don't quietly disappear from my plate. I can't tell you how many times this has saved me from forgetting a review someone was waiting on.

And the skill definition? It's just markdown:

```markdown
---
name: morning-kickoff
description: Create your daily page with calendar events and task priorities
---

# Morning Kickoff

## Trigger Phrases
- "good morning"
- "start my day"
- "morning kickoff"

## Workflow
### Step 1: Fetch Today's Calendar
Query {{calendar}} for all events happening today.
- Calculate total meeting hours and available deep work hours.

### Step 2: Check Yesterday's Page
Read the most recent daily page from {{notes}}.
- Extract items marked as carry-forwards or incomplete.
...
```

See those `{{calendar}}` and `{{notes}}` placeholders? The skill doesn't care if your calendar is Google or Apple, or if your notes are in Notion or local markdown. The integration layer handles the mapping. More on that in a bit.

### Code Review — The Dev Skill

I got tired of reviews that were either too high-level ("looks good") or too nitpicky ("rename this variable"). So I built a skill with two AI personas that review in parallel — and honestly, it's become one of my favorite things I've built.

**Architect** looks at the big picture — pattern consistency, reusability, dependency direction, whether there's a simpler approach. **Nitpicker** sweats the details — naming, magic values, dead code, comment quality, boolean naming conventions.

The skill kicks off two parallel AI calls — one for each persona — against your branch diff. Their findings get merged, deduplicated, and sorted by priority. The output looks like this:

```
## Code Review: feature/search-ranking
Files changed: 7 | Lines: +142 / -38

### High Priority

Arch: [Reusability] — The retry logic in fetchResults() duplicates what's
already in @core/http/fetchWithRetry. Consider reusing the existing utility
instead of reimplementing backoff here.

Nit: [Naming] — `data` on line 47 of search-service.ts is too vague. This
holds the ranked search results — consider `rankedResults` to make the
variable self-documenting.

### Medium Priority

Arch: [DependencyInjection] — SearchService directly instantiates the
HttpClient. Passing it as a constructor parameter would make this testable
without mocking the import.

Nit: [MagicValues] — The `3` on line 92 (max retry count) should be a named
constant. It represents a business decision that someone will need to find later.

Nit: [BooleanNaming] — `valid` on line 61 doesn't read as a question.
Consider `isValidQuery` — it makes the conditional on line 63 read naturally.

### Low Priority

Nit: [DeadCode] — Commented-out console.log on line 34. Version control
has your back — safe to remove.
```

Each persona has its own shared definition file that gets loaded at review time. You can customize what each one cares about — or add a third persona if your team has specific conventions. I've been tempted to add a "Security" persona but haven't gotten there yet.

### Plants — The Crowd-Pleaser

Yes, I track my houseplants with AI. This is the skill people always ask about first, so let's just get into it:

```
> how are my plants

| Plant          | Status     | Last Watered | Schedule | Light   |
|----------------|------------|--------------|----------|---------|
| Pothos         | Thriving   | Mar 20       | Weekly   | Low     |
| Fiddle Leaf    | Struggling | Mar 10       | Biweekly | Bright  |
| Snake Plant    | Healthy    | Mar 18       | Monthly  | Any     |
| Monstera       | Healthy    | Mar 17       | Weekly   | Bright  |

⚠ Fiddle Leaf is 13 days overdue for watering (biweekly schedule).
⚠ Monstera is 6 days overdue for watering (weekly schedule).
```

```
> new plant: bird of paradise

Bird of Paradise — common care: bright direct light, water weekly,
not pet-friendly.
Sound right? (yes / adjust)

> yes

Added: "Bird of Paradise" — Bright light, weekly water, not pet-friendly.
```

It's a silly example, but it makes an important point: if you can describe a workflow in plain English, you can build a skill for it. This one took maybe 15 minutes to write — about 100 lines of markdown. And it genuinely helps! My fiddle leaf fig is no longer on the brink of death. Progress.

## The Integration Layer

Skills use placeholders — `{{notes}}`, `{{tasks}}`, `{{calendar}}`, `{{chat}}` — instead of hardcoded service names. This means the same skill works whether you use Notion or Obsidian, Jira or Linear, Google Calendar or Apple Calendar.

You have three options for wiring things up:

**Zapier SDK** — the easy button. The [Zapier MCP server](https://github.com/zapier/zapier-mcp) uses MCP (Model Context Protocol — a standard for connecting AI assistants to external tools) to handle auth for 7,000+ apps through a single connection. One login and you're connected to Calendar, Slack, Jira, Notion, email, and basically everything else. This is what I use — full disclosure, I work at Zapier, and building tools on top of tools is kind of the job.

**Bring Your Own Keys** — set environment variables for each service directly. More control over the connection, more setup upfront. Good if you want to avoid a third-party auth layer.

**Plain Markdown** — zero dependencies. Skills fall back to creating local markdown files in `~/.ai-workflow/`. No API keys, no accounts, no setup beyond cloning the repo. This is the best way to try it out before committing to integrations.

An interactive setup wizard (`./setup.sh`) asks what tools you use and configures everything. Takes about 2 minutes. You can re-run it anytime if your setup changes.

## What I Learned

A few things surprised me after months of daily use:

**15 minutes to build, daily compound returns.** Each skill is small — most are under 100 lines of markdown. But because they run every day, the ROI adds up fast. My morning kickoff alone saves 20-30 minutes of context gathering per day. Over a month, that's nearly a full workday I got back. Not bad for a markdown file!

**The real value isn't automation — it's consistency.** Before skills, my EOD reviews happened maybe twice a week. Now they happen every day because the activation energy is saying "wrapping up" instead of opening five tabs and synthesizing from scratch. Turns out, consistent daily reflection changes what you notice. Patterns that were invisible before become obvious when you review every single day.

**Skills should be specific to YOUR workflow.** The 14 in the repo are starting points. The real magic happens when you customize morning-kickoff for your team's standup format, or adapt code-review to match your codebase's conventions, or add a persona that checks for your org's specific anti-patterns. My personal skills reference my team's Jira project, my manager's name, my Notion database IDs. That specificity is what makes them feel like an extension of how I already work — not a generic tool bolted on top.

**Start with one skill, make it yours, then add more.** Seriously — don't install all 14 on day one. Pick the gap that bugs you most — probably morning kickoff or EOD review — and live with it for a week. Tweak it until it fits your rhythm. Then add another. The skills that stick are the ones shaped by actual use, not the ones you configured in a burst of enthusiasm on a Saturday.

## The Repo

**[github.com/mpaarating/ai-workflow-kit](https://github.com/mpaarating/ai-workflow-kit)**

14 ready-to-use skills. Works with Claude Code, Cursor, Codex, and any AI coding assistant that reads markdown. Each tool loads skills slightly differently — the README covers setup for each. MIT licensed.

Clone it, run `./setup.sh`, and try "good morning" tomorrow.

Or better — pick the workflow gap that bugs you most and build a skill for it. The SKILL.md format is just markdown with trigger phrases and numbered steps. If you can write a checklist, you can write a skill.

That's where the real value is. Not in my 14 skills. In the ones you'll build for yourself.
