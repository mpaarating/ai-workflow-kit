---
name: recipe
description: Save, organize, search, and scale recipes from URLs, pasted text, or dictation. Strips ads and preamble; saves structured fields.
---

# Recipe

## Trigger Phrases

- "recipe: [url or text]"
- "save recipe"
- "add recipe"
- "cooking: [text]"

Plus follow-up triggers: "what can I make with [ingredient]?", "any [cuisine] recipes?", "double that recipe", "make it for 6".

## Workflow

Pick the mode based on input.

### Mode: save from URL

Fetch the page, strip ads and life-story preamble, extract the structured recipe.

### Mode: save from text or dictation

Parse the provided text. Ask for any missing required fields (title, ingredients, steps).

### Recipe format

Every saved recipe stores:

- **Title**
- **Cuisine** — Italian / Mexican / Thai / Indian / American / Japanese / ...
- **Meal type** — Breakfast / Lunch / Dinner / Snack / Dessert
- **Difficulty** — Easy / Medium / Hard
- **Prep time / Cook time / Servings**
- **Ingredients** — with quantities
- **Steps** — numbered
- **Source** — URL, or "personal"
- **Notes** (optional) — substitutions, tips, tweaks

### Mode: search

When the user asks to find a recipe, search saved entries by ingredient, cuisine, meal type, or keyword. Return a short list with title, cuisine, prep time, difficulty. Offer to show any full recipe.

### Mode: scale

Compute the scaling factor from current to desired servings. Adjust all ingredient quantities. Cooking times may need separate adjustment for significantly different quantities — flag it.

## Storage

{{notes}} as a page per recipe with the fields above. Fallback: individual markdown files in `~/.ai-workflow/recipes/`, named by slugified title.

## Confirmation format

```
Saved: "Spaghetti Carbonara"
Italian | Dinner | Easy | 25 min | Serves 4
```
