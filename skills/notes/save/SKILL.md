---
name: save
description: Intelligent content capture — analyzes, extracts key info, and routes to the right long-term destination (project page, knowledge base, reference doc). Always asks where.
---

# Save

Where **capture** appends to today's daily page, **save** routes content to its right long-term home. Use save when the content has lasting value beyond today.

## Trigger Phrases

- "save: [content or URL]"
- "save this" (after a research, search, or fetch)
- "save this thread [url]"
- "save the doc [url]"
- "save meeting notes"
- "keep this" / "bookmark" / "stash this"

## Core Rule

**Always ask where to save.** Never auto-route. If the user is unsure, help them think it through.

## Workflow

1. **Accept content from any source:**
   - URL (chat thread → {{chat}}; document → fetch title + summary; public URL → fetch + summarize)
   - Previous conversation ("save this" after a research/search result)
   - Manual paste (meeting notes, transcript excerpts)

2. **Analyze.** Extract type (meeting notes / decision / research / reference / action items / discussion), people mentioned, ticket IDs, dates, action items (`TODO`, `Action:`, `[name] will...`), decisions (`decided`, `agreed`, `will do`), key topics.

3. **Present analysis and ask where to save.** Show what was extracted and offer concrete destinations from the user's actual notes structure — don't invent.

   Common destinations:
   | Destination | When |
   |-------------|------|
   | Today's daily page | Time-sensitive context |
   | Project / initiative page | Content tied to ongoing work |
   | Knowledge base / reference area | Decisions, learnings, "how we do X" |
   | Person page (1:1 notes, directory) | Tied to a specific person |
   | New standalone page | Doesn't fit anywhere existing |

   Example:
   ```
   ## Content Analysis
   **Type:** Meeting notes
   **People:** Jordan, Taylor
   **Tickets:** AUTH-65
   **Decisions:** Feedback controls missing is a bug, will fix this sprint
   **Action items:** Investigate rendering (Alex), Review PR (Jordan)

   ### Where should I save this?
   1. Today's daily page
   2. AUTH-65 project page (recommended)
   3. New standalone page
   ```

4. **Link people and references** when writing:
   - Look up mentioned people in {{notes}} (directory, team list). Hyperlink names. If a person isn't tracked, offer to create an entry.
   - Hyperlink ticket IDs to {{tasks}}.
   - Keep original URLs as backlinks.

5. **Save to the confirmed destination** using the structure that matches existing content. Confirm with the page title and a link.

## Notes

- **Confirm before saving.** Skip confirmation only when the user names a clear destination ("save it to the AUTH-65 page").
- **Don't duplicate.** If "save this" follows another skill's output, check that the content isn't already being persisted by that skill.
- **Backlinks matter.** When saved content references a project page, add a link back from the project page when possible.
