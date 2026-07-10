---
name: estimation
description: Time / cost / effort estimation heuristics — name what's actually being asked (estimate ≠ target ≠ commitment), reference class forecasting (outside view first), planning-fallacy and anchoring guards, ranges with bet-grade confidence over point estimates, sum distributions not midpoints, close the loop via decision-journal. Triggers: /estimate · "how long will this take" · "estimate this" · "what's the effort" · "can we hit <date>".
when_to_use: Sizing work before committing to it — after `planning` produces the tasks, before dates are promised. Every estimate is a prediction: log it via `diagnostic` §Decision-Journal and grade it at check-in; calibration feeds the next estimate. Not for decomposing the goal (planning), tracking the prediction afterwards (decision-journal), or analyzing observed data (data-analysis).
---

# Estimation

An estimate is a probability distribution, not a number. This skill sizes the tasks `planning` breaks down; `decision-journal` logs the predictions and closes the loop.

## Ask what's being asked
- **Estimate ≠ target ≠ commitment.** Estimate: what you believe. Target: what someone wants. Commitment: what you promise. Answering a target question with an estimate — or converting an estimate into a commitment without a decision — is the root estimation failure. Name which one is wanted before producing any number.
- **Wrong-question detection** — "how long for X?" often hides "is X worth doing?" · "what fits by <date>?" · "can I hold someone to this?". Answer the real question; scope-to-date inverts the problem honestly (fix the date, float the scope).

## Outside view first
- **Reference class forecasting** — before reasoning about the task's internals, find what comparable work *actually took*: git history, past projects, team baselines. The outside view prices in the unknown-unknowns the inside view can't enumerate.
- Adjust from the reference class only for **named** differences — each adjustment stated and sized, never vibes.
- No reference class → say so: the estimate is low-confidence by construction, and the first task is a calibrating spike (`planning` §Sequencing).

## Guards
- **Planning fallacy** — the unguarded human default is the best case: the inside view assumes nothing goes wrong, and nothing-going-wrong is the rarest outcome. Correct with the reference class, not padding.
- **Anchoring** — the first number spoken owns the room. Produce your estimate *before* reading the requester's date or budget; if one was already given, write yours down first, then reconcile out loud.
- **Silent padding** — hidden buffer corrupts the record the next reference class is built from. State the range openly instead; honesty compounds, padding doesn't.

## Ranges, not points
- Give **P50 / P90**: "50% by 3 weeks, 90% by 6" — a bare point estimate hides which one it is (usually P10).
- Width is information: a wide range on genuinely uncertain work is the honest answer, not indecision. Never narrow a range to look decisive — bet-grade check: would you bet at those odds?
- Decompose (`planning` §Breakdown) and estimate the leaves; **sum distributions, not midpoints** — the sum of P50s lands far below the P50 of the sum.

## Close the loop
- Log every estimate as a prediction with confidence and a check-in date → `diagnostic` §Decision-Journal.
- Re-estimate on new information — the cone of uncertainty narrows as work proceeds; a stale estimate is a wrong estimate. Announce revisions; don't let a dead number stand.
- Chronic bias surfaced at check-in (overconfidence on technical scoping is the classic) becomes a named adjustment in the next estimate.

## Output
```
## Estimate: <task>
Question asked: estimate | target | commitment | scope-to-date
Reference class: <comparable work → observed durations | none — spike scheduled>
P50: <…>   P90: <…>
Named adjustments: <difference → size>
Logged: decision-journal entry, check-in <date>
```

## Gates
- The question named (estimate / target / commitment) before any number.
- Reference class cited, or its absence declared and a spike scheduled.
- Range with explicit confidence — never a bare point.
- Prediction logged with a check-in date.
