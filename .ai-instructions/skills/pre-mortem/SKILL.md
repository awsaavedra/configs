---
name: pre-mortem
description: Failure-mode imagination before a commitment. Klein's pre-mortem technique — assume the project failed and reverse-engineer why. State the plan, success criteria, and current confidence; imagine 6 months from now this failed badly and generate 5-7 specific failure modes; for each, name the early-warning signal and the cheapest preventive check; revise the plan toward addressing the most likely failures. Use when invoked as /pre-mortem, when the user says "what could go wrong," "before we commit to this," "imagine this fails," or before any major commitment (architecture, product launch, public writing, hiring, scoping). Distinct from steelyman (adversarial review of a proposal), five-whys (root-cause analysis after failure), and you-sure (auditing a confident claim). Tool-agnostic.
---

# pre-mortem

Gary Klein's technique. Before committing to a plan, imagine that the plan failed badly six months from now, and reverse-engineer why. The trick: assuming failure has *already happened* makes specific, concrete failure modes much easier to imagine than asking "what could go wrong?" abstractly.

Distinct from related skills: this is failure-imagination *before* the fact, not adversarial review (`steelyman`) or root-cause analysis after a real failure (`five-whys`).

## When to use

- `/pre-mortem` invocation with a plan or decision specified.
- "What could go wrong" / "before we commit" / "imagine this fails."
- Before major irreversible commitments: architecture decisions, product launches, public writing, hiring, scoping a quarter, organizational restructures.
- After `steelyman` review survives: pre-mortem catches different failures than adversarial review (which focuses on whether the *idea* is right; pre-mortem focuses on whether the *execution* will hold).

**When not to use:**
- Small reversible decisions where the cost of being wrong is low.
- After-the-fact analysis (use `five-whys`).
- When you don't actually have a plan yet — pre-mortem requires something concrete enough to fail.

## The flow

### 1. State the plan, success criteria, and confidence

- **Plan:** what's being committed to. Specific enough to fail in identifiable ways.
- **Success criteria:** what does "success" look like, concretely? If you can't name success, you can't name failure.
- **Current confidence:** high / medium / low. Bet-grade.

### 2. Set the failure scene

"It's [date 6 months from now]. The plan failed badly. What does the failure look like?" Be specific: did it fail catastrophically, slowly, partially, embarrassingly? Different failure shapes have different causes.

### 3. Generate 5-7 distinct failure modes

Not generic ("we ran out of time"). Specific:

- "The data migration broke when the legacy customer table had unicode names we didn't anticipate."
- "The new API hit rate-limits we didn't know about because our load test under-counted real-world bursty traffic."
- "Two senior engineers left for unrelated reasons mid-project, and the remaining team didn't have enough context to finish."

Cover different categories — technical, organizational, market, communication, scope, dependency.

### 4. For each failure mode: warning signal + preventive check

- **Early-warning signal:** what would have alerted you in the first 4 weeks? (Often: a metric you weren't tracking, a stakeholder who wasn't pulled in, a test you didn't run.)
- **Preventive check:** what's the cheapest thing to do *now* that would either prevent this failure or surface it earlier?

The cheapest checks usually pay for themselves many times over.

### 5. Rank by likelihood × severity

Not all failure modes are equal. A high-likelihood mild failure may matter less than a low-likelihood catastrophic one. Rank, then focus revision on the top 2-3.

### 6. Revise the plan

Concrete changes: add the warning signals as monitored metrics, add the preventive checks as upfront work, adjust scope or sequencing to make the worst failure modes less likely or less catastrophic.

If the top failure mode is large enough that no cheap revision addresses it, consider whether the plan should be substantially rethought rather than incrementally adjusted.

## The hard part: specific failures

Generic failure modes ("we ran out of time") are useless because they don't suggest specific preventives. Specific failure modes ("we ran out of time because the data migration took 3x estimate, because we didn't realize the legacy DB had no indexes on the join columns") suggest specific preventives ("audit the legacy DB schema in week 1").

Pass condition for a failure mode: someone could write a specific test or check that would catch it.

## Pre-mortem vs. steelyman

Both are adversarial moves before commitment, but they catch different failures:

- **Steelyman:** is the *idea* right? Are you solving the right problem? Are there better approaches?
- **Pre-mortem:** assuming the idea is right and you're committed to it — what specific failures of *execution* are most likely?

Use steelyman for "is this the right thing to do?" and pre-mortem for "given we're doing this, what'll go wrong?" Both are often valuable on the same plan.

## Example

Plan: "We'll launch a new pricing tier next month. Success: 100 customers in first 30 days, $50k MRR."

> **1. Confidence:** medium (we've never launched a paid tier before).
>
> **2. Failure scene.** Six months from now: we launched, sold 12 customers in 90 days, churned half of them, team is demoralized.
>
> **3. Failure modes:**
> 1. Pricing was wrong — tier priced too high for value delivered or too low to attract serious buyers.
> 2. Marketing reached the wrong audience — people we got to sign up weren't who the product was for.
> 3. Onboarding broke at scale — first 5 customers got hand-holding, customers 6-50 didn't, and they churned because setup was hard.
> 4. Sales cycle was longer than expected — enterprise customers needed legal review we didn't anticipate, 30-day target unrealistic.
> 5. The "problem" we thought we were solving wasn't the problem customers cared about — close-but-not-quite product-market fit.
> 6. A competitor launched a similar tier the same week and out-marketed us.
> 7. Internal politics — sales team didn't push the new tier because it cannibalized their existing commission structure.
>
> **4. Warnings + preventives (top 3 by likelihood × severity):**
> - **#3 onboarding break:** warning = drop in activation rate after first 10 customers. Preventive = build self-serve onboarding now, before launch, even basic.
> - **#5 wrong problem:** warning = customer feedback "this is nice but it's not really what we need." Preventive = 5 customer development calls *this week* before launching.
> - **#7 sales misalignment:** warning = sales rep responses to launch announcement. Preventive = align commission structure before launch, with sales team input.
>
> **5. Revised plan.** Push launch by 2 weeks; spend that time on (a) self-serve onboarding, (b) 5 customer interviews, (c) sales commission alignment. The cost of the delay is far smaller than the cost of any of the top failures.

## See also

- `steelyman` — adversarial review *before* deciding to commit. Use both on important plans.
- `five-whys` — root-cause analysis *after* a real failure. Mirror image of pre-mortem.
- `argumentation-hygiene` — galaxy-brained failure-mode generation is a real risk; ground each mode in evidence about the specific plan, not generic project-failure stories.

## Prompt seed

> Don't ask "what could go wrong?" — assume it failed and ask "why did it fail?" Specific failures suggest specific preventives; generic failures suggest nothing.
