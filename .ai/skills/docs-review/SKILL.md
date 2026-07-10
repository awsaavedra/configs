---
name: docs-review
description: Corpus-level documentation audit — the docs analog of `code-review`. Evaluative pass over a project's whole documentation surface, ordered: currency → coverage → one-authoritative-home → terseness → navigability. Target state: terse, comprehensive, clearly navigable. Output: `[FILE:§SECTION] RULE — fix: action` or PASS. Triggers: /docs-review · "tighten the docs" · "audit the documentation" · "streamline the README" · "are the docs navigable". Owns the `ship` gate's Docs stage.
when_to_use: Reviewing or tightening an existing docs corpus (README, docs/, community files, package-metadata descriptions) as a whole. Not a single diff (that's `code-review` pass 4), not writing new prose (that's `writing` §Explainer), not scaffolding a new project (that's `readme-template.md`). Currency rules live in `software-engineering` §Documentation — this skill runs them, then audits structure.
---

# Docs Review

Evaluative, corpus-level, read-only by default. Audits the documentation surface *as a whole* — README, `docs/`, community files, package-metadata descriptions — not a diff.

## Scope
- **Currency rules live in `software-engineering` §Documentation** (reflect actual state · atomic updates · no archaeology · no volatile enumerations) — pass 1 runs them, this skill doesn't restate them.
- **Layout conventions live in `readme-template.md`** (thin-index README · long-form in `docs/<topic>.md` · flat architecture lists) — applied here as *audit criteria*, not a scaffold.
- Target state: **terse, comprehensive, navigable** — minimum tokens · full coverage · any fact ≤2 hops from the README.
- **Applicability short-circuit** — audit only surfaces the project *has*. One false predicate stops that whole line of analysis: no API (static site) → no API-docs findings; no CLI (pure library) → no command-docs findings. Emit `N/A: <surface> — <why>` and move on — explicit N/A, never a silent skip, never a finding against a nonexistent surface (same rule as `writing-ship`'s per-type stages).

## Passes (in order)

1. **Currency** — docs match committed implementation → `software-engineering` §Documentation. Stale content blocks later passes: don't tighten wrong text.
2. **Coverage** — every public surface *the project actually has* documented: commands · flags · env vars · config · endpoints · setup prerequisites. Quickstart works from a clean clone. An existing surface without docs is a finding; a surface the project lacks is `N/A` (§Scope short-circuit), not a gap.
3. **One authoritative home** — each fact lives in exactly one doc; every other mention is a link. Duplicated prose drifts independently and one copy goes stale silently (DRY for docs).
4. **Terseness** — losslessly compress: cut throat-clearing, marketing filler, restated context. README stays a thin index — one scannable line per topic; a section past a few lines moves to `docs/<topic>.md` behind a one-line pointer.
5. **Navigability** — ≤2 hops from README to any fact · no dead links · no orphan docs (unreachable from the README) · doc types don't mix (tutorial / how-to / reference / explanation serve different readers — a reference interrupted by a tutorial fails both) · flat lists over ASCII trees.

## Output Format

```
[FILE:§SECTION] <RULE> — fix: <imperative action>
PASS: <what was checked>
N/A: <surface> — <why it doesn't apply>
```

- One finding per item. No theory; state the fix.

## Priority

```
critical   wrong / stale content (currency)
high       missing coverage · broken quickstart
medium     duplication · dead links · orphan docs
low        terseness · mixed doc types · style
```

## Hand-offs
- Long-form doc needs sentence-level prose work (correct but badly written explainer) → `writing` §Explainer, under an edit-depth contract.
- Docs drift tied to a code change under review → `code-review` (its pass 4 + gate own diff-scoped currency).
- Taking the whole project public → `ship` — this skill runs as its Docs stage.
- No docs exist yet → scaffold from `readme-template.md`; this skill audits, it doesn't scaffold.

## Gates

```
[ ] quickstart verified from a clean clone
[ ] every doc reachable from the README (no orphans)
[ ] no fact with two homes
[ ] README is an index — no long-form body inline
```
