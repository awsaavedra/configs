---
name: skill-authoring
description: Meta-skill — how a SKILL.md in this suite is written and wired in. Skill kinds (generative / evaluative / gate / cluster — the kind decides the shape), frontmatter contract (description = retrieval surface with triggers; when_to_use = boundary ending in a not-for chain), dual-readable lossless compression (bold rule + why, aphorism over qualifiers, reference never restate, post-draft compression pass), standard blocks (framing line, Output template, Gates, explicit N/A grammar), wiring bookkeeping (catalog + roadmap in the same commit, reciprocal hand-offs, gate integration). Triggers: /skill-authoring · "add a skill" · "write a SKILL.md" · "wire in a new skill" · "audit the catalog".
when_to_use: Creating or revising a skill in this suite, or auditing catalog / roadmap / hand-off consistency. Owns the conventions, not the content — the skill's domain expertise is its own problem. Not auditing a docs corpus (docs-review), not prose craft (writing), not always-on cross-project constraints (rules.md — binds every session; skills are on-demand capability).
---

# Skill Authoring

The suite's rules apply to the suite: one authoritative home per piece of knowledge, and this file is the home for how skills are written. A skill is read by sessions that weren't there when it was authored — every convention below exists so the next author, human or agent, can't drift silently.

## Kinds
Name the kind first — it decides the shape.
- **Generative** (`software-engineering`, `writing`) — always-on principles applied while producing work; auto-engages via when_to_use.
- **Evaluative** (`code-review`, `docs-review`, `security`) — explicitly invoked, read-only by default; findings format + `N/A` grammar required.
- **Gate** (`ship`, `writing-ship`) — ordered blocking stages delegated to owning skills (each owner declares its stage in its own description), stop at first failure, emit GO | NO-GO, deterministic `/entry`; delegates named so porting the gate ports them.
- **Cluster** (`argumentation`, `diagnostic`, `software-engineering`) — sub-skills sharing audience and lifecycle in one file; a section that grows its own trigger vocabulary and wiring becomes a standalone skill (`cli-devex` stayed a section; `api-design` didn't).

## Frontmatter
- **`name` matches the directory** — `skills/<name>/SKILL.md`, kebab-case, one capability cluster per file; the three fields only (`name` / `description` / `when_to_use`) — frontmatter stays tool-agnostic, no harness-specific keys.
- **`description` is the retrieval surface** — written for the router deciding whether to load the skill, not the reader who already did. Dense summary of what the skill owns + `Triggers:` list (`/slash` · quoted invocations in the *user's* words — "make this faster", not the skill's vocabulary). Self-contained: the router sees nothing else.
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
- **Gates** — blocking checklist: what must be true before the skill's work counts as done. The one sanctioned restatement — body rules compressed to checkable predicates; the compression pass doesn't cut them.
- **Explicit N/A grammar** (evaluative and gate kinds) — a pass that doesn't apply is reported `N/A: <why>`, never silently skipped; one false predicate short-circuits that whole line of analysis.

## Wiring
Drift eats the bookkeeping first: a skill isn't done until wired, and it wires in the same commit.
- **README catalog** — one bolded header line + one dense bullet mirroring the description, placed by cluster affinity.
- **Roadmap** — a new skill closes a recorded gap: coverage clause added to the intro, gap removed, remainder renumbered. New candidates are recorded as gaps *before* drafting; ideas consciously not pursued go to Deferred so the no is a decision (`planning` §Prioritization).
- **Reciprocal hand-offs** applied in the adjacent skills (§Frontmatter); every §-reference checked to resolve.
- **Gate integration** — if a meta-gate (`ship`, `writing-ship`) owns a stage the skill implements, the gate's stage list points at it.
- **The commit message is the design record** — `#add, <name> skill (path) — framing; sections; wiring; README` per `software-engineering` §Documentation; the reasoning lives there, not padded into the skill.
- **Revisions ripple in the same commit** — description ↔ catalog bullet stay mirrored; a removed, renamed, or renumbered item gets a repo-wide grep for stale references (a roadmap number is a reference too).
- **This file evolves by precedent** — a convention is added only after it has been applied and survived, distilled from the diff that followed it; aspiration-first rules are the drift they claim to prevent.

## Output
```
## Skill: <name>
Gap: <roadmap entry it closes | recorded first>
Owns: <lane — adjacent lanes + owning skills>
Wiring: catalog · roadmap · reciprocal hand-offs (<skills>) · gates (<which | none>)
```

## Gates
- Kind named before writing; the shape follows it.
- `description` self-contained with triggers; `when_to_use` ends in a not-for chain with owners named.
- Every lane hand-off reciprocal; every §-reference resolves.
- No rule restated that another skill owns.
- Catalog + roadmap updated in the same commit as the skill.
- Compression pass run: every line carries its why; nothing an adjacent skill already says.
