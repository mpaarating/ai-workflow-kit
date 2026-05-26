---
name: watchlist
description: Track movies and shows — add, rate, and get recommendations
---

# Watchlist

Track what you want to watch, rate what you've seen, and get suggestions based on your taste.

## Trigger Phrases

- "want to watch"
- "add to watchlist"
- "watching [title]"
- "finished [title]"
- "rate [title]"

## Workflow

### Adding to watchlist

When the user mentions a movie or show they want to watch:

1. Identify the title (and whether it's a movie or show)
2. Ask for or infer genre tags: Action, Comedy, Drama, Horror, Sci-Fi, Documentary, Thriller, Animation, Romance
3. Add to watchlist with status "To Watch"
4. Confirm: `Added: "Severance" (Sci-Fi, Thriller) — To Watch`

### Marking as watched

When the user says they finished or watched something:

1. Find the title in the watchlist
2. Update status to "Watched" with today's date
3. Ask for a rating (1-5) and optional one-line review
4. If no rating given, prompt: "How was it? (1-5)"
5. Confirm: `Updated: "Severance" — Watched (4/5) "Incredible world-building"`

### Rating

When the user rates something not yet in the list:

1. Add it as "Watched" with the rating
2. Accept optional review text
3. Confirm the entry

Rating scale: 5 (loved it), 4 (really good), 3 (decent), 2 (disappointing), 1 (skip it)

### Listing and suggestions

When asked "what should I watch" or "show my watchlist":

1. Show unwatched items grouped by genre
2. If the user mentions a mood, map it to genres and filter:
   - "something light" → Comedy, Animation, Romance
   - "something intense" → Thriller, Horror, Drama
   - "something smart" → Sci-Fi, Documentary, Drama
   - "something fun" → Action, Comedy, Animation
3. Suggest 1-3 matching titles from their list
4. If no matches or list is empty, offer to add something

### Storage

**Using {{notes}}**: Store as a database with fields: Title, Type (Movie/Show), Genre, Status (To Watch/Watching/Watched), Rating, Review, Date Added, Date Watched.

**Markdown fallback**: Store in `~/.ai-workflow/watchlist.md`:

```markdown
## To Watch
- **Severance** (Show) — Sci-Fi, Thriller — Added Mar 19

## Watched
- **The Brutalist** (Movie) — Drama — 4/5 — "Ambitious and gorgeous" — Mar 15
```

## Examples

**Add to watchlist:**
> want to watch The White Lotus

```
Added: "The White Lotus" (Show) — Comedy, Drama — To Watch
```

**Finish and rate:**
> finished Severance, it was incredible. 5/5

```
Updated: "Severance" — Watched (5/5) "Incredible"
```

**Get suggestion:**
> what should I watch tonight? something light

```
From your watchlist:
1. The White Lotus — Comedy, Drama
2. Poker Face — Comedy, Mystery

Both are lighter shows. Want to start one?
```

**Quick rating for something not on the list:**
> rate Oppenheimer 4/5 — stunning visuals but long

```
Added: "Oppenheimer" (Movie) — Drama — Watched (4/5) "Stunning visuals but long"
```
