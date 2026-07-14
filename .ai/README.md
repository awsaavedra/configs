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

**Rule:** All rules must be dual-readable (human + agent) and losslessly compressed to minimum tokens. Authoring + wiring conventions for the skills themselves: [`skill-authoring`](skills/skill-authoring/SKILL.md).

**Catalog standards** — binding on every catalog change, agent or human:

1. **One sentence per skill** — what it's for; how to invoke. Terse and lossless as a map: routing information may not be dropped, everything else lives in the skill's own `SKILL.md`, never here. The catalog is a map, not a mirror.
2. **Exclusive lanes, no intra-lane redundancy** — every skill lives in exactly one lane; **Both** only when it genuinely serves Software and Writing alike. No two skills in a lane own the same thing — overlap means a boundary is missing in the skills themselves.
3. **Everything else is roadmap** — a new skill or lane (math, physics, …) is recorded in [roadmap.md](roadmap.md) *before* drafting; closing a gap lands as one catalog line in its lane, same commit (`skill-authoring` §Wiring).
4. **Comprehensive or broken** — every skill in [`skills/`](skills/) appears exactly once below; a skill absent from the catalog, or cataloged but deleted, fails audit (`/docs-review`).

### Software

- [`software-engineering`](skills/software-engineering/SKILL.md) — Always-on coding principles, auto-engaged whenever code is written: `/design` (clean code) · `/architecture` (seams) · `/cli-devex` (CLI contracts) · `/documentation` (docs–code sync).
- [`api-design`](skills/api-design/SKILL.md) — Designs a public contract — surface, ergonomics, error semantics, compatibility — before it ships; `/api-design` when shaping exports, endpoints, or config keys.
- [`testing`](skills/testing/SKILL.md) — Test design, not just running: pyramid, what-to-test, doubles at seams, property-based, characterization; `/testing` when deciding what and how to test.
- [`debug`](skills/debug/SKILL.md) — Phased root-cause investigation (reproduce → hypothesize → eliminate → fix → verify); `/debug` before proposing any fix for a bug, failure, or regression.
- [`performance`](skills/performance/SKILL.md) — Proactive budgets, measure-first profiling, benchmark hygiene; `/performance` for optimization work — regressions are `debug`'s lane.
- [`security`](skills/security/SKILL.md) — Read-only security review emitting tiered findings; `/security [scope]` over code, agents, infra, or threat model.
- [`code-review`](skills/code-review/SKILL.md) — Audits existing code against the `software-engineering` rules, emitting per-line fixes or PASS; `/review`.
- [`docs-review`](skills/docs-review/SKILL.md) — Audits the whole docs corpus, ordered currency → coverage → one-authoritative-home → terseness → navigability; `/docs-review`.
- [`release-engineering`](skills/release-engineering/SKILL.md) — Versions and cuts releases: SemVer, changelog, deprecation policy, breaking-change detection; `/release`.
- [`governance`](skills/governance/SKILL.md) — License selection, community-health files, and disclosure process for going public; `/governance`.
- [`ship`](skills/ship/SKILL.md) — Blocking release-readiness gate running this lane's skills (plus `legal` / `privacy`) as ordered stages, emitting GO | NO-GO; `/ship`.

### Writing

- [`writing`](skills/writing/SKILL.md) — Type-first prose craft: name the piece's type, apply only the rules that bind it, edit at the contracted depth, preserve the author's voice; `/writing` on anything meant for readers.
- [`writing-draft`](skills/writing-draft/SKILL.md) — Author-first development loop — the author drafts, the skill answers with angles, expansions, and trims until neither moves; `/writing-draft` from outline to settled draft.
- [`communication`](skills/communication/SKILL.md) — Short-form decision-seeking writing (PR descriptions, RFCs, status updates, asks): BLUF, one message one ask; `/communication`.
- [`writing-ship`](skills/writing-ship/SKILL.md) — Blocking type-aware publish gate running this lane's skills (plus `research` / `argumentation` / `diagnostic` / `legal` / `privacy`) as ordered stages, emitting GO | NO-GO; `/writing-ship`.

### Both

- [`argumentation`](skills/argumentation/SKILL.md) — Argument hygiene and productive disagreement: `/argumentation-hygiene` (audit an argument), `/you-sure` (self-audit a claim), `/steelyman` (adversarial review), `/double-crux` (locate the real disagreement).
- [`diagnostic`](skills/diagnostic/SKILL.md) — Failure and comprehension probes: `/pre-mortem` (assume it failed), `/five-whys` (root cause), `/feynman-test` (explain without jargon), `/decision-journal` (log predictions for calibration).
- [`planning`](skills/planning/SKILL.md) — Decomposes an ambiguous goal into definition-of-done, milestones, dependencies, and a NOT-doing list; `/planning` before routing or estimating work.
- [`estimation`](skills/estimation/SKILL.md) — Calibrated time / cost / effort ranges — reference class first, P50–P90 over points; `/estimate` before promising dates.
- [`delegation`](skills/delegation/SKILL.md) — Routes work to the architecture, pattern, or code level before acting; `/delegate` on ambiguously-scoped tasks.
- [`research`](skills/research/SKILL.md) — Multi-source investigation with cross-validated citations and named gaps; auto-engages on "research" / "compare" / "literature review".
- [`data-analysis`](skills/data-analysis/SKILL.md) — Hygiene for conclusions drawn from numbers — provenance, distributions, confounders, noise guards; `/data-analysis` on metrics, benchmarks, experiments.
- [`legal`](skills/legal/SKILL.md) — Protective release boilerplate (AS-IS, liability, NOTICE, trademark) with a hard not-legal-advice boundary; `/legal`.
- [`privacy`](skills/privacy/SKILL.md) — Decides whether personal data gets published at all; never auto-fill a personal identifier into a public artifact; `/privacy` on anything public-bound.
- [`skill-authoring`](skills/skill-authoring/SKILL.md) — The suite's own authoring and wiring conventions (kinds, frontmatter, compression, bookkeeping); `/skill-authoring` when adding or revising a skill.

### Roadmap

Open gaps and future lanes (math, physics, …) live in [roadmap.md](roadmap.md) — a candidate skill or lane is recorded there *before* drafting; closing a gap lands as one catalog line in its lane, same commit (`skill-authoring` §Wiring). The lanes above are the coverage map.

**Deferred — writing suite.** Proposed and consciously not in scope yet; recorded so the no is a decision (`planning` §Prioritization):
- `writing` §Narrative fiction mechanics (POV consistency · tense discipline · dialogue) — only if fiction becomes a real lane beyond memoir / personal essay.
- `writing-ship` audience / venue-fit stage — stage 7 venue rules cover it today; promote to a stage only if venue mismatches start passing the gate.
- `writing-ship` SEO / discovery checks — optimization ≠ readiness; would live beside the gate, not inside it.
- `writing-ship` accessibility beyond alt text (heading hierarchy · link text · contrast) — add if pieces grow structurally complex.
- Announcement / promo copy — [`communication`](skills/communication/SKILL.md)'s lane (writing for action), not a gate stage.
