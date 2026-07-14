---
name: writing-ship
description: Publish-readiness gate for prose — the ordered, delegating, type-aware filter that decides whether a piece (blog post, essay, story, poem, review) is ready to publish. Meta-skill: names the type, runs other skills as stages binding per type, emits GO | NO-GO. Prose analog of ship. Triggers: /writing-ship · "ready to publish" · "publish check" · "is this post ready" · "pre-publish review".
when_to_use: Publishing a finished piece to a public surface — not drafting or revising (that's `writing-draft` / `writing`), not a whole software project (that's `ship`). Deterministic entry point: type `/writing-ship`. Delegates to the skills it names per stage (`writing`, `research`, `argumentation`, `diagnostic`, `legal`, `privacy`); port those alongside it.
---

# Writing-Ship

Orchestrates other skills as ordered stages — owns no craft rules of its own (those live in `writing`).

## Run
**Stage 0 — name the type** (`writing` §Type first): it decides how stages 1, 3, 4 bind. A stage the type exempts is reported **N/A — <type>**, never silently skipped.

Then stages in order. Each is blocking: **STOP at the first FAIL**, emit the report, do not run later stages — don't copyedit a piece whose spine fails. Invoke the owning skill per stage; gather its evidence before marking PASS. A fixed FAIL re-runs its stage; a rewrite that changes structure re-enters at stage 1 — PASS evidence goes stale with the text it inspected.

1. **Substance** — the spine stage 0 named holds · every factual claim cited / verified / hedged · numbers carry source + context → `writing` §Type first + §Claims & evidence · `research` (validate).
2. **Craft** — revision protocol completed through the cool-down pass, binding sections only → `writing` §Revision protocol.
3. **Adversarial read** — argument / explainer / review: strongest objection voiced and survived · murder line found, then fixed or owned → `argumentation` §Steelyman (writing lens). Narrative / poetry: **N/A** unless requested — critique there is taste, not refutation.
4. **Clarity** — no unearned jargon; the core survives a plain-language re-explanation → `diagnostic` §Feynman-Test. Poetry: **N/A** — resistance to paraphrase is the point (`writing` §Poetry).
5. **Rights** — quotes attributed + within fair use · images / embedded code licensed for reuse, license honored · claims about people / products accurate (defamation floor) · disclaimers where claims warrant (benchmarks, security content) → `legal`.
6. **Privacy** — real people named only with consent · employers / colleagues / clients not exposed · no personal identifier auto-filled (author contact is a deliberate choice) · screenshots / logs / URLs scrubbed · the author's **own** disclosures deliberate — permanence applies to yourself → `privacy`.
7. **Mechanics** — links resolve · code samples actually run · images have alt text · spelling / grammar pass · metadata set (title, description, canonical URL, date, social preview) · venue rules honored (length · format · AI-assistance disclosure where the venue requires it).
8. **Publish** — manual + irreversible (indexed, archived, syndicated, quoted — deletion never reaches caches, feeds, or the Wayback Machine), and it spends **first-publication rights** — most journals refuse previously published work, and a personal blog counts; hold pieces meant for submission. Only when 1–7 are GO: publish · syndicate · announce. Post-publish, material changes get a dated correction note, never a silent edit — the archives hold the original. Stop at this boundary and hand the irreversible action to the human.

## Output
```
## Publish-readiness: <piece> (<type>)
1 Substance    PASS | FAIL — <evidence>
2 Craft        PASS | FAIL — <evidence>
3 Adversarial  PASS | FAIL | N/A — <evidence | type>
4 Clarity      PASS | FAIL | N/A — <evidence | type>
5 Rights       PASS | FAIL — <evidence>
6 Privacy      PASS | FAIL — <evidence>
7 Mechanics    PASS | FAIL — <evidence>
GATE: GO | NO-GO (blocked at stage N — <reason>)
Next: <manual publish steps from stage 8, only when GO>
```
