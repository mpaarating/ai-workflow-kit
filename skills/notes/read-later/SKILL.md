---
name: read-later
description: Save articles to a reading list with a short AI-generated summary and a category tag. Never lose an interesting link again.
---

# Read Later

## Trigger Phrases

- "read later: [url]"
- "save article [url]"
- "interesting: [url]"
- "read this: [url]"

## Workflow

1. **Extract the URL** from the user's message. If none provided, ask for one.

2. **Fetch the article** — extract title, author, publication date, and body. Strip nav, ads, boilerplate. If fetching fails (paywall, 404, timeout), save with just the URL and link text, and note "Could not fetch full content."

3. **Write a 3–4 sentence summary**: what the article is about (1 sentence), the key insight or argument (1–2 sentences), why it matters or who it's useful for (1 sentence). Factual, no editorializing.

4. **Assign one category tag** based on content:

   | Category | Signals |
   |----------|---------|
   | AI | Machine learning, LLMs, AI tools, agents |
   | Web Dev | Frontend, backend, frameworks, APIs |
   | DevOps | Infrastructure, CI/CD, deployment, monitoring |
   | Career | Growth, management, interviewing, culture |
   | General | Everything else |

5. **Save to {{notes}}** with fields: Title, URL, Summary, Category, Date Saved, Status (Unread). Fallback if unconfigured — append to `~/.ai-workflow/reading-list.md`:

   ```markdown
   ## [Article Title](https://example.com/article)
   - **Saved**: 2026-03-19
   - **Category**: AI
   - **Status**: Unread

   Summary text here.
   ```

6. **Confirm briefly**:

   ```
   Saved: "Title" (Category)
   > 3-sentence summary.
   ```
