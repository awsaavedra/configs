---
name: planning
description: Turn an ambiguous goal into a structured plan — definition-of-done, hierarchical breakdown (outcome → milestones → tasks), dependency mapping, riskiest-assumption-first sequencing, prioritization (MoSCoW, RICE / ICE, opportunity cost, NOT-doing list). Triggers: /planning · "break this down" · "plan this" · "scope this" · "where do we start" · "what should we do first".
when_to_use: A goal too big or vague to start — before work is routed or estimated. Produces the breakdown that `delegation-ladder` routes; pairs with `diagnostic` §Pre-Mortem (stress-test the plan) and §Decision-Journal (log its predictions). Not for routing existing tasks (delegation-ladder) or chasing a failure (debug).
---

# Planning

A plan is a falsifiable claim about how a goal decomposes — not a wish list. This skill produces the breakdown; `delegation-ladder` routes it, `estimation` sizes it, `pre-mortem` stress-tests it, `decision-journal` logs its predictions.

## Definition of done
- Restate the goal as a **verifiable outcome** — observable evidence, not activity ("users can export CSV", not "work on export").
- Can't state done → clarifying the goal *is* the first task; don't decompose a fog.
- Every level carries its own done-check: outcome → milestone → task.

## Breakdown
- Decompose outcome → milestones → tasks; stop when a leaf is one sitting's work with an obvious verification.
- Each node answers "why does the parent need this?" — a node with no answer is scope creep.
- Tag each task with its level per `delegation-ladder` (A / P / C); a mixed-level task splits.

## Dependencies
- Map blockers explicitly; everything unmapped is parallel by default.
- The critical path gets the attention; slack elsewhere is free schedule.
- Surface hidden dependencies: shared people · environments · pending decisions · external approvals.

## Sequencing
- **Riskiest assumption first** — highest-information work while changing course is cheap (pairs with `pre-mortem`).
- **Walking skeleton** — thinnest end-to-end slice before fattening any stage.
- Cheap experiment before big build: a spike answering "is this feasible?" beats a milestone discovering it isn't.

## Prioritization
- **MoSCoW** — Must / Should / Could / **Won't (this iteration)**; the Won't is a decision — record it.
- **RICE / ICE** — Reach × Impact × Confidence ÷ Effort to compare candidates; scores rank, humans decide.
- **Opportunity cost** — every yes is a no to the next-best alternative; name what the yes displaces.
- **NOT-doing list** — explicit and written; the plan's most load-bearing section.

## Output
```
## Plan: <goal>
Done when: <verifiable outcome>
Riskiest assumption: <…> — tested by <first task>
M1 <milestone> — done when <check>
  [A|P|C] <task> — depends: <… | none> — done when <check>
Won't do: <…>
```

## Gates
- Done-check at every level — verifiable, not aspirational.
- Riskiest assumption named and scheduled first.
- NOT-doing list present.
- Every leaf routable per `delegation-ladder` without further decomposition.
