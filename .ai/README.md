# AI Tooling Project Structure

Tool-agnostic layout for AI assistant context. Maps onto Claude Code, Cursor, Aider, Codex CLI, Continue, Copilot, etc.

```
project/
├── AGENTS.md              # Session context: stack, commands, constraints
├── AGENTS.local.md        # Personal overrides (gitignored)
├── .mcp.json              # MCP server connections (config: which servers + how to launch)
├── mcp/                   # In-repo MCP server implementations — one subfolder per server; .mcp.json points here
└── .ai/
    ├── settings.json      # Permissions, tool access, model defaults
    ├── settings.local.json
    ├── rules/             # Modular guidance by topic
    ├── commands/          # Reusable prompts / slash commands
    ├── skills/            # Capability bundles, on-demand
    ├── agents/            # Specialized sub-agents
    └── hooks/             # Lifecycle scripts (pre/post tool, commit)
```

## Tool mapping

| Concept  | Claude Code             | Cursor                  | Codex / generic     | Copilot                           |
|----------|-------------------------|-------------------------|---------------------|-----------------------------------|
| Context  | `CLAUDE.md`             | `.cursor/rules/*.mdc`   | `AGENTS.md`         | `.github/copilot-instructions.md` |
| Settings | `.claude/settings.json` | `.cursor/settings.json` | `.ai/settings.json` | `.vscode/settings.json`           |
| MCP      | `.mcp.json`             | `.cursor/mcp.json`      | `.mcp.json`         | (preview)                         |
| Commands | `.claude/commands/`     | Composer presets        | `.ai/commands/`     | Chat participants                 |
| Skills   | `.claude/skills/`       | —                       | `.ai/skills/`       | —                                 |
| Agents   | `.claude/agents/`       | Custom modes            | `.ai/agents/`       | —                                 |
| Hooks    | `.claude/hooks/`        | —                       | `.ai/hooks/`        | —                                 |

Where a tool lacks native support, keep the file in `.ai/` anyway — documents intent, ready when the tool catches up.

## Adopt incrementally

1. `AGENTS.md` — symlink your tool's expected file to it.
2. `.ai/rules/` — when one rules file gets too long.
3. `.ai/commands/` — first time you copy-paste the same prompt twice.
4. `.mcp.json` — when the assistant needs external systems; if you *author* a server in-repo (rather than consume a published one), its code lives in `mcp/<name>/` and `.mcp.json` points at it.
5. `.ai/hooks/` — when the harness should catch something deterministically.
6. `.ai/agents/` + `.ai/skills/` — when the main context gets crowded.

## In this repo

[`rules.md`](rules.md) holds the cross-cutting AI rules (0–7) for every project; [`readme-template.md`](readme-template.md) is the repo-README skeleton plus high-impact rule examples for scaffolding a new project's docs. [`skills/`](skills/) implements the reusable skill clusters cataloged below — drop them into any project's `.ai/skills/` or symlink into `.claude/skills/` per the tool mapping above, or run [`scripts/port.sh`](../scripts/port.sh) to do it in one command. The directory layout above is a **template** — apply per-project as needed.

## Skills

**Rule:** All rules must be dual-readable (human + agent) and losslessly compressed to minimum tokens.

Reusable Socratic / argumentation / diagnostic skills any AI assistant can invoke. Tool-agnostic — drop into `.ai/skills/` or symlink into `.claude/skills/` per the tool mapping above. Each cluster is a single `SKILL.md`.

**[Argumentation cluster](skills/argumentation/SKILL.md)** — `/argumentation-hygiene`, `/you-sure`, `/steelyman`, `/double-crux`
- `argumentation-hygiene` — Umbrella rulebook: good-faith principles, bad-faith taxonomy (motte-and-bailey, sealioning, gish gallop, etc.), self-audit checks.
- `you-sure` — AI self-audits a confident claim. ITT the strongest opposing views, surface assumptions, revise. Triggered by `/you-sure` or pushback ("you sure?", "really?").
- `steelyman` — Consensual adversarial collaborator for the user's writing/code/plan/design. ITT first, then challenge; hold under pushback. Triggered by `/steelyman` or "tear this apart."
- `double-crux` — Symmetric productive disagreement. Each side names what evidence would flip their position; locate whether disagreement is shared crux, crux-mismatch, values-level, or empty.

