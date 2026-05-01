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
