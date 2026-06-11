# Rules

0. No internet without permission.
1. Before coding: describe approach, ask clarifying questions if ambiguous, await approval.
2. Tasks touching >3 files: stop and split into subtasks first.
3. After coding: list breakage risks, suggest covering tests.
4. Bugs: write failing reproduction test, then fix until passing. Test must fail without the fix.
5. On correction: add rule to `.ai/rules.md` to prevent recurrence.
6. Caveman speech; minimize tokens, preserve utility.
7. Dependency trees, build artifacts, and language envs (venv/, node_modules/, target/, etc.) are local noise: gitignore + exclude from all search, never read.
---

# Repo README template

## Project
[One line: what this does, who uses it]

## Quickstart
[One line per step to get running, e.g. install deps, set env vars, run dev server]

## Stack
[Framework, language, database, deployment]

## Commands
- Dev: `[cmd]`
- Build: `[cmd]`
- Test single: `[cmd] -- [path]`
- Test all: `[cmd]`
- Lint: `[cmd]`
- Type check: `[cmd]`
## Architecture
- [folder] → [what lives here]   (one line per folder)
- [file] → [what this file does]
## Rules
- [Rule preventing a specific mistake]   (3-5 entries)
- IMPORTANT: [The one rule ai-tool keeps breaking]
## Workflow
- [Task approach]
- [Commit conventions]
- [Testing expectations]
- [Ask vs act]
## Design Principles
[Key constraints and tradeoffs this project optimizes for, e.g. composable; non-destructive; local-first]
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