**[Diagnostic cluster](skills/diagnostic/SKILL.md)** — `/pre-mortem`, `/five-whys`, `/feynman-test`, `/decision-journal`
- `pre-mortem` — Assume failure and reverse-engineer why, before committing. Surface failure modes and early-warning signals.
- `five-whys` — Root-cause drilling after a real incident. Evidence at each level; stop at the deepest actionable cause.
- `feynman-test` — Comprehension audit by jargon-free explanation. Points where you reach for technical terms are your gaps.
- `decision-journal` — Log decisions + predictions + confidence for later calibration audit. Practice across time, not in-conversation.

**[Delegation ladder](skills/delegation/SKILL.md)** — routes work by scope
- `delegation-ladder` — Decides whether a task belongs at the architecture, pattern, or code level, then hands it to the right agent or handles it inline. Keeps strategic decisions from leaking into implementation and vice versa.

**[Planning](skills/planning/SKILL.md)** — goal decomposition
- `planning` — Turns an ambiguous goal into a structured plan: definition-of-done at every level, hierarchical breakdown (outcome → milestones → tasks), dependency mapping, riskiest-assumption-first sequencing, prioritization (MoSCoW, RICE / ICE, opportunity cost, an explicit NOT-doing list). Produces the breakdown that `delegation-ladder` routes; pairs with `diagnostic` §Pre-Mortem (stress-test) and §Decision-Journal (log the predictions).

**[Software engineering](skills/software-engineering/SKILL.md)** — coding principles cluster
- `design` — Clean code rules applied automatically: naming, function shape, class design (SRP/DIP), DRY, KISS/YAGNI, fail-fast, smell detection, and the Boy Scout Rule.
- `architecture` — Seam-first design: depend on interfaces, inject all external dependencies, keep infrastructure out of the logic layer. Lock edge cases before implementation; verify component independence.
- `cli-devex` — POSIX-compliant, pipeline-friendly CLI rules: stdin/stdout, no interactive prompts, terse/machine-readable output, composable commands, exit codes as contracts.
- `documentation` — Docs reflect actual implemented state; update atomically with code; exact paths and decisions; no lagging or historical archaeology.

**[Code review](skills/code-review/SKILL.md)** — explicit review workflow
- `code-review` — Evaluative process distinct from code generation. Audits Design, Architecture, CLI, and Documentation rules; outputs `[FILE:LINE] RULE — fix: action` or `PASS` per item. Prioritized by correctness → seams → DRY/naming → style.

**[Docs review](skills/docs-review/SKILL.md)** — corpus-level documentation audit
- `docs-review` — The docs analog of `code-review`: evaluative pass over the whole documentation surface (README, `docs/`, community files, package metadata), ordered currency → coverage → one-authoritative-home → terseness → navigability; target state terse, comprehensive, navigable (any fact ≤2 hops from the README). Audits only surfaces the project *has* — one false predicate (no API on a static site, no CLI in a library) short-circuits that line of analysis with an explicit `N/A`, never a silent skip. Currency rules stay in `software-engineering` §Documentation; [`readme-template.md`](readme-template.md) layout conventions applied as audit criteria, not a scaffold. Owns the `ship` gate's Docs stage. Entry point: `/docs-review`.

**[Ship](skills/ship/SKILL.md)** — release-readiness gate (meta-skill)
- `ship` — Decides whether a whole project is ready to go public. Runs an ordered, blocking filter — functional → quality → security → docs → governance → privacy → release → publish — delegating each stage to its owning skill (`testing` / `debug`, `code-review`, `security`, `docs-review`, `governance`, `legal`, `privacy`, `release-engineering`), stopping at the first failure, emitting GO | NO-GO. Deterministic entry point: `/ship`.

