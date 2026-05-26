---
name: research
description: Deep-dive research on a topic — searches web, codebase, and notes in parallel, then synthesizes into a brief with cited sources and trade-offs.
---

# Research

## Trigger Phrases

- "research [topic]"
- "deep dive on [topic]"
- "synthesize [topic]"

Input can be a broad topic, a specific question, a comparison ("Zustand vs Jotai"), or a codebase question ("how does auth middleware work in this repo").

## Workflow

1. **Clarify scope** only if the request is genuinely ambiguous. Ask at most one clarifying question, then proceed. "research databases" needs scoping; "research React 19 cache API" doesn't.

2. **Search in parallel:**
   - **Web** — official docs, well-regarded blog posts, conference talks, GitHub discussions. Prefer primary sources. Skip SEO-farm content and stale results.
   - **Codebase** — existing implementations, similar patterns, related tests, comments referencing the topic.
   - **{{notes}}** — internal ADRs, RFCs, design docs, previous research briefs.

   For codebase-only questions ("how does the payment flow work here?"), skip web search entirely.

3. **Filter sources** by relevance, credibility (official docs > known authors > random blogs), and freshness. Keep the top 5–10.

4. **Synthesize into a structured brief.** Lead with the answer, then context — don't build up to a conclusion. Note what's well-established vs. debated. Present competing approaches neutrally.

   ```
   ## Research: [Topic]

   ### Summary
   [2–3 sentences answering the core question]

   ### Key Findings
   - [Finding 1 — the most important takeaway]
   - [Finding 2]
   - [Finding 3]

   ### Details
   [Deeper explanation by subtopic. Code examples only when they clarify.]

   ### Codebase Context
   [Prior art, existing patterns, relevant files. Skip if no codebase results.]

   ### Trade-offs / Open Questions
   [Unresolved questions, competing approaches, decisions for the user. Stay neutral.]

   ### Sources
   1. [Title](URL) — one-line description
   ```

5. **Offer next steps**: save the brief to {{notes}}, go deeper on a section, or apply a specific finding to the codebase. Follow-ups should refine the existing brief, not restart it.

## Notes

- Quality depends on available sources. If web search isn't available, note the limitation and continue with codebase + notes.
- For time-sensitive topics (CVEs, breaking changes), emphasize publication dates.
- If a single authoritative source covers the topic, don't pad with weaker sources — link the primary and summarize.
