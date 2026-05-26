Skills are organized into bucket folders under `skills/`:

- `daily/` — the daily flow loop (morning, midday, EOD)
- `notes/` — capture and routing skills (anything that takes input and persists it)
- `work/` — collaboration skills tied to shipping work (standups, meetings, reviews, research)
- `life/` — non-work workflows (plants, recipes, trips, watchlists)
- `meta/` — skills about the kit itself (setup, scaffolding)
- `personal/` — tied to my own setup, not promoted
- `in-progress/` — drafts not yet ready to ship
- `deprecated/` — no longer used

Every skill in `daily/`, `notes/`, `work/`, `life/`, or `meta/` must have:

- A reference in the top-level `README.md`
- An entry in `.claude-plugin/plugin.json`
- A one-line description in its bucket's `README.md`

Skills in `personal/`, `in-progress/`, and `deprecated/` must NOT appear in any of those three places.

Each skill entry in the top-level `README.md` must link the skill name to its `SKILL.md`.

Each bucket folder has a `README.md` that lists every skill in the bucket with a one-line description, with the skill name linked to its `SKILL.md`.

Skills reference the integration layer using `{{notes}}`, `{{tasks}}`, `{{calendar}}`, `{{chat}}` placeholders rather than specific services (Notion, Jira, Slack, etc.). The active integration is configured in `integrations/active.md`.

Shared language for skills (daily page, focus areas, working notes, capture vs. save, etc.) is defined in `CONTEXT.md`.

## Skill style

Skills should be short and composable — closer to 30–60 lines than 100+. Each skill: frontmatter, trigger phrases, a numbered workflow, and minimal Notes. Drop `## Examples` unless a worked example is the only way to communicate the expected output shape. `skills/work/code-review/SKILL.md` is a good reference for the target shape.
