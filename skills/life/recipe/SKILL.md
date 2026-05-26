---
name: recipe
description: Save, organize, and search recipes from URLs, text, or dictation
---

# Recipe

Save recipes from anywhere — URLs, pasted text, or just telling the AI what you made. Search by ingredient or cuisine later.

## Trigger Phrases

- "recipe:"
- "save recipe"
- "add recipe"
- "cooking:"

## Workflow

### Saving from a URL

1. Fetch the page and extract the recipe, stripping ads and life-story preamble
2. Parse into structured fields (see format below)
3. Save and confirm

### Saving from text or dictation

1. Parse the provided text into structured recipe format
2. Ask for any missing required fields (title, ingredients, steps)
3. Save and confirm

### Recipe Format

Every saved recipe includes:

- **Title**
- **Cuisine**: Italian, Mexican, Thai, Indian, American, Japanese, etc.
- **Meal type**: Breakfast, Lunch, Dinner, Snack, Dessert
- **Difficulty**: Easy, Medium, Hard
- **Prep time** / **Cook time**
- **Servings**
- **Ingredients**: Listed with quantities
- **Steps**: Numbered instructions
- **Source**: URL or "personal" if from text/dictation
- **Notes**: Optional — substitutions, tips, tweaks

### Searching recipes

When the user asks to find a recipe (e.g., "what can I make with chicken?", "any Italian recipes?"):

1. Search saved recipes by ingredient, cuisine, meal type, or keyword
2. Return a short list with title, cuisine, prep time, and difficulty
3. Offer to show the full recipe for any match

### Scaling servings

When asked to scale (e.g., "double that recipe", "make it for 6"):

1. Calculate the scaling factor from current to desired servings
2. Adjust all ingredient quantities
3. Display the scaled ingredients list
4. Note: cooking times may need adjustment for significantly different quantities

### Storage

**Using {{notes}}**: Store each recipe as a page with the fields above.

**Markdown fallback**: Save to `~/.ai-workflow/recipes/` as individual markdown files, named by slugified title (e.g., `chicken-tikka-masala.md`).

## Examples

**Save from URL:**
> recipe: https://example.com/best-carbonara

```
Saved: "Spaghetti Carbonara"
Italian | Dinner | Easy | 25 min | Serves 4
```

**Save from dictation:**
> recipe: my mom's banana bread — 3 bananas, 1/3 cup melted butter, 3/4 cup sugar, 1 egg, 1 tsp vanilla, 1 tsp baking soda, pinch salt, 1.5 cups flour. Mash bananas, mix wet, mix dry, combine, bake 350 for 60 min.

```
Saved: "Mom's Banana Bread"
American | Dessert | Easy | 75 min | Serves 8
```

**Search:**
> what chicken recipes do I have?

```
1. Chicken Tikka Masala — Indian | Dinner | Medium | 45 min
2. Grilled Chicken Salad — American | Lunch | Easy | 20 min
```

**Scale:**
> double the carbonara recipe

Displays all ingredients with doubled quantities and updated serving count.
