# AI Tooling Project Structure

Tool-agnostic layout for AI assistant context. Maps onto Claude Code, Cursor, Aider, Codex CLI, Continue, Copilot, etc.

```
project/
├── AGENTS.md              # Session context: stack, commands, constraints
├── AGENTS.local.md        # Personal overrides (gitignored)
├── .mcp.json              # MCP servers (external integrations)
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
4. `.mcp.json` — when the assistant needs external systems.
5. `.ai/hooks/` — when the harness should catch something deterministically.
6. `.ai/agents/` + `.ai/skills/` — when the main context gets crowded.

## In this repo

[`rules.md`](rules.md) holds cross-cutting AI rules for every project. The rest is a **template** to apply per-project, not implemented in this dotfiles repo.

## Skills

Reusable Socratic / argumentation / diagnostic skills any AI assistant can invoke. Tool-agnostic — drop into `.ai/skills/` or symlink into `.claude/skills/` per the tool mapping above. Organized into two cluster files.

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

**[Software engineering](skills/software-engineering/SKILL.md)** — coding principles cluster
- `design` — Clean code rules applied automatically: naming, function shape, class design (SRP/DIP), DRY, KISS/YAGNI, fail-fast, smell detection, and the Boy Scout Rule.
- `architecture` — Seam-first design: depend on interfaces, inject all external dependencies, keep infrastructure out of the logic layer. Makes vendors swappable and modules independently testable.

**[Research](skills/research/SKILL.md)** — multi-source investigation with citations
- `research` — Decomposes a question into sub-queries, searches across papers/docs/repos, cross-validates claims (2+ sources each), and produces a structured report with inline citations and an explicit gaps section. Inspired by [karpathy/autoresearch](https://github.com/karpathy/autoresearch).
