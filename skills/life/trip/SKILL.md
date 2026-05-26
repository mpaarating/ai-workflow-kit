---
name: trip
description: Trip planning with day-by-day itineraries and local recommendations
---

# Trip

Plan trips with day-by-day itineraries, food recommendations, and logistics. Iteratively refine until it feels right.

## Trigger Phrases

- "trip to [place]"
- "plan trip"
- "travel to [place]"
- "vacation to [place]"

## Workflow

### Step 1: Gather Basics

Extract from the user's message or ask:

- **Destination**
- **Dates** (or duration: "5 days in October")
- **Travelers** (solo, couple, family, group)

### Step 2: Ask Preferences

Before generating the itinerary, ask about (keep it to one quick question):

- **Pace**: Packed schedule vs. relaxed with downtime
- **Vibe**: Adventure, culture, food, relaxation, nightlife, nature
- **Budget**: Budget-friendly, mid-range, or splurge
- **Interests**: Any must-dos or must-avoids

If the user already provided preferences in their initial message, skip this step.

### Step 3: Generate Itinerary

Create a day-by-day plan. For each day include:

- **Morning / Afternoon / Evening** blocks
- Specific place names (neighborhoods, landmarks, restaurants)
- Practical notes: how to get there, estimated time, reservation tips
- One food recommendation per meal slot

Structure:

```
### Day 1: [Theme — e.g., "Historic Center"]
**Morning**: [Activity] — [details, location]
**Lunch**: [Restaurant/area] — [what it's known for]
**Afternoon**: [Activity]
**Dinner**: [Restaurant/area]
**Evening**: [Optional activity or downtime]
```

### Step 4: Add Logistics Section

After the itinerary, include:

- **Getting around**: Best transport options (metro, rideshare, walking, rental car)
- **Neighborhoods to stay in**: 2-3 options with trade-offs (central vs. budget vs. vibe)
- **Practical tips**: Currency, tipping norms, language basics, safety notes
- **Packing notes**: Weather-specific or activity-specific gear

### Step 5: Save

Save the complete plan.

**Using {{notes}}**: Create a page titled "[Destination] Trip — [Dates]" with the full itinerary.

**Markdown fallback**: Save to `~/.ai-workflow/trips/[destination]-[date].md`.

### Step 6: Iterate

After presenting the plan, ask: "Want to adjust anything — swap days, add rest time, more food spots?"

Accept refinements and update the saved plan. Common adjustments:

- Swap out activities
- Add more/fewer restaurant recommendations
- Shift pace (more downtime, more sightseeing)
- Add a day trip to a nearby town

## Examples

**Start planning:**
> trip to Lisbon, 4 days in May

```
Nice — Lisbon in May is great weather. Quick question before I build the itinerary:
What's your vibe? (adventure / food-focused / culture / relaxed mix)
```

**With preferences upfront:**
> plan a 5-day trip to Tokyo, food-focused, moderate budget, first time visiting

Generates a full 5-day itinerary focused on food neighborhoods (Tsukiji, Shinjuku, Shibuya), includes ramen rankings, izakaya recommendations, and a day trip to Kamakura.

**Refine:**
> day 3 looks too packed, can we swap the temple visit for free time?

Updates Day 3 with a lighter schedule and re-saves the plan.

**Quick trip:**
> weekend trip to Portland

Generates a 2-day plan with breweries, Powell's Books, food carts, and neighborhood walking routes.
