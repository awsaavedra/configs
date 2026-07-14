---
name: writing
description: Prose craft cluster, type-first — name the piece's type (argument / essay, explainer, narrative / memoir, poetry, review), then apply only the rules that bind it: thesis, structure, narrative arc, image & line, sentence economy, audience fit, claims & evidence, coarse-to-fine revision protocol with an edit-depth contract (developmental / line / copyedit / proofread) and voice preservation. The prose analog of software-engineering — rules applied while authoring or editing; the development loop is writing-draft, the publish gate is writing-ship. Triggers: /writing · "edit my writing" · "edit this piece" · "proofread this" · "tighten this" · "is this readable".
when_to_use: Drafting or editing anything meant for readers — blog posts, essays, personal writing, stories, poems, reviews. Name the type and edit depth first; apply only the sections and passes that bind. Author-first draft development (outline angles · expand / trim rounds) → writing-draft · adversarial read → argumentation §Steelyman (writing lens) · clarity audit → diagnostic §Feynman-Test · sourcing → research · publish-readiness → writing-ship. Not for code docs currency — that's software-engineering §Documentation — nor short-form decision-seeking (PRs, RFCs, status updates) — that's communication.
---

# Writing

Prose exists to change what the reader knows, believes, feels, or does. Every rule serves that; decoration serves only the author.

## Type first
Name the type before applying any rule — the wrong lens is the failure this table prevents (a thesis demand kills a poem; "show don't tell" bloats an explainer). Hybrids take both rows' spines.

| Type | Spine — what must hold | Binding sections |
|---|---|---|
| Argument / essay | Falsifiable thesis, earned | Thesis · Structure · Claims |
| Explainer / technical | Reader can understand or do X after | Structure · Claims |
| Narrative / memoir / personal essay | Arc + stakes — someone or something changes | Narrative · Structure |
| Poetry | Image + turn; sound | Poetry only (Sentences / Audience bind loosely) |
| Review / criticism | Judgment + stated criteria + evidence | Thesis · Claims · Narrative (experience as evidence) |

**Universal:** Audience · Revision protocol · read-aloud. **Type-bound:** everything else.

## Thesis — argument · essay · review
- **Worth writing before worth defending — correct + novel + important.** Name what the reader believes going in that they won't coming out; if nothing changes, it's a consensus summary, not an essay. The one gate a boring thesis fails.
- One sentence, falsifiable, stated early. Can't write it → you have notes, not a piece.
- Everything supports the thesis or explicitly earns its digression. Neither → cut.
- **Pin load-bearing terms before arguing with them.** A term that shifts mid-piece runs a motte-and-bailey on your own reader (argumentation §Bad-Faith-Moves).
- **Work of ants (Russell), Occam's razor opposing.** Build from stated axioms up, every inferential step on the page; against it, the shortest derivation that keeps its explanatory power. Rigor adds steps, parsimony cuts them; done where neither moves.
- **Minimum message length.** The product test of that balance — Graham's "uncompressible": remove or replace any part and the argument falls; every summary is lossy. A piece that compresses losslessly was padding around its own summary.
- **Strongest objection on the page.** Steelman it (argumentation §Steelyman), answer it or concede it — concession is credibility. The objection you skip is the one the reader already thought of; the murder line finds the weak sentence, not the missing rebuttal.
- Title is a claim or a promise, not a topic label — "How we cut build times 40%", not "Thoughts on builds."

## Structure
- **Lede carries the spine + stakes** in the first paragraph — thesis stated (argument) or tension promised (narrative). Readers decide to continue there; don't spend it clearing your throat.
- **One idea per paragraph;** first sentence states it, the rest earn it. First sentences alone should tell the story.
- **Order by the reader's questions,** not your discovery sequence — what must they know before this lands? (Narrative: order by story logic — tension held; not necessarily chronology.)
- **Headings are promises** — each raises a question its section must answer.
- **End with the consequence** — what changes if the reader accepts the thesis; not a summary of what they just read. (Narrative: the change lands; no moral bolted on.)

