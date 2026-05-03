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

Reusable Socratic / argumentation / diagnostic skills any AI assistant can invoke. Tool-agnostic — drop into `.ai/skills/` or symlink into `.claude/skills/` per the tool mapping above.

**Argumentation cluster:**
- [`you-sure`](skills/you-sure/SKILL.md) — AI self-audits a confident claim. Restate, ITT the strongest opposing view, surface load-bearing assumptions, revise. Triggered by `/you-sure` or user pushback ("you sure?", "really?").
- [`steelyman`](skills/steelyman/SKILL.md) — AI sparring partner for the user's writing/coding/planning/design decisions. ITT the user's view, voice the strongest opposition, hold the position under pushback, fold only when the user gives a real answer. Triggered by `/steelyman` or invitations like "tear this apart."
- [`double-crux`](skills/double-crux/SKILL.md) — Symmetric productive disagreement. Each side names what evidence would flip their position; locate whether the disagreement is shared crux, crux-mismatch, values-level, framing-level, or empty.
- [`argumentation-hygiene`](skills/argumentation-hygiene/SKILL.md) — Umbrella reference: good-faith principles (charity, cruxes, bet-grade confidence, surprise as diagnostic, spirit-vs-letter), bad-faith taxonomy (motte-and-bailey, sealioning, gish gallop, etc.), self-audit checks.

**Diagnostic / comprehension cluster:**
- [`pre-mortem`](skills/pre-mortem/SKILL.md) — Imagine failure before commitment; surface specific failure modes and early-warning signals.
- [`five-whys`](skills/five-whys/SKILL.md) — Root-cause Socratic for bugs and surprising outcomes. Drill from surface to actionable root, evidence at each level.
- [`feynman-test`](skills/feynman-test/SKILL.md) — Comprehension audit by simple explanation. The points where you reach for jargon are the points you don't actually understand.
- [`decision-journal`](skills/decision-journal/SKILL.md) — Record decisions + predictions + confidence for later calibration audit. Practice across time, not in-conversation.
