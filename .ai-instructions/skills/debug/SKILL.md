---
name: debug
description: >
  Use before proposing any fix for bugs, errors, unexpected behavior, test
  failures, build failures, performance regressions, memory issues, or
  concurrency problems.
  Auto-triggers on: "debug this", "fix this bug", "why isn't this working",
  "value is null", "not updating", "investigate this", "tests failing",
  "slow", "memory leak", "race condition", "flaky test", "broken build".
---

# Debug Skill

## Mode
Default: autonomous. Args: `/debug` (auto), `/debug ask` (approval-gated).
- **auto** — invoking the skill IS the approval. Run `/compact`, apply fix, add guard test, modify lint/CI. Only Phase 4 attempt 3+ requires human input (already required below).
- **ask** — propose mutating actions; user confirms each. Read-only inspection, diagnostic logging, and test runs proceed without prompts in either mode.

## Three Iron Laws
1. **NO fix without confirmed root cause.** Symptom patches are failure.
2. **NO completion claim without fresh verification evidence.** "Should work" is not evidence.
3. **ELIMINATE hypotheses with minimum evidence; never confirm a favorite.** Test to disprove, not to validate.

## Stop-the-Line Rule
When ANYTHING unexpected happens:
- STOP all other changes immediately — errors compound, a bug in step 3 makes steps 4–10 wrong
- PRESERVE evidence: error output, logs, exact repro steps
- Follow the phases below in order
- RESUME only after Phase 5 verification passes

---

## Phase 1 — Reproduce & Gather Evidence

**Read everything before touching code.**

- Read the full error, stack trace, or symptom. Note exact line numbers, file paths, error codes.
- State expected vs. actual behavior in one sentence.
- Check recent changes: `git diff`, dependency bumps, config/env drift, recent deploys.

**Can you reproduce it reliably?**
```
YES → Proceed to Phase 2

NO  →
  ├── Gather more context: logs, environment, system state
  ├── Reproduce in a minimal/isolated environment
  ├── If timing-dependent: add timing instrumentation, check for race conditions
  └── If truly non-reproducible after investigation:
        → document what was ruled out
        → implement appropriate handling (retry, timeout, graceful error)
        → add logging for future investigation
        → treat as "environment/timing" class bug (see Bug Classes below)
```

**Multi-component systems** (API → service → DB, CI → build → deploy):
Add boundary logging BEFORE forming any hypothesis:
```
For EACH component boundary:
  - Log what data/state ENTERS the component
  - Log what data/state EXITS the component
  - Verify config/env at each layer
Run once → find WHERE the invariant breaks → investigate ONLY that layer.
```

**Secrets / PII — unconditional, both modes.** Never log, print, or diff credential values, tokens, keys, or PII. Compare presence and config only (set/unset, length, source, hash). Redact before any diagnostic output, test fixture, or shared paste. Applies to boundary logging, env diffs, stack traces, and anything else this skill produces.

**Trace backward.** When an error is deep in the call stack, trace the bad value UPSTREAM to its origin. Fix at the source, not at the symptom layer.

**Create a minimal reproduction.** Reduce the failing case to the smallest code/data/environment that still triggers the bug. This eliminates false hypotheses and confirms scope.

**Long-session checkpoint.** If the debugging session has been running long (many tool calls, large file reads, multiple failed attempts): run `/compact` or equivalent before proceeding. Context degradation after extended sessions causes missed details and repeated mistakes.

---

## Phase 2 — Pattern Analysis

Find the contrast before forming any hypothesis:

1. **Find working examples** — locate similar code in the same codebase that works correctly.
2. **Read the working version completely** — do not skim.
3. **List every difference** — however trivial. Never assume "that can't matter."
4. **Understand dependencies** — what environment, config, state, or timing does the working version have that the broken one doesn't?

---

## Phase 3 — Hypothesize & Eliminate

1. Generate 3–5 candidate root causes. List them explicitly.
2. **Eliminate, don't confirm.** Design the smallest test that would DISPROVE each hypothesis. Test the most falsifiable first, not the most likely.
3. State ONE active hypothesis explicitly: *"I believe X is the root cause because Y. This test will disprove it if Z."*
4. If the test doesn't disprove it: move to the next hypothesis. Do NOT layer fixes on top of a prior failed attempt.
5. If root cause remains unclear — use binary search:
   - `git bisect` to find the first bad commit
   - Comment out half the suspected code; confirm if bug disappears
   - Add/remove config variables one at a time
   - Narrow until you have a 10-line failing case