## Narrative — memoir · personal essay · fiction
- **Arc:** someone or something changes; no change → an anecdote, not a story.
- **Scene vs. summary:** dramatize the turning points; summarize the connective tissue.
- **Show, don't tell** — emotion and character are shown; plumbing (time, logistics) is told.
- Concrete sensory specifics — specificity is credibility.
- **Chekhov's gun:** whatever you introduce must fire; an unfired detail is a broken promise (§Thesis's minimum-message-length test, narrative form).
- Personal essay: the experience is the evidence, the meaning is the thesis-analog; the "so what" must surface without a bolted-on moral.
- Memoir truth: never invent events; compression / reordering is a deliberate, owned choice.

## Poetry
- **Image over statement** — the abstraction rides the concrete.
- **Line breaks are meaning:** what ends and opens a line carries emphasis; enjambment is a tool, not an accident.
- **Sound first:** read aloud is the primary test — rhythm, assonance, consonance.
- **Compression:** every word load-bearing; poetry is the limit case of the −10–20% pass.
- **The turn:** locate where the poem changes; a poem without one is description.
- **Editing poems: preserve strangeness.** Don't normalize syntax, paraphrase images, or apply §Sentences clarity rules — resistance to paraphrase is the point.

## Sentences — all prose; poetry per §Poetry
- Concrete over abstract; example over category ("Postgres", not "a database" · "3 weeks", not "some time").
- Active voice by default; passive only when the actor is unknown or irrelevant.
- Cut: throat-clearing ("It's worth noting that") · stacked hedges (one max) · intensifiers ("very", "extremely") · "in order to" → "to".
- Verbs carry sentences; nominalizations bury them ("make a decision" → "decide").
- Vary length — a short sentence lands after long ones.

## Audience
- Write for one named reader; the everyone version reaches no one.
- Walk the inferential distance from what they know (argumentation) — don't assume the gap away.
- Jargon is a tax; pay it only where precision demands it (diagnostic §Feynman-Test finds the evasions).
- Front-load and make it skimmable: a reader exiting at any point leaves informed. (Narrative / poetry: the contract is attention, not skimmability — earn it instead.)

## Claims & evidence — wherever factual claims are made
- Every factual claim: cited, personally verified, or explicitly hedged as opinion / experience. Nothing asserted from vibes (`research` owns sourcing).
- Numbers carry source + context (baseline, denominator, timeframe).
- Distinguish "I did X and observed Y" (experience — strong) from "X is true generally" (needs evidence).
- **Abstract claims earn concrete instances** — readers believe examples, not assertions; a claim that can't produce one is a claim to re-examine (§Sentences' concrete-over-abstract at argument level).
- **Murder line test:** the sentence a hostile reader quotes to dismiss the piece — find it first (argumentation §Steelyman, writing lens).

## Revision protocol
Editing an existing piece (yours or another's) enters here: run §Type first, name the edit depth (below), then these passes against the binding sections only. Coarse → fine — polishing a paragraph the structure pass will delete is waste:
1. **Structure** — the type's spine holds? headings / scenes answer their questions? order matches the reader's? Cut whole sections here.
2. **Paragraph** — one idea each; first sentences alone tell the story. (Poetry: stanza and line-break pass instead.)
3. **Sentence** — apply §Sentences per type; target −10–20% words, zero meaning lost.
4. **Read aloud** — stumbles mark bad prose; rewrite what you can't say. (Poetry: this is the primary pass, not a check.)
5. **Cool down** — hours minimum, overnight better, then one fresh-eyes pass.

**Edit depth — the second half of the contract.** "Edit this" spans four asks: **developmental** (pass 1) · **line** (passes 2–4) · **copyedit** (grammar · consistency · usage) · **proofread** (typos only). Type narrows *which rules*; depth narrows *how deep*. Name both before touching text; run only the contracted passes. Problems outside the contract are **flagged, not fixed** — asked for a proofread, found a failing spine → report it, don't restructure. When the author hands over a mature draft (outline and early drafts theirs), the deeper passes default to flag-only.

**Preserve the author's voice.** The edit serves the writer, not the editor: fix what the contracted depth names — never rewrite register, rhythm, or diction into house style, and never introduce machine-prose tells (uniform sentence rhythm · stacked hedges · "not just X, but Y" · em-dash chains · unasked vocabulary upgrades). An edit that makes the piece sound like everyone else's has failed, whatever it fixed. §Poetry's preserve-strangeness is this rule at full strength.

**Draft ugly, revise cold.** Generation and criticism are different modes; interleaving them stalls both.
