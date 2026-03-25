# Talk: AI Workflow Skills — Automating the Parts of Your Day You Never Get Around To

## Talk Info

- **Event**: [Event Name]
- **Date**: [Date]
- **Speaker**: [Your Name]
- **Duration**: ~25 min + Q&A
- **Format**: Live demo heavy, minimal slides
- **Repo**: github.com/mpaarating/ai-workflow-kit

---

## Opening (2 min)

**What to say:**
- "How many of you write end-of-day reviews? ...How many of you *meant* to write one yesterday but didn't?"
- Every engineer has a list of 15-minute tasks that would make them way more effective but never actually happen. Standups, meeting prep, daily planning, journaling. They're all important, none of them are urgent, so they get skipped.
- "I built a thing that makes them happen automatically. It's 14 markdown files and it changed how I work more than any AI coding tool."

**What to show:**
- Nothing yet. Just talking. Maybe the repo star count on GitHub if it's decent by then.

**Timing notes:**
- Keep this tight. Don't over-explain the problem yet -- that's the next section.

**Transition:**
- "Let me show you what I mean by '15-minute tasks that never happen.'"

---

## The Problem (3 min)

**What to say:**
- Walk through a typical day: you open your laptop, check Slack, check email, check Jira, check your calendar. By the time you've gathered context, it's 10am and you haven't written a line of code.
- Then at the end of the day, you *know* you should write down what you accomplished and what's carrying over to tomorrow -- but you're tired and you just close the laptop.
- "The irony is that AI tools are incredible at writing code, but the stuff that actually falls through the cracks isn't code. It's the meta-work around code."
- These tasks are perfect for AI: they're structured, they're repetitive, they pull from data sources you already have (calendar, Jira, Slack, Notion). But nobody's building skills for this because it's not as flashy as "AI writes your whole app."

**What to show:**
- Could show a slide with the list of tasks and "time to do" vs "how often actually done" -- but honestly, just talking is fine here. The audience will nod along.

**Timing notes:**
- Don't dwell. Everyone in the room knows this problem. Name it and move on.

**Transition:**
- "So I started building workflow skills. Let me show you what one looks like."

---

## Architecture Overview (5 min)

**What to say:**
- A "skill" is just a markdown file. That's it. No SDK, no framework, no npm install. It's a SKILL.md file that tells your AI assistant what to do, step by step.
- Walk through the SKILL.md format: frontmatter (name, description), trigger phrases, workflow steps, examples.
- The key design decision: skills reference *integrations* (calendar, notes, tasks), not specific services. So the skill says "fetch today's calendar" and the integration layer decides if that means Google Calendar, Apple Calendar, or the Zapier SDK.
- This means the same skill works for someone using Notion + Jira + Google Calendar and someone using Obsidian + Linear + Apple Calendar. Or someone using nothing -- there's a plain markdown fallback for everything.
- Works with Claude Code (as slash commands), Cursor (as rules), Codex (via AGENTS.md). The format follows the Agent Skills spec that's emerging as a standard.

**What to show:**
- Open `skills/morning-kickoff/SKILL.md` in your editor. Scroll through it. Point out:
  - The frontmatter
  - Trigger phrases ("good morning", "start my day")
  - The workflow steps (check for existing page, fetch calendar, fetch tasks, check yesterday, suggest priorities, create page)
  - The `{{notes}}`, `{{calendar}}`, `{{tasks}}` template variables -- these are the integration points
  - The example at the bottom showing what the output looks like
- Briefly show `integrations/active.example.md` to illustrate how integrations are configured
- Show the repo structure: `skills/`, `shared/`, `integrations/`, `setup.sh`

**Timing notes:**
- Don't read the whole file. Scroll and point at the key parts. People can read it themselves later. Spend more time on the *why* (integration layer, portability) than the *what* (the specific markdown syntax).

**Transition:**
- "That's the theory. Let me show you what it actually looks like in practice."

---

## Live Demo: Morning Kickoff (5 min)

**What to say:**
- "This is the skill I use every single morning. I open Claude Code and type 'good morning.'"
- Narrate what's happening as it runs: it's checking Notion for an existing daily page, pulling my calendar, pulling my Jira tickets, checking yesterday's carry-forwards, then creating a page with priorities.
- Point out the priority logic: "It knows I have 4 hours of meetings today, so it's suggesting quick wins instead of deep work tasks. If I had a light meeting day, it'd suggest different things."
- Show the resulting daily page in Notion (or wherever it lands). Point out the structure: Focus Areas, Schedule, Carry-Forward, Working Notes, End-of-Day Recap.
- "The EOD review skill fills in that last section at the end of the day. And the checkin skill does a midday check against what I planned. They're designed to work together."

**What to show:**
1. Terminal: Open Claude Code in the ai-workflow-kit repo (or your personal workspace)
2. Type `/morning-kickoff` or just "good morning"
3. Let it run. Talk over it as it gathers context.
4. Switch to Notion to show the created page
5. Scroll through the page structure

