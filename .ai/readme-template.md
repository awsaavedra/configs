# Repo README template

Skeleton for a project README — fill the bracketed placeholders, drop sections that don't apply. Pairs with [`rules.md`](rules.md) (the 0–7 behavioral rules); the `## Rules` section below is where project-specific rules go, seeded by the high-impact examples at the bottom.

**Convention:** the README is a thin index — one scannable line per topic. Long-form documentation (design rationale, roadmap detail, support matrix, ADRs, ops runbooks) lives under `docs/` and is *linked* from here, never inlined. This keeps the README skimmable and lets each doc evolve on its own cadence. A section that grows past a few lines is a signal to move its body into `docs/<topic>.md` and leave a one-line pointer.

## Project
[One line: what this does, who uses it]

## Design Principles
[Key constraints and tradeoffs this project optimizes for, e.g. composable; non-destructive; local-first]

One line per principle here; full design choices — constraints, tradeoffs, rejected alternatives — live in [`docs/design.md`].

## Quickstart
[One line per step to get running, e.g. install deps, set env vars, run dev server]

## Stack
[Framework, language, database, deployment]

## Supported
[Operating systems / arch, runtime or language version range, hardware minimums — one line]

Brief here; the full compatibility matrix — per-version OS support, arch, runtime ranges, tested-vs-best-effort tiers — lives in [`docs/support.md`]. This is current-state compatibility, distinct from the time-ordered [`docs/roadmap.md`].

## Commands
- Dev: `[cmd]`
- Build: `[cmd]`
- Test single: `[cmd] -- [path]`
- Test all: `[cmd]`
- Lint: `[cmd]`
- Type check: `[cmd]`
## Architecture
**Flat bullet list only — no ASCII tree diagrams.** One line per entry; top-level folders and key files only. Trees look good once and go stale silently — a flat list is easier to maintain and diff.
- `[folder]/` → [what lives here]
- `[file]` → [what this file does]
- `mcp/<server>/` → in-repo MCP server implementations; the root `.mcp.json` declares/launches them (omit if you only consume published servers)
## Rules
- [Rule preventing a specific mistake]   (3-5 entries)
- IMPORTANT: [The one rule ai-tool keeps breaking]
## Workflow
- [Task approach]
- [Commit conventions]
- [Testing expectations]
- [Ask vs act]

## Roadmap
| Version | Status | Theme |
|---|---|---|
| **v0** | ✅ shipped | [one-line capability theme] |
| **v1** | 🟡 in progress | [theme] |
| **v2** | 🔵 planned | [theme] |

Status key: ✅ shipped · 🟡 in progress · 🔵 planned · ⏸ paused · ❌ dropped. Tag shipped versions (e.g. `v1.0.0`). One line per version here; full item lists, rationale, and rejected alternatives live in [`docs/roadmap.md`]. Link each milestone to what substantiates it — specs/tests (e.g. `tests/…`), design notes / ADRs (e.g. `docs/design-notes.md`). No volatile per-item lists in the README.
## Out of scope
- [Don't-touch areas]
- [Manually-maintained files]
- [Off-limits integrations]

---

# High-impact rule examples
- IMPORTANT: type check after every code change (prevents shipping broken types)
- Minimal changes; no unrelated refactoring (prevents whole-file rewrites)
- Separate commit per logical change (prevents 47-file monster commits)
- When unsure, present alternatives; I choose (prevents unilateral architecture decisions)
- Static export only, no SSR (prevents server-side code in static sites)
