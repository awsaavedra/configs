# AGENTS.md

Session context for any AI agent (Claude Code, Cursor, Copilot, Codex, …) working in this repo. `CLAUDE.md` is a thin pointer to this file so Claude Code loads it too.

## What this repo is

Storage repo for personal configurations — dotfiles, AI instruction templates, reusable skills, and a bootstrap script. Not a deployable product, not application code, not a library imported by other projects. Cloned onto a fresh machine, the bootstrap runs locally, that's it.

## What this means for edits

- **Most changes are single-file dotfile tweaks.** Editing `.bashrc`, `.vimrc`, a `SKILL.md` — no build step, no test suite, no CI.
- **No tests to run, no type check to pass.** Validation is reading the file and reasoning about shell/vim/markdown correctness. Lint with `shellcheck` if the change is non-trivial bash.
- **Atomicity matters.** Docs (`README.md`, `.ai/README.md`) and the thing they describe must update together — see `.ai/skills/software-engineering/SKILL.md` Documentation rules.
- **No volatile enumerations.** Don't write counts ("eight skills") or exhaustive lists of growing collections in prose — they go stale silently.

## Where things live

- `.ai/` — tool-agnostic AI layer: cross-project rules (`rules.md`) + reusable skill clusters (`skills/`). The `skills/` subdirectory is meant to be plucked into other projects' `.ai/skills/` or `.claude/skills/`.
- `scripts/port.sh` — one command to port selected skills / dotfile configs / a CLI-tool installer into another project, auto-detecting its AI tool (`.claude/` / `.cursor/` / `.ai/`). Idempotent; writes only inside the target. This is what "port … into my project" resolves to.
- `scripts/setup.sh` — idempotent bootstrap; stamp file at `~/.setup-complete` prevents re-runs.
- `.bashrc`, `.bash_profile`, `.vimrc`, `.tmux.conf`, `.config/tmux/`, `claude/` — dotfile sources copied into `$HOME` by setup.sh. `claude/` holds the deliberate Claude Code config (`settings.json` + `statusline-command.sh`) deployed to `~/.claude/`.
- Per-CLI harness dirs (`.claude/`, `.cursor/`, `.copilot/`, …) and the generated `CLAUDE.md` adapter are gitignored — they hold tool-specific session data, transcripts, and credentials and must never be committed (PII protection; see `.gitignore`). The portable, CLI-agnostic layer is `.ai/` + `AGENTS.md`; setup.sh regenerates the local `CLAUDE.md` pointer on a fresh clone.
- `TODO-tools.md` — backlog of CLI tools under evaluation. Not installed by the bootstrap.

## Conventions

- Commit messages: `#type, what; what; what` — type is `add`/`fix`/`doc`/`refactor`/`stabilize`/`edit`. No Co-Authored-By trailer.
- Skill files are losslessly compressed — separator-style inline lists, no prose padding. Match the existing style when editing.
- Behavioral rules for any AI assistant working in any project live in `.ai/rules.md`.
