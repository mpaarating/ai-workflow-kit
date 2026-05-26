---
name: watchlist
description: Track movies and shows — add, mark watched, rate, and get mood-based suggestions from your list.
---

# Watchlist

## Trigger Phrases

- "want to watch [title]" / "add to watchlist"
- "finished [title]" / "watched [title]"
- "rate [title] [1-5]"
- "what should I watch" / "show my watchlist"

## Workflow

Pick the mode based on the trigger.

### Mode: add ("want to watch Severance")

Identify title and type (Movie/Show). Ask for or infer genre tags from: Action, Comedy, Drama, Horror, Sci-Fi, Documentary, Thriller, Animation, Romance. Status defaults to **To Watch**.

```
Added: "Severance" (Sci-Fi, Thriller) — To Watch
```

### Mode: mark watched ("finished Severance")

Find it in the watchlist, set status **Watched** with today's date. Ask for rating (1–5) and an optional one-line review if not given.

Rating scale: 5 = loved it, 4 = really good, 3 = decent, 2 = disappointing, 1 = skip it.

```
Updated: "Severance" — Watched (5/5) "Incredible"
```

### Mode: rate something new ("rate Oppenheimer 4/5")

If not in the list, add as **Watched** with the rating and review in one step.

### Mode: suggest ("what should I watch — something light")

Show unwatched items grouped by genre. Map mood to genres and filter:

- "light" → Comedy, Animation, Romance
- "intense" → Thriller, Horror, Drama
- "smart" → Sci-Fi, Documentary, Drama
- "fun" → Action, Comedy, Animation

Suggest 1–3 matches. If no matches or list is empty, offer to add something.

## Storage

{{notes}} as a database with: Title, Type, Genre, Status, Rating, Review, Date Added, Date Watched. Fallback: `~/.ai-workflow/watchlist.md` with To Watch / Watched sections.
