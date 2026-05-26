---
name: trip
description: Plan trips with day-by-day itineraries, food recommendations, and logistics. Iteratively refines until it feels right.
---

# Trip

## Trigger Phrases

- "trip to [place]"
- "plan trip"
- "travel to [place]"
- "vacation to [place]"

## Workflow

1. **Gather basics** from the user's message (or ask): destination, dates or duration, travelers (solo / couple / family / group).

2. **Ask preferences in one quick prompt** — skip if the user already gave them upfront:
   - **Pace**: packed vs. relaxed
   - **Vibe**: adventure / culture / food / relaxation / nightlife / nature
   - **Budget**: budget / mid-range / splurge
   - **Must-dos or must-avoids**

3. **Generate the day-by-day itinerary.** Each day has Morning / Afternoon / Evening blocks with specific place names, neighborhoods, restaurants, and practical notes (how to get there, time estimates, reservation tips). One food recommendation per meal slot.

   ```
   ### Day 1: [Theme]
   **Morning**: [Activity] — [details, location]
   **Lunch**: [Restaurant/area] — [what it's known for]
   **Afternoon**: [Activity]
   **Dinner**: [Restaurant/area]
   **Evening**: [Optional activity or downtime]
   ```

4. **Add a logistics section** after the itinerary:
   - **Getting around** — best transport (metro, rideshare, walking, rental)
   - **Where to stay** — 2–3 neighborhood options with trade-offs (central / budget / vibe)
   - **Practical tips** — currency, tipping, language basics, safety
   - **Packing notes** — weather-specific or activity-specific

5. **Save** to {{notes}} as a page titled `[Destination] Trip — [Dates]`. Fallback: `~/.ai-workflow/trips/[destination]-[date].md`.

6. **Iterate.** After presenting, ask: "Want to adjust anything — swap days, add rest time, more food spots?" Accept refinements (swap activities, shift pace, add a day trip) and update the saved plan.
