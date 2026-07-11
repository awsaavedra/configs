---
name: skill-authoring
description: Meta-skill — how a SKILL.md in this suite is written and wired in. Frontmatter contract (description = retrieval surface with triggers; when_to_use = boundary ending in a not-for chain), dual-readable lossless compression (bold rule + why, aphorism over qualifiers, reference never restate, post-draft compression pass), standard blocks (framing line, Output template, Gates, explicit N/A grammar), wiring bookkeeping (catalog + roadmap in the same commit, reciprocal hand-offs, gate integration). Triggers: /skill-authoring · "add a skill" · "write a SKILL.md" · "wire in a new skill" · "audit the catalog".
when_to_use: Creating or revising a skill in this suite, or auditing catalog / roadmap / hand-off consistency. Owns the conventions, not the content — the skill's domain expertise is its own problem. Not auditing a docs corpus (docs-review), not prose craft (writing).
---

# Skill Authoring

The suite's rules apply to the suite: one authoritative home per piece of knowledge, and this file is the home for how skills are written. A skill is read by sessions that weren't there when it was authored — every convention below exists so the next author, human or agent, can't drift silently.

## Frontmatter
- **`name` matches the directory** — `skills/<name>/SKILL.md`, kebab-case, one capability cluster per file.
- **`description` is the retrieval surface** — written for the router deciding whether to load the skill, not the reader who already did. Dense summary of what the skill owns + `Triggers:` list (`/slash` · quoted invocations). Self-contained: the router sees nothing else.
- **`when_to_use` is the boundary** — positive scope first, then the not-for chain: each adjacent lane named with its owning skill ("Not X (skill-a), not Y (skill-b)"). A lane without a named owner is a routing gap.
- **Lane hand-offs are reciprocal** — if A routes a lane to B, B routes the mirror lane back (debug ↔ performance, data-analysis ↔ performance). One-way routing strands the reader who entered on the wrong side.

## Compression
- **Dual-readable, losslessly compressed** — the suite rule: human-skimmable and agent-parseable at once; every line earns its tokens.
- **Bold rule + why** — `**Rule** — consequence.` A rule without its why gets pattern-matched and ignored; the why is the compressed argument.
- **Aphorism over qualifiers** — one memorable line ("a benchmark that moves with the weather measures the weather") outlives three hedged sentences; compress the reasoning into the image.
- **Reference, never restate** — one authoritative home per rule across the suite; others cite `skill` §Section (multi-word sections hyphenated: §Decision-Journal; loose partials tolerated: §Breaking). Restating forks the rule.
- **The compression pass** — after drafting and on every revisit, re-read hunting restatements: a clause repeating its own bold lead · a bullet restating a table row · a rule another skill owns. A cut is lossless only if the rule, its why, and its example survive; a cut that loses the why saves tokens and drops the argument.
- Broad → narrow; `##` per concern; ~50–60 lines total — past that, it's probably two skills.

## Structure
- **Framing line first** — the skill's thesis in a sentence, usually locating its lane against the adjacent skill's ("this owns proactive; `debug` owns regressions").
- **Output block** — fenced template of the deliverable the skill emits; shape, not prose.
- **Gates** — blocking checklist: what must be true before the skill's work counts as done.
- **Explicit N/A grammar** (evaluative skills) — a pass that doesn't apply is reported `N/A: <why>`, never silently skipped; one false predicate short-circuits that whole line of analysis.

## Wiring
Drift eats the bookkeeping first: a skill isn't done until wired, and it wires in the same commit.
- **README catalog** — one bolded header line + one dense bullet mirroring the description, placed by cluster affinity.
- **Roadmap** — a new skill closes a recorded gap: coverage clause added to the intro, gap removed, remainder renumbered. New candidates are recorded as gaps *before* drafting; ideas consciously not pursued go to Deferred so the no is a decision (`planning` §Prioritization).
- **Reciprocal hand-offs** applied in the adjacent skills (§Frontmatter); every §-reference checked to resolve.
- **Gate integration** — if a meta-gate (`ship`, `writing-ship`) owns a stage the skill implements, the gate's stage list points at it.
- **The commit message is the design record** — `#add, <name> skill (path) — framing; sections; wiring; README` per `software-engineering` §Documentation; the reasoning lives there, not padded into the skill.

## Output
```
## Skill: <name>
Gap: <roadmap entry it closes | recorded first>
Owns: <lane — adjacent lanes + owning skills>
Wiring: catalog · roadmap · reciprocal hand-offs (<skills>) · gates (<which | none>)
```

## Gates
- `description` self-contained with triggers; `when_to_use` ends in a not-for chain with owners named.
- Every lane hand-off reciprocal; every §-reference resolves.
- No rule restated that another skill owns.
- Catalog + roadmap updated in the same commit as the skill.
- Compression pass run: every line carries its why; nothing an adjacent skill already says.
