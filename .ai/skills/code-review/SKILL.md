---
name: code-review
description: Explicit code review process. Audit existing code against Clean Code and Architecture rules. Output: actionable diffs, imperative feedback, or PASS. Also runs the project-level release-readiness gate for going public. Triggers: /review · "review this" · "audit this code" · "what's wrong with this" · "is this ready to open-source" · "ready for prime time" · "run the release-readiness gate" · "ship-to-public check"
when_to_use: Explicitly invoked on existing code. Evaluative — not always-on. Distinct from writing or generating code. Two modes — single-diff review, or the §Release-readiness gate (an ordered, delegating filter for taking a whole project public).
---

# Code Review

Evaluative process. Criteria defined in software-engineering skill; this skill defines process and output format.

## Process

Apply each rule set against the code; the authoritative rules live in `software-engineering` — this skill orders the passes and formats findings.

1. **Design audit** — `software-engineering` §Design.
2. **Architecture audit** — §Architecture.
3. **CLI / DevEx audit** (if applicable) — §CLI / DevEx.
4. **Documentation currency** — §Documentation.

## Output Format

```
[FILE:LINE] <RULE> — fix: <imperative action>
PASS: <what was checked>
```

- One finding per item.
- No theory. Apply the rule; state the fix.
- No praise for passing unless requested.

## Priority

```
critical   correctness · security · broken contracts
high       missing seams · infrastructure in logic layer · SRP violations
medium     DRY · naming · function shape · smells
low        style · minor verbosity
```

## Hand-offs
- Finding is a live bug (wrong output/state, not just a rule violation) → `debug` — root-cause it, don't patch in review.
- Security-sensitive surface (auth, input handling, secrets, deserialization, SQL, file/exec) → `security` for a data-flow trace.
- Missing, fragile, or absent tests → `testing` for coverage design.

## Gates

Blocking checks specific to review (the rule-level gates live in `software-engineering`):

```
[ ] routing / shim layers remain thin
[ ] docs match committed implementation
```

## Release-readiness gate

**Fires (this mode, not single-diff review) when** the request is about taking a *whole project* public — "ready to open-source" · "ready for prime time" · "ship-to-public" · "run the release-readiness gate". Otherwise run the diff review above. On ambiguity, ask which mode.

**Run** the stages in order. Each is blocking: **STOP at the first FAIL**, emit the report, and do not run later stages — don't polish a later stage on a project that fails an earlier one. Invoke the owning skill named per stage; gather its evidence before marking PASS.

1. **Functional** — builds · tests pass · runs from a clean clone → `testing` · `debug`.
2. **Quality** — run the diff/audit Process above across the codebase → `code-review`.
3. **Security** — full git-history secret/PII scan (`security` §Secrets *Pre-publish*) + dependency CVE / lockfile audit (§Dependencies) → `security full`.
4. **Docs** — README / install / usage reflect actual state; quickstart works from the clean clone → `software-engineering` §Documentation.
5. **Governance** — LICENSE · CONTRIBUTING · CODE_OF_CONDUCT · SECURITY.md + disclosure · issue / PR templates present and accurate → governance (roadmap; check by hand until the skill exists).
6. **Release** — semver · changelog · tag plan · deprecation policy → release-engineering (roadmap; by hand until the skill exists).
7. **Publish** — manual + irreversible (once public + indexed, a leaked secret is burned). Only when 1–6 are GO: tag the release · push to the registry · flip the repo public. The agent stops at this boundary and hands the irreversible action to the human.

**Output**
```
## Release-readiness: <project>
1 Functional   PASS | FAIL — <evidence>
2 Quality      PASS | FAIL — <evidence>
3 Security     PASS | FAIL — <evidence>
4 Docs         PASS | FAIL — <evidence>
5 Governance   PASS | FAIL — <evidence>
6 Release      PASS | FAIL — <evidence>
GATE: GO | NO-GO (blocked at stage N — <reason>)
Next: <manual publish steps from stage 7, only when GO>
```
