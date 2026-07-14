# Roadmap

Open gaps by swim lane; lifecycle in README §Skills standard 3 and `skill-authoring` §Wiring. Conscious no's go to §Deferred below — a gap is work intended, a deferral is a decision not to.

**Why this file exists** (2026-07-13): auditing the writing lane against "will these skills *produce* high-quality writing?" answered no — they edit and gate it. The suite was constraint-shaped: strong at catching bad writing and verifying finished writing, unowned on what makes a piece worth reading. The bullet-sized findings closed the same day in `writing` (worth-writing test · strongest-objection-on-the-page · pinned terms · concrete-instance obligation); the skill-sized ones are recorded below. The README's "no open gaps" had been true of coverage, not capability — hence a ledger that survives that claim.

## Writing

- **Research-paper structure** — the argument type covers the reasoning, not the form: contribution statement · related-work positioning · methods & limitations disclosure · abstract as the piece's minimum message length. Demote to Deferred if papers don't become a real lane.

## Software engineering

- **TODO** — lane audit pending. Ask the question the writing lane just answered: do these skills *produce* quality, or only gate it? Two more lenses (2026-07-14): does the skill cut the human's *verification* cost — output-shape constraints (findings formats, GO | NO-GO) do; unshaped generative advice doesn't — and is it preference-shaped (encodes a decision a model can't infer) or textbook-shaped (restates what a capable model does anyway)? Reviewer attention is the scarce resource in agent workflows, not model capability.

## Both

- **Task-state home** — `planning` produces breakdowns, `estimation` sizes them, `diagnostic` §Decision-Journal logs predictions, but nothing owns in-flight, cross-session task state (started / blocked / abandoned) for arbitrary projects; this roadmap is that artifact for the suite only. Candidate: a task-ledger convention or skill.

## Suite (meta)

Gaps in the suite's own machinery, from a 2026-07-14 flow review:

- **Routing test battery** — the suite audits skill *content* (compression, wiring) but never whether the right skill *fires*; frontmatter is all an on-demand router sees. Build ~20 realistic prompts ("make this faster" · "is this ready?" · "here's my outline"), each with the expected skill, checked against what actually fires; rerun when a description changes. Misfires count both ways: right skill silent, or a skill firing where a direct answer was better.
- **Trigger collisions with harness built-ins** — a suite trigger that shadows a target harness's built-in skill is a routing bug: the user's invocation loads the wrong one. Observed: suite `code-review` triggers on `/review`, while Claude Code ships built-in `code-review` / `review` / `security-review`. Add a collision check to `skill-authoring` §Wiring or `scripts/port.sh`.
- **`rules.md` rule 5 vs one-authoritative-home** — "on correction: add rule to rules.md" predates the suite and routes *every* correction to one file, making it the junk drawer the suite forbids. Fix: route a correction to the file owning the behavior (the skill, the README standards); rules.md keeps only cross-cutting session conduct.
- **Compression validated against weaker executors** — aphorism-over-qualifiers (`skill-authoring` §Compression) assumes a reader that can decompress the image back into the argument; smaller models pattern-match aphorisms and misapply them. The suite is authored on frontier models but ported tool-agnostically — spot-check skills against the weakest model expected to execute them.

## Future lanes

- **Math**, **Physics** — planned; a lane opens by recording its first concrete gap here.

## Deferred — writing suite

Recorded so the no is a decision (`planning` §Prioritization):

- `writing` §Narrative fiction mechanics (POV consistency · tense discipline · dialogue) — only if fiction becomes a real lane beyond memoir / personal essay.
- `writing-ship` audience / venue-fit stage — stage 7 venue rules cover it today; promote to a stage only if venue mismatches start passing the gate.
- `writing-ship` SEO / discovery checks — optimization ≠ readiness; would live beside the gate, not inside it.
- `writing-ship` accessibility beyond alt text (heading hierarchy · link text · contrast) — add if pieces grow structurally complex.
- Announcement / promo copy — [`communication`](skills/communication/SKILL.md)'s lane (writing for action), not a gate stage.
