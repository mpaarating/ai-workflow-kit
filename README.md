# AI Workflow Kit

Agent skills for the non-coding half of your job.

Most of the productivity gap in an engineer's day isn't writing code. It's the connective tissue around it — context-gathering, captures that never get captured, daily plans that never get reviewed, half-finished thoughts lost between sessions. These tasks take 15 minutes each and get perpetually deferred.

This kit is the set of small, composable skills I run every day to close that gap. Hack on them. Make them your own.

## Quickstart (30 seconds)

```bash
git clone https://github.com/mpaarating/ai-workflow-kit.git
cd ai-workflow-kit
./setup.sh
```

The setup script symlinks skills into your agent's skills directory and asks which backends you use (notes, tasks, calendar, chat). For Claude Code, you can also run `/setup-workflow-kit` from inside the agent to do the same configuration interactively.

After install:

```
/morning-kickoff       # at the start of your day
/top-priority          # any time you're not sure what to do next
/checkin               # midday
/tend                  # mid-afternoon
/eod-review            # before signing off
/capture: "..."        # whenever a thought needs to land
```

## Why These Skills Exist

I built these to fix specific failure modes I kept hitting with Claude Code, Codex, and other agents.

### #1: You start the day cold

> "What you do every day matters more than what you do once in a while."
>
> Gretchen Rubin, *Better Than Before*

**The problem:** You open the laptop with no sense of what today is for. Your task list is a wall. Your calendar is meetings. You pick whichever thing pings you first — Slack, email, the loudest ticket — and the day is gone before the important work starts.

**The fix:** A daily page that gets created before you sit down. Calendar + tasks + yesterday's carry-forwards, pre-digested. Three focus areas chosen *by you* but suggested by the agent. A single read-only "what should I work on right now?" call when momentum stalls.

- [`/morning-kickoff`](./skills/daily/morning-kickoff/SKILL.md) — builds today's page
- [`/top-priority`](./skills/daily/top-priority/SKILL.md) — instant "what now?" decision, read-only

### #2: Captures don't happen

> "The faintest pencil is better than the strongest memory."

**The problem:** A thought lands during a meeting. A Slack thread is the start of a decision. A research result is worth keeping. None of it gets saved because saving is friction — open the app, find the page, format the entry. You promise yourself you'll write it down later. You don't.

**The fix:** Two skills with a hard distinction. `/capture` is for today, fast, no thinking — it lands on today's page and that's it. `/save` is for content that has lasting value and asks you where it should live before persisting. The split removes the "where should this go?" hesitation that kills most captures.

- [`/capture`](./skills/notes/capture/SKILL.md) — fast append to today's page
- [`/save`](./skills/notes/save/SKILL.md) — intelligent routing to long-term home
- [`/journal`](./skills/notes/journal/SKILL.md) — daily journal entry
- [`/todo`](./skills/notes/todo/SKILL.md), [`/read-later`](./skills/notes/read-later/SKILL.md) — targeted captures

### #3: The day drifts from the plan

> "Plans are worthless, but planning is everything."
>
> Dwight D. Eisenhower

**The problem:** The morning plan was good. Then a 1:1 ran long, a PR review came in, you got pulled into an incident, and at 4pm you're on your fourth context switch with no sense of what actually got done. Tomorrow-you walks into the same fog.

**The fix:** Two lightweight mid-flight checks that compare the plan to the actual page. They don't judge pivots — pivots are fine — but they make pivots *visible* so the afternoon can be re-planned consciously rather than by accident.

- [`/checkin`](./skills/daily/checkin/SKILL.md) — midday "where am I vs. where I planned to be"
- [`/tend`](./skills/daily/tend/SKILL.md) — mid-afternoon page audit + cleanup

### #4: Tomorrow-you starts cold again

> "The best time to record an experience is right after you've had it."

**The problem:** The day ends, you close the laptop, and all the context — what shipped, what's blocked, what's almost-done — disappears with you. Tomorrow-morning-you has to rebuild it from scratch. Most days this rebuild *is* the morning.

**The fix:** A structured EOD pass that reads today's page, captures what landed, marks carry-forwards explicitly, and writes the handoff to tomorrow-you. The morning kickoff reads it as the first thing it does.

- [`/eod-review`](./skills/daily/eod-review/SKILL.md) — reviews the day, preps tomorrow

### #5: Code work needs the same loop

The same patterns apply to shipping work itself: drafting a standup that reflects what actually happened, prepping for the next meeting, reviewing a PR with structured perspectives, doing real research before committing to an approach.