**Timing notes:**
- This demo takes the longest because it's the most impressive. Let it breathe. Don't rush the "wow, it pulled all that together" moment.
- If the audience seems engaged, show the carry-forward logic from yesterday's page.

**If Demo Fails:**
- Have a screenshot/recording of a successful morning kickoff ready
- Show the SKILL.md and walk through what *would* happen: "It would pull 3 meetings from Google Calendar, grab my top Jira tickets, check yesterday's carry-forwards, and build a page like this..." then show the screenshot
- Common failure: Notion MCP connection drops. Restart with `/mcp` and retry, or fall back to the screenshot.

**Transition:**
- "That's the workflow stuff. But the same pattern works for dev tasks too."

---

## Live Demo: Code Review (3 min)

**What to say:**
- "Same idea, different domain. I type 'code review' and it runs two review perspectives in parallel."
- Explain the dual-persona approach: Architect (big picture -- pattern consistency, reusability, abstraction) and Nitpicker (details -- naming, magic values, dead code, test names).
- "Each persona has its own markdown file in shared/personas/. You can customize them, add your own, or swap them out."
- Point out that findings are merged, deduped, and sorted by priority. High issues first, then medium, then low.
- "It also offers to fix things. If the Nitpicker flags a bad variable name, you can say 'fix it' and it will."

**What to show:**
1. Have a branch ready with some changes (prep this ahead of time -- see Demo Prep Checklist)
2. Run `/code-review` or "review my code"
3. Show the output: the Arch: and Nit: prefixed findings, grouped by file, sorted by priority
4. Briefly show `shared/personas/architect.md` -- point out that the persona is fully customizable

**Timing notes:**
- This one is quicker because the concept is simpler. Don't over-explain the persona system -- show it, mention it's customizable, move on.

**If Demo Fails:**
- Have a previous code review output saved as a text file. Show it and walk through the format.
- If git diff fails (wrong branch, no changes), just `git diff main...HEAD` manually and show the personas.

**Transition:**
- "Okay, now for the one that gets the most reactions."

---

## The Fun Ones (2 min)

**What to say:**
- "I also track my houseplants with this."
- Let that land. Pause for laughs.
- "Same pattern -- SKILL.md file, trigger phrases, structured workflow. I say 'how are my plants' and it shows me a status table with watering schedules. It flags overdue plants. I say 'watered the pothos' and it logs it."
- "The plants skill is silly but it makes a serious point: once you have the pattern, building a new skill takes about 15 minutes. It's just markdown. You can make a skill for literally anything -- recipes, movie watchlists, trip planning. The repo has all of those."
- "The plants skill is also the one that gets people to actually try the repo. Nobody gets excited about daily planning, but everyone has a plant they're accidentally killing."

**What to show:**
- Quick demo: "how are my plants" -- show the status table
- Or just show the SKILL.md for plants. It's short and self-explanatory.
- Optionally show the recipe or watchlist skill names in the directory listing to reinforce the breadth

**Timing notes:**
- This is the "palate cleanser" section. Keep it light and fast. The humor does the work.

**If Demo Fails:**
- Just show the SKILL.md file and describe what the output looks like. The humor of "I track my plants with AI" carries this section regardless.

**Transition:**
- "So what did I actually learn building all of this?"

---

## What I Learned (3 min)

**What to say:**

1. **Markdown is the universal interface.** Every AI tool can read markdown. You don't need a framework, a plugin system, or a DSL. A well-structured markdown file is all it takes. The Agent Skills spec is just formalizing what people were already doing.

2. **Integration abstraction matters more than you'd think.** The `{{calendar}}` / `{{notes}}` / `{{tasks}}` template pattern was a late addition and it made everything 10x more portable. Without it, every skill would be hardcoded to Notion + Jira + Google Calendar, and nobody else could use them.

3. **Start with one skill and live with it.** I built all 14 at once and that was a mistake. The morning kickoff skill went through 6 revisions in the first week because I kept discovering what I actually needed. You learn the most from daily use, not from designing in advance.

4. **The compound effect is the point.** No single skill saves you a ton of time. But when your morning kickoff feeds your midday checkin which feeds your EOD review which feeds tomorrow's morning kickoff -- that loop is where the real value is. It's not about any one task, it's about the system.

5. **People underestimate non-code AI use cases.** We're all focused on "AI writes code" but the highest-ROI use of AI in my workflow is the stuff that has nothing to do with code -- it's daily planning, context gathering, and writing team updates.

**What to show:**
- Nothing. Just talking. This is the reflective section.

**Timing notes:**
- These are the takeaways people will actually remember. Slow down here. Let each point land.

**Transition:**
- "The repo is public if you want to try it."

---

## The Repo + Q&A (5 min)

