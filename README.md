# AI Workflow Kit

Automate the non-coding parts of your day with AI-powered workflow skills.

Morning kickoffs, end-of-day reviews, meeting prep, async standups, journaling, code review — the stuff that matters but never gets done consistently. This kit gives you **ready-to-use skills** that work with Claude Code, Cursor, Codex, and other AI coding assistants.

## The Problem

The biggest gap in most engineers' productivity isn't writing code. It's everything around it:

- **Context gathering** before you start working
- **Note-taking** during and after meetings
- **Status updates** your team needs but you forget to post
- **End-of-day reviews** that help tomorrow-you hit the ground running
- **Meeting prep** so you're not winging every 1:1

These tasks take 15 minutes each but get perpetually deferred. This kit makes them happen automatically.

## What's Inside

### Workflow Skills

| Skill | What It Does |
|-------|-------------|
| **morning-kickoff** | Creates your daily page with calendar events, task priorities, and yesterday's carry-forwards |
| **eod-review** | Reviews completed work, identifies carry-forwards, preps tomorrow's plan |
| **checkin** | Midday progress check — compares morning plan to actual work, refocuses afternoon |
| **standup** | Drafts async team updates from your current work context |
| **meeting-prep** | Gathers docs, previous notes, tickets, and Slack context for upcoming meetings |
| **journal** | Quick journal entries linked to your daily work log |

### Dev Skills

| Skill | What It Does |
|-------|-------------|
| **code-review** | Multi-persona review with Architect and Nitpicker perspectives |
| **research** | Deep-dive research with source synthesis |

### Personal Skills

| Skill | What It Does |
|-------|-------------|
| **todo** | Quick task capture to your preferred task system |
| **read-later** | Save articles with AI-generated summaries |
| **plants** | Track your houseplants (yes, really — and people love this one) |
| **recipe** | Save and organize recipes |
| **watchlist** | Track movies/shows to watch and rate ones you've seen |
| **trip** | Trip planning with itinerary generation |

## Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/mpaarating/ai-workflow-kit.git
cd ai-workflow-kit
```

### 2. Run setup

```bash
./setup.sh
```

The setup wizard asks what tools you use and configures everything:

- **AI Tool**: Claude Code, Cursor, Codex, or other
- **Notes**: Notion, Obsidian, or plain markdown
- **Tasks**: Jira, Linear, GitHub Issues, or TODO.md
- **Calendar**: Google Calendar, Apple Calendar, or none
- **Chat**: Slack, Discord, or none
- **Auth**: Zapier SDK (recommended — one login for everything) or bring your own API keys

### 3. Start using skills

```bash
# In Claude Code
> /morning-kickoff
> /eod-review
> /checkin

# In Cursor — skills load as rules
# In Codex — skills load via AGENTS.md
```

## How It Works

Each skill is a markdown file that tells your AI assistant what to do. The format follows the [Agent Skills specification](https://agentskills.io/specification) — an emerging standard supported by Claude Code, Codex CLI, and VS Code Copilot.

```
skills/
  morning-kickoff/
    SKILL.md          # The skill definition
  eod-review/
    SKILL.md
  ...
```

A skill definition looks like this:

```markdown
---
name: morning-kickoff
description: Create your daily page with calendar events and task priorities
---

# Morning Kickoff

## Trigger Phrases
- "good morning"
- "start my day"

## Workflow
### Step 1: Gather Context
...
```

Skills reference **integrations** rather than specific services. When you say "fetch my calendar events," the skill doesn't care if that's Google Calendar or Apple Calendar — the integration layer handles it.

## Integrations

### Zapier SDK (Recommended)

The easiest path. The [Zapier MCP server](https://github.com/zapier/zapier-mcp) handles auth for 7,000+ apps through a single connection. One login, all your tools.

```bash
# During setup, choose "Zapier SDK"
# Auth once, access: Calendar, Email, Slack, Jira, Notion, and more
```

### Bring Your Own Keys

Prefer direct API access? Set environment variables for each service:

```bash
# Notes
export NOTION_API_KEY=your_key        # For Notion
# Or use Obsidian vault path
export OBSIDIAN_VAULT=~/Documents/vault

# Tasks
export JIRA_API_TOKEN=your_token
export JIRA_BASE_URL=https://yourorg.atlassian.net

# Calendar
export GOOGLE_CALENDAR_ID=your@email.com

# Chat
export SLACK_BOT_TOKEN=xoxb-your-token
```

### Plain Markdown (Zero Dependencies)

Every skill has a markdown fallback. No API keys needed — skills create local files:

```
~/.ai-workflow/
  daily/2026-03-19.md
  journal/2026-03-19.md
  todos.md
  reading-list.md
```

## Customization

### Add Your Own Skills

Copy any skill directory and modify:

```bash
cp -r skills/todo skills/my-custom-skill
# Edit skills/my-custom-skill/SKILL.md
```

### Modify Shared Context

The `shared/` directory contains composable context files:

```
shared/
  context/
    about-me.md       # Your role, preferences, coding philosophy
    instructions.md   # How the AI should behave
    writing.md        # Your writing voice and tone
  personas/
    architect.md      # Code review: big-picture perspective
    nitpicker.md      # Code review: detail-oriented perspective
```

Edit `shared/context/about-me.md` to tell the AI who you are. This shapes every skill's behavior.

### Integration with Your Tool

| Tool | How Skills Load |
|------|----------------|
| **Claude Code** | Symlinked to `~/.claude/commands/` or `~/.claude/skills/` |
| **Cursor** | Copied to `.cursor/rules/` as `.mdc` files |
| **Codex** | Referenced in `AGENTS.md` |
| **Other** | Skills are just markdown — paste into any system prompt |

The setup script handles this automatically.

## Philosophy

**Skills should be specific to your workflow, not your tools.** This kit gives you a starting point, but the real value comes from customizing skills for how *you* work. Your morning kickoff should reflect *your* priorities. Your standup should match *your* team's conventions.

**Start with one skill, make it yours, then add more.** Don't install all 14 on day one. Pick the workflow gap that bugs you most — probably morning kickoff or EOD review — and live with it for a week.

**15 minutes to build, daily value forever.** Each skill takes about 15 minutes to customize. But because it runs every day, the compound effect is massive.

## Contributing

Found a workflow gap? Built a skill others might want? PRs welcome.

## License

MIT
