---
name: decision-journal
description: Record-keeping practice for calibration. When making a non-trivial decision, log the situation, options considered, decision made, expected outcome, stated confidence, and check-in date. Later, evaluate did-it-pan-out and was-confidence-calibrated. Over time, surfaces patterns in your own biases (chronic overconfidence on technical scoping, underconfidence on social dynamics, etc.). Use when invoked as /decision-journal, when the user says "log this decision," "track this prediction," "let's check back in N weeks," before any decision with a stated expectation that's worth auditing later. Different cluster from the in-conversation skills — this is a practice across time. Tool-agnostic.
---

# decision-journal

Record-keeping for calibration. Most people make decisions, observe outcomes, and never connect the two — leaving them blind to systematic biases in their own judgment.

A decision journal closes the loop: when making a non-trivial decision, you record what you decided, what you expected to happen, and how confident you were. Later, you check back and evaluate. Over time, the journal reveals patterns ("I'm chronically overconfident on technical scoping; I'm underconfident on social dynamics") that no in-the-moment check could find.

This skill is a *practice across time*, not an in-conversation flow. The other skills in this set probe one decision in detail; this one tracks decisions in aggregate.

## When to use

- `/decision-journal` to log a new entry or check in on existing ones.
- Before any decision with a stated, evaluable expectation:
  - Technical scoping ("this will take 2 weeks").
  - Hiring choices ("this candidate will work out").
  - Product bets ("users will care about feature X").
  - Forecasts about external events.
- "Log this decision" / "track this prediction" / "let's check back in N weeks."

**When not to use:**
- Trivial decisions where the outcome doesn't matter for future calibration.
- Decisions whose outcomes are inherently unevaluable (philosophical choices, identity decisions).
- Personal-life decisions you don't want to scrutinize systematically — this is a tool, and like any tool it should be used where it serves.

## The format

Each entry has:

- **Date:** when the decision was made.
- **Situation:** brief context. What's the choice point?
- **Options considered:** what were the real alternatives?
- **Decision:** what was chosen, and why.
- **Expected outcome:** *specific, falsifiable* prediction. Not "this should go well" but "we'll ship in 3 weeks with no more than 2 critical bugs reported in the first month."
- **Confidence:** percentage. Bet-grade — you'd actually take the corresponding odds.
- **Check-in date:** when to evaluate. Should be far enough out that the outcome is observable.

## The check-in

When the check-in date arrives:

- **Did it pan out?** Compared to the expected outcome, was the prediction right, partially right, or wrong?
- **Was confidence calibrated?** Across many decisions at the same confidence level, the hit rate should match (90% confident → right ~9 times in 10).
- **What does this decision teach me?** What pattern is emerging? Am I systematically biased in some direction?

Don't grade harshly on individual decisions — outcomes have noise. The signal is in the aggregate.

## Patterns to watch for

Over a dozen or so entries, look for:

- **Chronic overconfidence on a category.** Common: technical scoping, sales projections, "this will be quick."
- **Chronic underconfidence on a category.** Common: pessimism about new initiatives that turn out fine.
- **Misweighted considerations.** Looking back, what factor turned out to matter that you under-weighted at the time? What did you over-weight?
- **Outcome surprises.** Decisions where the outcome was very different from expected — what did you not see? These are the highest-information entries.

## The hard part: actually doing it

Most people start a decision journal and stop within a month. The return is delayed (you don't see patterns until you have many entries) and the discipline is unrewarded in the moment.

Defenses:
- **Make entries short.** A complete entry should take 2 minutes, not 20. Long-form journaling makes the practice unsustainable.
- **Set the check-in dates as actual calendar reminders.** Journal entries without check-in reminders go unread.
- **Evaluate retroactively even if you forgot in the moment** — old emails, slack messages, and project plans often have enough decision-context to backfill an entry.

## Example entry

> **Date:** 2026-04-15
> **Situation:** Deciding whether to rewrite the auth service or do incremental improvements.
> **Options considered:** (a) full rewrite, 8-week project; (b) incremental hardening, ongoing; (c) leave it alone for 6 months and revisit.
> **Decision:** (b) incremental hardening, with 4 specific work items prioritized for the next 6 weeks.
> **Expected outcome:** Critical bug rate drops from current ~2/month to <1/month within 6 weeks. No major incidents in next 90 days. Team morale doesn't degrade.
> **Confidence:** 65%. Mainly worried about hidden bugs we don't know about yet.
> **Check-in:** 2026-07-15 (3 months out).

**Check-in entry (2026-07-15):**

> Outcome: critical bug rate dropped to 0.7/month (better than target). One major incident occurred (auth token expiry bug, 4 hours of downtime), which would have happened either way. Team morale fine.
>
> Calibration: 65% was about right — the prediction was mostly correct, but I missed the auth token bug entirely and that's a real miss. Adjusted-down to "I didn't actually have a model of which bugs were lurking."
>
> Pattern: this is the third time I've underestimated lurking bugs in unfamiliar subsystems. Going forward: when scoping work in a subsystem I haven't deeply read, add a discovery phase.

## See also

- `argumentation-hygiene` — the "calibration tracking" self-audit check assumes data from somewhere. This skill produces it.
- `pre-mortem` — pre-mortem failure modes can be added to journal entries as "things I expected might fail."
- `you-sure` — when revisiting a confident past claim, the journal entry tells you what you actually predicted, free of hindsight.

## Prompt seed

> Log decisions with predictions and confidence. Check back. Over time, the gap between what you predicted and what happened reveals where your judgment is reliable and where it isn't.
