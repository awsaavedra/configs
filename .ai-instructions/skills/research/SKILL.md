---
name: research
description: Multi-source web research agent. Search, cross-validate, cite, report gaps. Triggers: research · compare · benchmark · literature review · best X for · landscape of · what does evidence say
when_to_use: Any topic investigation, tool comparison, literature review, or evidence-backed report.
---

# Research

```
DECOMPOSE → SEARCH → VALIDATE → SYNTHESIZE → GAP-CHECK
```

```
decompose   query → sub-questions
search      3–5 queries each; papers > docs > repos > blogs
validate    2+ sources/claim; conflict → report both
synthesize  structured report, every fact cited inline
gap-check   list what could not be verified
```

## Rules
```
think first   plan before querying
verify        no unsourced assertions
increment     refine from results, don't batch-blast
no fabrication  missing → say so; never invent stats/dates/quotes
```

## Search Patterns
```
<topic> site:github.com OR arxiv.org
<topic> official documentation
<topic> paper 2024 OR 2025 OR 2026
<topic> vs <alt> benchmark
<topic> limitations criticism
```
Short keyword queries only. Split multi-entity queries.

## Output
```markdown
# Research Report: [Topic]
## Summary          [2–3 sentences. Confidence: High/Medium/Low]
## Findings         [2–4 sentences/sub-topic. Cite as [1][2].]
## Comparison       | Option | Strengths | Weaknesses | Best For |
## Recommendation   Primary/Alternative/Avoid — [reason each]
## Gaps             [unverified or conflicting claims]
## Sources          1. [Title](url)
```

## Gates
```
[ ] every stat cited
[ ] conflicts not co-asserted as fact
[ ] recs derived from findings not priors
[ ] gaps populated
```

## Depth
```
quick    3–5 sources
standard 8–12 sources  ← default
deep     15+ sources
```

## Triggers
> research · compare · benchmark · literature review · best X for · landscape of · what does evidence say

---

> Source material: https://github.com/karpathy/autoresearch