**What to say:**
- Show the repo: github.com/mpaarating/ai-workflow-kit
- Walk through the README briefly -- the Quick Start section, the setup wizard
- "Clone it, run `./setup.sh`, pick your tools, and you're running. Start with morning-kickoff or eod-review -- those are the two most useful ones."
- "If you build a skill that you think others would want, PRs are welcome."
- Mention: it's MIT licensed, no dependencies, works with Claude Code / Cursor / Codex out of the box
- Open for questions

**What to show:**
- GitHub repo page
- README on screen
- Maybe the setup.sh running if there's time

**Timing notes:**
- Don't demo the setup wizard unless someone asks. Just mention it works.

**Transition:**
- "Questions?"

---

## Demo Prep Checklist

### The Day Before

- [ ] Run `/morning-kickoff` fresh so there's a clean daily page to show (or prep a good-looking one manually)
- [ ] Prep a demo branch with ~5-10 files changed for the code review demo. Include some intentional issues: a vague variable name, a magic number, a commented-out block, a function doing two things. Name the branch something like `demo/feature-update`.
- [ ] Make sure plants data exists with at least 3-4 plants, one of which is overdue for watering
- [ ] Test all MCP connections: Notion, Jira, Google Calendar, Slack. Run `/morning-kickoff` end-to-end and verify the page gets created.
- [ ] Clear recent terminal history so the demo starts clean
- [ ] Set terminal font size to something readable from the back of the room (18pt+)
- [ ] Have backup screenshots/recordings ready for each demo (see below)

### Day Of

- [ ] Run `/mcp` to ensure all MCP servers are connected before the talk
- [ ] Open Claude Code in a clean terminal window
- [ ] Have the repo open in your editor with `skills/morning-kickoff/SKILL.md` visible
- [ ] Open Notion to the daily page area so you can switch to it quickly
- [ ] Make sure you're on the `demo/feature-update` branch for the code review demo
- [ ] Close Slack notifications, email, anything that might pop up during the demo
- [ ] Have the GitHub repo page open in a browser tab for the closing section
- [ ] Test WiFi. Seriously. Test WiFi.

### Backup Materials

- [ ] Screenshot: A completed morning kickoff daily page in Notion
- [ ] Screenshot: Code review output showing Arch: and Nit: findings
- [ ] Screenshot: Plants status table with an overdue watering flag
- [ ] Text file: Full output of a morning kickoff run (copy from terminal)
- [ ] Text file: Full output of a code review run
- [ ] All backups saved locally (not dependent on network)

---

## Anticipated Q&A

**Q: How is this different from just writing a system prompt?**
A: It's essentially the same thing, but structured and portable. A SKILL.md has trigger phrases so it activates automatically, workflow steps so the AI follows a consistent process, and integration references so it works across different tool setups. You *could* paste instructions into a system prompt every time, but you wouldn't.

**Q: Does this work with [other AI tool]?**
A: If it can read markdown, yes. The skills are just text files. Claude Code and Cursor have first-class support (slash commands and rules, respectively). Codex uses AGENTS.md. For anything else, you can paste the SKILL.md content into the system prompt or context.

**Q: How do you handle API auth for all these services?**
A: Two options. The easy path is the Zapier SDK / MCP server -- one auth, 7,000+ apps. The DIY path is setting environment variables for each service. There's also a zero-dependency markdown fallback that writes local files instead of calling any APIs.

**Q: What about privacy? Are my calendar events / Jira tickets going to the AI?**
A: Same as any AI coding tool -- your data goes to the model provider (Anthropic, OpenAI, etc.). If you're already using Claude Code or Copilot with your codebase, the privacy model is identical. If that's a concern, the markdown fallback works fully offline with local models.

**Q: How long does it take to build a new skill?**
A: About 15 minutes for a basic one. Copy an existing skill directory, edit the SKILL.md, done. The plants skill took me 20 minutes. The morning kickoff took longer because I kept iterating on it, but the first working version was fast.

**Q: Why markdown instead of code / a proper plugin system?**
A: Because every AI tool already understands markdown, and the whole point is portability. If I wrote a Claude Code plugin, it wouldn't work in Cursor. If I wrote a Cursor extension, it wouldn't work in Codex. Markdown is the lowest common denominator that works everywhere.

**Q: Can skills call other skills?**
A: They can reference each other (morning-kickoff mentions it pairs with eod-review and checkin), but there's no formal skill-chaining mechanism. In practice, the AI tool handles this -- if you say "do my morning kickoff and then prep for my 10am meeting," Claude Code will run both skills sequentially.

**Q: Have you measured the actual time savings?**
A: Honestly, the time savings per task are modest -- maybe 10 minutes per skill per day. The real value is consistency. I went from doing EOD reviews maybe once a week to doing them every single day. Same with standups and meeting prep. The compound effect of *actually doing these things* is way bigger than the time saved on any individual one.

**Q: What's the Agent Skills spec you mentioned?**
A: It's an emerging standard for how AI tools discover and execute skills from markdown files. Claude Code, Codex CLI, and VS Code Copilot all support variations of it. The spec is at agentskills.io. This repo follows that format so the skills work across tools without modification.
