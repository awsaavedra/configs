---
name: diagnostic
description: Four diagnostic skills. /pre-mortem (or "what could go wrong", "before we commit", "imagine this fails") — assume failure already happened, reverse-engineer specific failure modes before commitment. /five-whys (or "what's the root cause", "why did this happen") — drill from surface to actionable root cause with evidence at each level. /feynman-test (or "do I actually understand this", "explain X simply") — audit comprehension by explaining without jargon; points where you reach for technical terms are the gaps. /decision-journal (or "log this decision", "track this prediction") — record decisions + predictions + confidence for later calibration review. Tool-agnostic.
---

# Diagnostic Skills

Four inquiry skills: failure imagination before commitment, root-cause drilling after, comprehension auditing, calibration tracking across time.

---

## Pre-Mortem

Assume the plan failed badly 6 months from now and reverse-engineer why. Assuming failure has *already happened* surfaces specific failure modes better than "what could go wrong?" Distinct from Steelyman (is the idea right?) and Five-Whys (after a real failure).

**Triggers:** `/pre-mortem`; "what could go wrong"; "before we commit"; "imagine this fails"; before major irreversible commitments.
**Don't use:** small reversible decisions; post-hoc analysis (use Five-Whys); no concrete plan yet.

### Flow
1. **State plan, success criteria, confidence.** Bet-grade. Can't name failure without naming success.
2. **Set failure scene.** "It's [6 months out], the plan failed badly." Specific shape: catastrophic, slow, partial?
3. **Generate 5-7 distinct failure modes.** Specific, not generic ("ran out of time" → "migration broke on unicode names we didn't anticipate"). Categories: technical, organizational, market, communication, scope, dependency. Pass condition: someone could write a specific check to catch it.
4. **For each: warning signal + preventive check.** Warning = first-4-week alert. Preventive = cheapest action now.
5. **Rank by likelihood × severity.** Focus revision on top 2-3.
6. **Revise plan.** Add warnings as metrics; add preventives as upfront work. If top failure is too large for cheap revision, reconsider the plan.

**Prompt seed:** Don't ask "what could go wrong?" — assume it failed and ask "why?" Specific failures suggest specific preventives.

---

## Five-Whys

After a real failure, drill through iterative "why?" — each level grounded in evidence — until reaching an actionable root cause. Mirror image of Pre-Mortem. "Five" is approximate: too shallow = surface fix, won't prevent recurrence; too deep = true but not actionable. Right level: 3-7 whys for most engineering incidents.

**Triggers:** `/five-whys`; "what's the root cause"; "why did this happen"; after incidents, recurring bugs, missed deadlines; when an earlier fix didn't stick.
**Don't use:** one-offs where surface fix is complete; speculative scenarios; blame conversations (finds causes, not people).

### Flow
1. **State surface problem concretely.** What / when / who affected / how noticed — specifics anchor every subsequent level.
2. **Why? — immediate cause, grounded in evidence.** Cite log line, commit, metric, test result. Speculation produces stories, not causes.
3. **Repeat, evidence at each level.** Continue until actionable: a process change, new test, monitoring addition, structural fix.
4. **Stop at right level.** Deepest cause that's changeable. Verify backward: does fixing root actually prevent the surface failure?

**Cause vs. story:** every event has many plausible narratives. Defenses: each why cites evidence; beware compound causes ("X and Y together") — often papering over uncertainty; "human error" is almost always a symptom, not a root.

**Prompt seed:** Drill surface to actionable root, evidence at each level. Stop when you reach something you can actually change.

---

## Feynman Test

Comprehension audit: explain a concept in plain language to a smart 12-year-old. Points where you reach for jargon are where *you* don't understand it. Iterative: identify gaps → research → re-explain → repeat until complete *and* accurate.

**Triggers:** `/feynman-test`; "do I actually understand this?"; "explain X simply"; before relying on a concept for a decision; before teaching it; when you suspect cargo-culted understanding.
**Don't use:** tacit skills (riding a bike); precision-required contexts (legal, proofs); public performance.

### Flow
1. **State the concept specifically.** "How Raft achieves leader election under partition" — not "distributed consensus."
2. **Explain without jargon.** Define every technical term before using it. No "basically" or "essentially" — these signal a skip. No appeals to authority instead of explanation ("X is true because [author] says so" is not understanding).
3. **Identify gaps.** Mark every place you hand-waved, reached for a term, waved at a source instead of explaining it, or can't answer "but why?" These are real gaps.
4. **Research gaps.** Read the source, run the example. Don't paper over.
5. **Re-explain end-to-end.** Not patches — full second pass; patches don't integrate.
6. **Repeat.** Pass condition: a 12-year-old could explain it back in their own words.

**Simple-and-correct vs. simple-and-wrong:** after simplifying, check — does the simplified version still produce correct predictions? If not, what got lost? Add it back.

**Prompt seed:** If you can't explain it without jargon to a smart 12-year-old, you have gaps where you reach for technical terms.

---

## Decision Journal

Log decisions + predictions + confidence; check back later; surface calibration patterns over time. Closes the loop between prediction and outcome that most people never close. Practice across time — not an in-conversation flow.

**Triggers:** `/decision-journal`; "log this decision"; "track this prediction"; "check back in N weeks"; before any decision with an evaluable expectation.
**Don't use:** trivial decisions; inherently unevaluable outcomes; decisions you don't want to scrutinize.

### Entry Format
**Date / Situation / Options considered / Decision (what + why) / Expected outcome** (specific + falsifiable: "ship in 3 weeks with <2 critical bugs in first month") **/ Confidence** (bet-grade %) **/ Check-in date** (far enough out for outcome to be observable).

### Check-In
Did it pan out? Was confidence calibrated (90% confident → right ~9/10)? What pattern is emerging? Grade on aggregate — individual outcomes have noise.

**Patterns to watch:** chronic overconfidence (technical scoping, projections); chronic underconfidence (new initiatives); misweighted considerations; high-surprise outcomes (highest-information entries).

**Make it sustainable:** entries 2 minutes max; set actual calendar reminders; backfill retroactively from emails/messages.

**Prompt seed:** Log decisions with predictions and confidence. The gap between predicted and observed reveals where your judgment is reliable and where it isn't.