6. Apply 5 Whys once root cause is found: ask "why does this condition exist?" up to 5 times. Stop when you reach a broken process or systemic gap, not just a code line.
7. **If you don't understand something:** say so. Do not fabricate confidence.

---

## Phase 4 — Fix

1. **Write a failing test first.** Automated preferred; a one-off script is acceptable. No test = no fix.
2. Apply ONE change targeting the root cause. No "while I'm here" refactoring.
3. Explain in one sentence: what the fix does and why it addresses the confirmed root cause.
4. Note edge cases or side effects introduced.
5. **Do not remove diagnostic logs until Phase 5 is complete.**

**Fix attempt limit:**
```
Attempts 1–2: Return to Phase 1 with new information.
Attempt 3+:   STOP — this is likely an architectural problem.
  Signs: each fix exposes new coupling elsewhere; fixes require massive
         changes; each attempt creates new symptoms.
  → Discuss with a human before attempting another fix.
```

---

## Phase 5 — Verify & Guard

### Verification Gate (mandatory before any "done" claim)
```
1. IDENTIFY: What exact command proves this is fixed?
             (test suite, build, linter, manual step)
2. RUN:      Execute the FULL command fresh — no cached or assumed results.
3. READ:     Full output. Check exit code. Count failures.
4. CONFIRM:
   Output does NOT confirm → state actual status with evidence, return to Phase 3/4
   Output DOES confirm     → state claim WITH evidence (paste relevant output)
5. ONLY THEN: Declare it fixed.
```

### Regression Check
- Run the full existing test suite. Count failures before and after. Zero new failures required.
- Verify no adjacent functionality was affected.
- Remove diagnostic logs now that fix is confirmed.

### Guard Against Recurrence
- Permanently add the Phase 4 test to the test suite if not already there.
- If this bug class can recur: add a lint rule, assertion, or CI gate that would catch it automatically.
- Document: *"Root cause was X. Future protection: Y."*

---

## Bug Classes — Detection Signals

| Class | Signals | Approach |
|---|---|---|
| **Logic** | Wrong output, wrong state, wrong control flow | Standard 5-phase process |
| **Performance / Memory** | Increasing memory over time, slow under load, CPU spikes | Profile BEFORE hypothesizing; establish measurement baseline first |
| **Concurrency / Race** | Intermittent failures, order-dependent results, "works locally", data corruption under load | Assume shared mutable state; look for missing locks, unawaited async, missing cleanup |
| **Environment / Config** | Works locally, fails in CI/staging/prod | Diff environments explicitly: env vars, versions, credential presence/config (never values), network rules, file paths |
| **Flaky Tests** | Passes/fails non-deterministically | Treat as real bugs; do NOT re-run until green; find the non-determinism (timing, test ordering, shared state) |

---

## Red Flags — STOP and Return to Phase 1

| If you catch yourself thinking… | Reality |
|---|---|
| "Quick fix for now, investigate later" | You will never investigate later |
| "It's probably X, let me fix that" | Probability isn't evidence — disprove it |
| "Multiple changes at once to save time" | Can't isolate what worked; causes new bugs |
| "I'll write the test after the fix" | Untested fixes don't stick |
| "Issue seems simple, skip the process" | Simple bugs have root causes too |
| "I don't fully understand but this might work" | It won't. Return to Phase 1 |
| "One more fix attempt" after 2+ failures | Architectural problem — stop |
| "Should work", "probably passes", "seems fine" | Not evidence. Run the verification gate |
| "Great!", "Done!", "Fixed!" without pasting output | Run the gate first |
| "I found the root cause" without a 5 Whys check | Ask why that condition exists |

---

## Quick Reference

| Phase | Gate (cannot skip) | Done when… |
|---|---|---|
| 1. Reproduce & Evidence | Must complete before Phase 2 | Can trigger reliably OR classified as environment/timing bug; session compacted if needed |
| 2. Pattern Analysis | Must complete before Phase 3 | Know what differs from working code |
| 3. Hypothesize & Eliminate | Must complete before Phase 4 | Root cause confirmed by elimination + 5 Whys applied |
| 4. Fix | Failing test written first | One change at root cause level |
| 5. Verify & Guard | Fresh command output required | Target passes, zero new failures, guard added, logs cleaned |
