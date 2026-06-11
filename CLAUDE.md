# CLAUDE.md

Session context for Claude Code working in this repo.

## What this repo is

Storage repo for personal configurations — dotfiles, AI instruction templates, reusable skills, and a bootstrap script. Not a deployable product, not application code, not a library imported by other projects. Cloned onto a fresh machine, the bootstrap runs locally, that's it.

## What this means for edits

- **Most changes are single-file dotfile tweaks.** Editing `.bashrc`, `.vimrc`, a `SKILL.md` — no build step, no test suite, no CI.
- **No tests to run, no type check to pass.** Validation is reading the file and reasoning about shell/vim/markdown correctness. Lint with `shellcheck` if the change is non-trivial bash.
- **Atomicity matters.** Docs (`README.md`, `.ai-instructions/README.md`) and the thing they describe must update together — see `.ai-instructions/skills/software-engineering/SKILL.md` Documentation rules.
- **No volatile enumerations.** Don't write counts ("eight skills") or exhaustive lists of growing collections in prose — they go stale silently.

## Where things live

- `.ai-instructions/` — cross-project AI rules + reusable skill clusters. The `skills/` subdirectory is meant to be plucked into other projects' `.ai/skills/` or `.claude/skills/`.
- `scripts/port-skills.sh` — copies `.ai-instructions/` (skills + `rules.md`) into another project, auto-detecting its AI tool (`.claude/` / `.cursor/` / `.ai/`). Idempotent; writes only inside the target. This is what "port all skills into my project" resolves to.
- `scripts/setup.sh` — idempotent bootstrap; stamp file at `~/.setup-complete` prevents re-runs.
- `.claude/`, `.bashrc`, `.bash_profile`, `.vimrc`, `.tmux.conf`, `.config/tmux/` — dotfiles copied into `$HOME` by setup.sh.
- `TODO-tools.md` — backlog of CLI tools under evaluation. Not installed by the bootstrap.

## Conventions

- Commit messages: `#type, what; what; what` — type is `add`/`fix`/`doc`/`refactor`/`stabilize`/`edit`. No Co-Authored-By trailer.
- Skill files are losslessly compressed — separator-style inline lists, no prose padding. Match the existing style when editing.
- Behavioral rules for any AI assistant working in any project live in `.ai-instructions/rules.md`.
