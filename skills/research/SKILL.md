---
name: research
description: Deep-dive research on a topic with multi-source synthesis and citations
---

# Research

## Trigger Phrases

- "research [topic]"
- "deep dive on [topic]"
- "synthesize [topic]"

## Inputs

The user provides a topic or question:
- A broad topic: "research React Server Components"
- A specific question: "research how other teams handle feature flag cleanup"
- A comparison: "research Zustand vs Jotai for our use case"
- A codebase question: "research how auth middleware works in this repo"

## Workflow

### Step 1: Clarify Scope

Assess the topic. If the request is clear and specific, proceed immediately. If ambiguous, ask one clarifying question — no more.

Good (proceed immediately):
- "research how to implement rate limiting in Express"
- "deep dive on React 19 cache API"

Needs clarification:
- "research databases" — too broad. Ask: "What aspect? Choosing one, optimizing queries, migration strategies?"
- "research the bug" — no context. Ask: "Which bug? Point me to a ticket or error message."

### Step 2: Search Sources in Parallel

Search all available sources simultaneously. Use whichever sources are accessible:

#### Web Search
- Search for the topic using web search
- Look for: official documentation, well-regarded blog posts, conference talks, GitHub discussions
- Prefer primary sources (official docs, RFCs, author posts) over secondary summaries
- Skip SEO-farm results and outdated content (check publication dates)

#### Codebase Search
- Search the current repository for related code, patterns, and prior art
- Use filename search and content search
- Look for: existing implementations, similar patterns, comments referencing the topic, related tests
- If the repo is part of a monorepo or org, note whether broader search might be useful

#### Docs Search
- Search `{{notes}}` for internal documentation, decision records, or previous research on the topic
- Look for: ADRs, RFCs, design docs, wiki pages, previous research briefs

### Step 3: Evaluate and Filter Sources

For each source found:
- Assess relevance (directly addresses the topic vs. tangentially related)
- Assess credibility (official docs > well-known authors > random blog posts)
- Assess freshness (recent > old, especially for fast-moving topics)
- Discard sources that are low-relevance, outdated, or unreliable
- Keep the top 5-10 most valuable sources

### Step 4: Synthesize Findings

Compile findings into a structured research brief:

```
## Research: [Topic]

### Summary
[2-3 sentence overview answering the core question or summarizing the topic]

### Key Findings
- [Finding 1 — the most important takeaway]
- [Finding 2]
- [Finding 3]
- [Continue as needed, typically 3-7 findings]

### Details
[Deeper explanation organized by subtopic. Use subheadings if the topic has natural divisions.
Include code examples where relevant. Reference specific sources inline.]

### Codebase Context
[What exists in the current codebase related to this topic. Prior art, existing patterns,
relevant files. Skip this section if no codebase results were found.]

### Trade-offs / Open Questions
[Unresolved questions, competing approaches, things the user should decide.
Present trade-offs neutrally — don't make the decision for the user.]

### Sources
1. [Source title](URL) — one-line description of what it contributes
2. [Source title](URL) — ...
[Include all sources referenced in the brief. Number them for easy reference.]
```

Rules for synthesis:
- Lead with the answer, then provide context. Don't build up to a conclusion
- State what's well-established vs. what's debated or uncertain
- When sources disagree, present both perspectives with attribution
- Include code examples only when they clarify the explanation
- Keep the brief scannable — someone should get the core message from Summary + Key Findings alone

### Step 5: Offer Next Steps

After presenting the brief, offer:
- "Want me to save this to your notes?" — if yes, save to `{{notes}}`
- "Want me to go deeper on any section?"
- "Want me to look at how [specific finding] applies to this codebase?"

If the user asks a follow-up question, incorporate the new findings into the existing brief rather than starting fresh.

## Notes

- Research quality depends on available sources. If web search is not available, the skill still works with codebase and docs — just note the limitation
- For codebase-only questions ("how does auth work in this repo"), skip web search entirely
- For time-sensitive topics (security vulnerabilities, breaking changes), emphasize the publication date of sources
- If the topic is well-covered by a single authoritative source (e.g., official docs), don't pad the brief with lower-quality sources. Link the primary source and summarize it
- Follow-up questions should refine the research, not restart it. Maintain context from the original brief

## Examples

**User**: "research React Server Components"
**Action**: Web search for RSC documentation, patterns, and gotchas. Search codebase for existing RSC usage. Search docs for any internal RSC decisions. Synthesize into a brief covering what RSC is, when to use it, trade-offs, and how it relates to the current codebase.

**User**: "deep dive on how other teams handle feature flag cleanup"
**Action**: Web search for feature flag lifecycle management and cleanup strategies. Search codebase for existing feature flag patterns. Search docs for any internal feature flag guidelines. Synthesize approaches with trade-offs.

**User**: "research Zustand vs Jotai for our use case"
**Action**: Web search for comparison articles, benchmarks, and real-world experience reports. Search codebase for current state management patterns. Present a neutral comparison organized by criteria (API simplicity, performance, ecosystem, migration effort).

**User**: "research how the payment flow works in this repo"
**Action**: Skip web search. Search codebase thoroughly for payment-related code, starting from routes/controllers and tracing through services. Search docs for payment-related documentation. Present findings as a flow walkthrough with key files and decision points.