- [`/standup`](./skills/work/standup/SKILL.md) — async team update from current context
- [`/meeting-prep`](./skills/work/meeting-prep/SKILL.md) — context-gathering for upcoming meetings
- [`/code-review`](./skills/work/code-review/SKILL.md) — multi-persona review (Architect + Nitpicker)
- [`/research`](./skills/work/research/SKILL.md) — deep-dive with source synthesis

### #6: Life is a workflow too

The same skill pattern works for everything outside of work. These are demos as much as they are utilities — once you see how cheap a personal "skill" is, you start writing them for everything.

- [`/plants`](./skills/life/plants/SKILL.md) — track houseplants
- [`/recipe`](./skills/life/recipe/SKILL.md) — save recipes
- [`/watchlist`](./skills/life/watchlist/SKILL.md) — track movies and shows
- [`/trip`](./skills/life/trip/SKILL.md) — plan trips

## How It Works

Each skill is a markdown file that tells your agent what to do. The format follows the [Agent Skills specification](https://agentskills.io/specification).

```
skills/
  daily/
    morning-kickoff/
      SKILL.md
  notes/
    capture/
      SKILL.md
  ...
```

Skills reference an **integration layer** (`{{notes}}`, `{{tasks}}`, `{{calendar}}`, `{{chat}}`) rather than specific services. The active mapping lives in `integrations/active.md` and is set by `./setup.sh`.

Skills are designed to be small, composable, and easy to fork. If a skill doesn't fit your workflow, copy it and change it. That's the point.

## Reference

### Daily

The daily flow loop.

- **[morning-kickoff](./skills/daily/morning-kickoff/SKILL.md)** — Build today's page with calendar, tasks, and carry-forwards.
- **[top-priority](./skills/daily/top-priority/SKILL.md)** — Read-only "what should I work on right now?" decision.
- **[checkin](./skills/daily/checkin/SKILL.md)** — Midday progress check; refocus the afternoon.
- **[tend](./skills/daily/tend/SKILL.md)** — Mid-afternoon page audit and cleanup.
- **[eod-review](./skills/daily/eod-review/SKILL.md)** — End-of-day review; prepare tomorrow's handoff.

### Notes

Capture and routing.

- **[capture](./skills/notes/capture/SKILL.md)** — Quick append to today's daily page.
- **[save](./skills/notes/save/SKILL.md)** — Intelligent routing to long-term destination.
- **[journal](./skills/notes/journal/SKILL.md)** — Daily journal entry.
- **[todo](./skills/notes/todo/SKILL.md)** — Capture tasks to your task system.
- **[read-later](./skills/notes/read-later/SKILL.md)** — Save articles with summaries.

### Work

Collaboration around shipping.

- **[standup](./skills/work/standup/SKILL.md)** — Draft async team updates.
- **[meeting-prep](./skills/work/meeting-prep/SKILL.md)** — Gather context for upcoming meetings.
- **[code-review](./skills/work/code-review/SKILL.md)** — Multi-persona code review.
- **[research](./skills/work/research/SKILL.md)** — Deep-dive research with synthesis.

### Life

Same pattern, applied outside of work.

- **[plants](./skills/life/plants/SKILL.md)** — Track houseplants.
- **[recipe](./skills/life/recipe/SKILL.md)** — Save and organize recipes.
- **[watchlist](./skills/life/watchlist/SKILL.md)** — Movies and shows.
- **[trip](./skills/life/trip/SKILL.md)** — Trip planning.

### Meta

- **[setup-workflow-kit](./skills/meta/setup-workflow-kit/SKILL.md)** — One-time interactive setup. Run first.

## Customizing

### Shared context

`shared/context/` holds composable context files referenced by skills:

- `about-me.md` — your role, preferences, working style
- `instructions.md` — how the agent should behave
- `writing.md` — your writing voice (used by standup, journal, etc.)

Edit `about-me.md` first. It shapes every skill.

### Personas

`shared/personas/` holds reusable agent personas (currently Architect + Nitpicker for code review). Add your own and reference them from a skill.

### Adding a skill

Copy the closest existing skill, drop it in the right bucket, and adapt. See `CLAUDE.md` for the structural rules (top-level README + bucket README + plugin manifest entries).

## Philosophy

**Specific to your workflow, not your tools.** Skills should describe *what you do*, not which app stores it. The integration layer keeps skills portable.

**Small and composable.** A skill that does one thing well and can be chained with others is worth more than a 300-line "do everything" skill.

**Start with one.** Don't install all 18 on day one. Pick the gap that bugs you most — usually morning-kickoff or capture — and live with it for a week.

## License

MIT
