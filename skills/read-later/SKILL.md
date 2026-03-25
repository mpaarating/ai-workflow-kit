---
name: read-later
description: Save articles with AI-generated summaries and category tags
---

# Read Later

Save articles to your reading list with a short summary and category tag. Never lose an interesting link again.

## Trigger Phrases

- "read later:"
- "save article"
- "interesting:"
- "read this:"

## Workflow

### Step 1: Extract URL

Parse the URL from the user's message. If no URL is provided, ask for one.

### Step 2: Fetch Article

Fetch the page content and extract the article body, title, author, and publication date. Strip navigation, ads, and boilerplate.

If fetching fails (paywall, 404, timeout), save with just the URL and title from the link text. Note: "Could not fetch full content."

### Step 3: Generate Summary

Write a 3-4 sentence summary of the article. Focus on:

- What the article is about (one sentence)
- The key insight or argument (one-two sentences)
- Why it matters or who it's useful for (one sentence)

Keep the summary factual. Don't editorialize.

### Step 4: Categorize

Assign one category tag based on the content:

| Category | Signals |
|----------|---------|
| AI | Machine learning, LLMs, AI tools, agents |
| Web Dev | Frontend, backend, frameworks, APIs |
| DevOps | Infrastructure, CI/CD, deployment, monitoring |
| Career | Growth, management, interviewing, culture |
| General | Everything else |

### Step 5: Save

Add to the reading list.

**Using {{notes}}**: Create an entry with fields: Title, URL, Summary, Category, Date Saved, Status (Unread).

**Markdown fallback**: Append to `~/.ai-workflow/reading-list.md`:

```markdown
## [Article Title](https://example.com/article)
- **Saved**: 2026-03-19
- **Category**: AI
- **Status**: Unread

Summary text here.

---
```

### Step 6: Confirm

Respond with a brief confirmation:

```
Saved: "Building Agents That Actually Work" (AI)
> 3-sentence summary here.
```

## Examples

**Save from URL:**
> read later: https://example.com/great-article

```
Saved: "Great Article Title" (Web Dev)
> The article covers new patterns for server components in React 19.
> Key insight: streaming SSR reduces TTFB by 40% in benchmarks.
> Useful for frontend engineers migrating from client-side rendering.
```

**Quick save:**
> interesting: https://example.com/ai-agents-2026

```
Saved: "AI Agents in 2026: What Changed" (AI)
> Overview of how agent architectures evolved over the past year.
> Main argument: tool-use reliability matters more than model size.
> Good context for anyone building or evaluating AI tooling.
```