**[Governance](skills/governance/SKILL.md)** — open-source governance / community health
- `governance` — License selection, CONTRIBUTING / CODE_OF_CONDUCT / SECURITY.md, coordinated disclosure, issue & PR templates, DCO / CLA, triage. Owns the `ship` gate's governance stage; pairs with `security` for disclosure handling.

**[Legal](skills/legal/SKILL.md)** — open-source protective boilerplate
- `legal` — The disclaimer / liability / attribution language around a release: AS-IS warranty disclaimer + liability cap (rely on the license's, not your own), when a standalone disclaimer *is* needed, NOTICE / third-party attribution, trademark & endorsement reservation, export / high-risk clauses, and a hard "not legal advice — escalate to counsel" boundary. Feeds the `ship` gate's governance stage; pairs with `governance` (which selects the license).

**[Privacy](skills/privacy/SKILL.md)** — personal-data & identity hygiene
- `privacy` — The preventive counterpart to `security`'s PII *detection*: decides whether personal data should be published, collected, or retained at all, and by whom. Iron law — never auto-fill a personal identifier (email / name / hostname) from git config, session context, or env into a public artifact; use a role / project contact or ask. Covers PII taxonomy, data minimization, publication permanence (no "rotate" for identity), consent, and where PII hides in a repo. Owns the `ship` gate's Privacy stage; pairs with `security`, `governance` (contacts), `legal` (privacy policy → counsel).

**[Release engineering](skills/release-engineering/SKILL.md)** — versioning & releases
- `release-engineering` — Semantic Versioning, Keep a Changelog, Conventional Commits → bump mapping, signed tagging, deprecation policy, breaking-change detection. Owns the `ship` gate's release stage.

**[Debug](skills/debug/SKILL.md)** — five-phase bug investigation
- `debug` — Phased process for bugs, test failures, build failures, performance regressions, memory issues, and concurrency problems. Reproduce → pattern analysis → hypothesize/eliminate → fix at root → verify with fresh evidence. Enforces: no fix without confirmed root cause, no completion claim without verification, eliminate hypotheses rather than confirm them.

**[Testing](skills/testing/SKILL.md)** — test design, not just running
- `testing` — Test pyramid and what-to-test (behavior over implementation, edge-case enumeration), test doubles at injected seams, property-based testing, characterization tests for legacy code, and test-smell detection. Pairs with `architecture` (seams), `debug` (failing-test-first), and `rules.md` rule 4.

**[Security](skills/security/SKILL.md)** — scoped security review
- `security` — Evaluative, read-only by default. Scopes: `code` · `agent` · `infra` · `threat-model` · `full`. Outputs tiered findings (HIGH / MEDIUM / LOW / CLEAN) classified against OWASP Top 10:2025, CWE, CVSS v4. Covers language flaw matrices, ASI agent controls (14), STRIDE threat modeling, secrets handling, and compliance mapping (PCI / HIPAA / GDPR / SOC 2 / NIST / ISO).

**[Research](skills/research/SKILL.md)** — multi-source investigation with citations
- `research` — Decomposes a question into sub-queries, searches across papers/docs/repos, cross-validates claims (2+ sources each), and produces a structured report with inline citations and an explicit gaps section. Inspired by [karpathy/autoresearch](https://github.com/karpathy/autoresearch).

**[Writing](skills/writing/SKILL.md)** — prose craft cluster, type-first
- `writing` — The prose analog of `software-engineering`. Broad → narrow: first name the piece's type (argument / essay, explainer, narrative / memoir, poetry, review) — each has a spine that must hold (falsifiable thesis · teachable outcome · arc + stakes · image + turn · judgment + criteria) and its own binding sections: thesis + claims & evidence for arguments, arc / scene / show-don't-tell for narrative, image / line / turn + a preserve-strangeness editing rule for poetry — over a universal core of audience fit, sentence economy, and a coarse-to-fine revision protocol (structure → paragraph → sentence → read-aloud → cool-down) governed by an edit-depth contract (developmental / line / copyedit / proofread — problems outside the contract flagged, not fixed) and a preserve-the-author's-voice rule (no machine-prose tells; the general-prose form of poetry's preserve-strangeness). Pairs with `argumentation` §Steelyman (adversarial read), `diagnostic` §Feynman-Test (clarity), `research` (sourcing).

**[Writing-ship](skills/writing-ship/SKILL.md)** — publish-readiness gate for prose (meta-skill)
- `writing-ship` — Decides whether a piece (blog post, essay, story, poem, review) is ready to publish. Prose analog of `ship`: names the type, then an ordered, blocking filter — substance → craft → adversarial read → clarity → rights → privacy → mechanics → publish — delegating each stage to its owning skill (`writing`, `research`, `argumentation`, `diagnostic`, `legal`, `privacy`), stages binding per type (adversarial read / clarity report N/A for narrative and poetry rather than silently skipping), stopping at the first failure, emitting GO | NO-GO. Deterministic entry point: `/writing-ship`.

### Roadmap

Candidate skills identified as gaps in the current suite, in rough priority order; none drafted yet. The implemented skills now cover software engineering at the **code level** (design, architecture, review, debug, testing), the **docs corpus** ([`docs-review`](skills/docs-review/SKILL.md) — coverage / dedup / terseness / navigability audit), **planning** ([`planning`](skills/planning/SKILL.md) — goal decomposition feeding `delegation-ladder`), the **release & maintenance** side of going public — the [`ship`](skills/ship/SKILL.md) readiness gate (`/ship`) plus [`governance`](skills/governance/SKILL.md) (community-health authoring), [`privacy`](skills/privacy/SKILL.md) (personal-data hygiene), and [`release-engineering`](skills/release-engineering/SKILL.md) (versioning) for its stages — and **long-form prose**: [`writing`](skills/writing/SKILL.md) (craft) with [`writing-ship`](skills/writing-ship/SKILL.md) (`/writing-ship` publish gate). Remaining gaps:

1. **Estimation / forecasting** — Heuristics for time / cost / effort estimates: reference class forecasting, anchor-and-adjust, planning fallacy, range vs. point estimates, "the question is wrong" detection. Closes the loop with `decision-journal` — predictions logged there are the kind an estimation skill would help make well — and sizes the tasks `planning` produces.
2. **Communication for action** — PRs, RFCs, async status updates with audience-awareness and action-oriented framing. Distinct from `documentation` (which syncs docs with code) and from `writing` (long-form prose craft; this is short-form, decision-seeking).
3. **Data analysis hygiene** — Sanity checks, base rates, distribution awareness, outlier handling, confounders, Simpson's paradox, signal-vs-noise tests. `research` covers literature; this covers numbers.
4. **Performance engineering** — Measure-first profiling discipline, benchmark hygiene, complexity / latency budgets, premature-optimization guardrails. `debug` handles performance *regressions* reactively; nothing owns proactive performance work.
5. **Skill-authoring conventions** — Meta-skill: how a SKILL.md is written and wired in — dual-readable lossless compression, frontmatter shape (`description` triggers, `when_to_use`), catalog + roadmap bookkeeping, gate integration. Currently enforced only by the rule line above and git-history precedent; drift risk grows with each skill added.
6. **API design** — Public-API contracts for libraries / services: naming, error semantics, versioning surface, backward-compatibility design. `cli-devex` covers only the CLI surface; `release-engineering` detects breaking changes after the fact rather than designing to avoid them.

**Deferred — writing suite.** Proposed and consciously not in scope yet; recorded so the no is a decision (`planning` §Prioritization):
- `writing` §Narrative fiction mechanics (POV consistency · tense discipline · dialogue) — only if fiction becomes a real lane beyond memoir / personal essay.
- `writing` drafting mode (outlining · blank-page scaffolds) — generation is the author's lane (outline → second draft); revisit only if that division of labor changes.
- `writing-ship` audience / venue-fit stage — stage 7 venue rules cover it today; promote to a stage only if venue mismatches start passing the gate.
- `writing-ship` SEO / discovery checks — optimization ≠ readiness; would live beside the gate, not inside it.
- `writing-ship` accessibility beyond alt text (heading hierarchy · link text · contrast) — add if pieces grow structurally complex.
- Announcement / promo copy — already gap 2 above (communication for action), not a gate stage.
