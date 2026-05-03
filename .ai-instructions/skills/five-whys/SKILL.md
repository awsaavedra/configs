---
name: five-whys
description: Root-cause Socratic for bugs, failures, and surprising outcomes. Drill down through "why?" iterations on a real event, each step grounded in evidence rather than speculation, until reaching an addressable root cause. Toyota Production System origin. Use when invoked as /five-whys, when the user asks "what's the root cause," "why did this happen," after an incident or bug, or when a surface fix doesn't address the underlying issue. Distinct from pre-mortem (failure imagination before), steelyman (adversarial review of a proposal), and you-sure (auditing a confident claim). The "five" is approximate — stop when you reach an actionable root, which may be three or seven whys deep. Tool-agnostic.
---

# five-whys

Toyota Production System technique. When something failed, drill down through iterative "why?" questions — each level grounded in evidence — until you reach a root cause that's actually addressable.

The "five" is approximate. The real rule: keep asking until you reach something you can change. Stopping too early gives you a surface fix that won't prevent recurrence; going too deep gives you a philosophical answer that isn't actionable.

## When to use

- `/five-whys` invocation with a specific incident or bug.
- "What's the root cause?" / "Why did this happen?"
- After incidents, outages, surprising production behavior, recurring bugs, missed deadlines.
- When a fix you applied earlier didn't actually prevent recurrence — that's a sign the surface cause wasn't the root cause.

**When not to use:**
- The surface fix IS the right fix. "Disk filled up" → "free up disk" is sometimes complete, especially for one-offs.
- Speculative scenarios — five-whys requires a real event with real evidence at each level.
- Blame conversations — five-whys finds *causes*, not *people responsible*. If the conversation drifts toward blame, name it and pull back.

## The flow

### 1. State the surface problem with concrete details

Not "the system broke." Specific:
- What happened? ("API returned 500 errors.")
- When? ("14:32 UTC on Tuesday.")
- Who/what was affected? ("Users in EU region; ~3% of traffic.")
- How was it noticed? ("Pager alert from latency monitor.")

Concrete details matter because each "why" answer must be grounded in evidence relating to those details.

### 2. Why? — first level

What's the *immediate* cause of the surface problem, grounded in evidence? Not "the deploy broke things" but "the deploy at 14:30 UTC introduced a regression in the auth middleware that caused 500s on authenticated requests." Each "why" answer should cite specific evidence: log line, commit, metric, test result. Speculation produces stories, not causes.

### 3. Why? — keep going

Repeat. Each level grounded in evidence. Continue until you reach something *actionable* — a process change, a new test, a monitoring addition, a structural fix.

### 4. Stop at the right level

Two failure modes:

- **Stopping too early.** "Why did the auth middleware regress?" → "Because of the caching change." Action: revert the caching change. But the underlying gap (no test for expired tokens) will reappear next time something similar ships.
- **Going too deep.** "Why didn't anyone flag the missing test?" → "Because our culture doesn't prioritize test rigor." Possibly true, but not actionable in the context of *this* incident.

The right level is the *deepest cause that's actionable*. For most engineering incidents, that's 3-7 whys.

### 5. Verify the chain

Run the chain backward: if you fix the root, does it actually prevent the surface failure? If not, the chain is a story, not a cause. Multiple causal chains often coexist; pick the one with strongest evidence at each level.

## The hard part: cause vs. story

Every event has many plausible causal stories. The trap is producing a *coherent narrative* that satisfies but isn't actually grounded.

Defenses:
- Each "why" must cite evidence (log, metric, commit, test, document).
- Beware compound answers ("X and Y together caused this"). Sometimes true; often a sign you're papering over uncertainty.
- Beware "human error" as a root cause. It's almost always a symptom. *Why* did the human err? What in the system enabled the error?

## Example

Surface: "We shipped a feature that crashed for 8% of users on first launch. Pager fired at 09:14 UTC, rolled back at 09:43."

> **Why 1:** Why did it crash? Logs show a NullPointerException in the user-preferences fetch. Evidence: error log line, stack trace pinned to commit abc123.
>
> **Why 2:** Why was the preferences fetch null? Because new users created in the last 30 days have a different schema (added `notification_settings` field), and the old code path doesn't handle the case where `notification_settings` is missing for older accounts. Evidence: schema diff in commit def456, query of affected users.
>
> **Why 3:** Why didn't the migration backfill `notification_settings` for older accounts? Because the migration was scoped to "new accounts only" to keep the change small. Evidence: migration script in commit def456.
>
> **Why 4:** Why didn't the test suite catch the missing-field case for older accounts? Because tests use only newly-seeded data; no fixture covers accounts predating the schema change. Evidence: review of test fixtures.
>
> **Why 5:** Why don't tests cover historical-account states? Because we don't have a pattern for fixturing migrations that left some accounts in old states. Evidence: search of test infra docs.
>
> **Stop here.** Why-5 is actionable: build a test pattern for partial-migration states. Going further ("why don't we have such a pattern? culture/process") would be true but not actionable in this incident.
>
> **Action:** add fixture pattern for partial-migration states; backfill `notification_settings` for all accounts; add test coverage. Also consider: should migrations be required to be exhaustive by default?

## See also

- `pre-mortem` — failure imagination *before* commitment, mirror image of five-whys.
- `argumentation-hygiene` — galaxy-brained reasoning is a real failure mode in causal chains; each level needs evidence, not just plausibility.
- `you-sure` — when you're confident in your root-cause story, audit the confidence before acting on it.

## Prompt seed

> Drill from surface to actionable root, evidence at each level. Stop when the cause is something you can actually change — not too shallow, not too deep.
