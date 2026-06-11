# configs

## Project

Personal dotfiles, a fresh-machine bootstrap, and a portable AI-instruction layer for Linux/WSL2. Single user; cloned onto a new machine, the scripts apply everything locally — read-only reference for the outside world.

## Quickstart

```bash
git clone <this-repo> configs && cd configs
bash scripts/setup.sh                          # bootstrap a fresh Linux/WSL2 machine (idempotent)
bash scripts/port-skills.sh /path/to/project   # optional: drop the AI skills + rules into another project
```

## Stack

Bash · Vim · Tmux · Markdown. Target: Linux/WSL2 (Mac/Windows notes under [Reference](#reference)). No runtime, build graph, or dependencies — these are config files applied in place. `setup.sh` installs the surrounding toolchain: git, fzf, ripgrep, fd, bat, jq, docker, Python 3, SDKMAN (Java 17 + Kotlin), NVM/Node, Claude Code.

## Commands

- Bootstrap: `bash scripts/setup.sh` — idempotent; `~/.setup-complete` stamp gates re-runs (delete it to re-run).
- Port AI layer: `bash scripts/port-skills.sh [--tool claude|ai|cursor] [--skills-only] [--dry-run] [-q] TARGET_DIR` — see [Reference](#reference).
- Slim a VM image: `sudo bash scripts/vm-linux-script-minify.sh` — run as root inside the VM before export.
- Build / Test / Lint / Type-check: none — config repo. Validation is reading the file; lint non-trivial bash with `shellcheck`.

## Architecture

```
configs/
├── .ai/                       # portable, CLI-agnostic AI layer
│   ├── README.md              #   tool-agnostic structure template + skill catalog
│   ├── rules.md               #   behavioral rules for any AI assistant, any project
│   └── skills/                #   reusable SKILL.md clusters (losslessly compressed)
├── scripts/
│   ├── setup.sh               # idempotent fresh-machine bootstrap
│   ├── port-skills.sh         # copy the AI layer into another project (auto-detects its tool)
│   ├── vm-linux-script-minify.sh  # zero/compress a VM image before export
│   └── requirements.txt       # Python packages installed by setup
├── claude/                    # Claude Code dotfile sources (settings + statusline) → ~/.claude/
├── .bashrc / .bash_profile    # interactive + login shell — aliases, vf/vr, git-branch prompt, PATH
├── .vimrc                     # vim config
├── .tmux.conf / .config/tmux/ # tmux config + TokyoNight Moon theme + pane colors + Eisenhower layout
├── AGENTS.md                  # session context for any AI agent (CLAUDE.md is a gitignored local pointer)
└── TODO-tools.md              # backlog of CLI tools to evaluate (not installed by the bootstrap)
```

The `skills/` subdirectory is the portable unit — pluck a `SKILL.md` into another project's `.ai/skills/` or `.claude/skills/`, or use `port-skills.sh` to copy the whole layer.

## Rules

- **Atomic docs.** Update `README.md` / `.ai/README.md` in the same commit as the thing they describe.
- **No volatile enumerations.** No counts or exhaustive lists of growing collections (e.g. the skill set) — they go stale silently.
- **Compressed skills.** `SKILL.md` files use separator-style inline lists, no prose padding; match the existing style.
- **No internet without permission** (`.ai/rules.md` rule 0); secrets never enter the repo.
- **CLI-agnostic, PII-safe.** The portable layer is `.ai/` + `AGENTS.md`. Per-CLI harness dirs (`.claude/`, `.cursor/`, `.copilot/`, …) and the generated `CLAUDE.md` pointer are gitignored — they carry session data / credentials and must never be committed.
- IMPORTANT: this is a storage repo, not application code — most changes are single-file dotfile/`SKILL.md` tweaks. Don't add build systems, frameworks, or a test harness.

## Workflow

- **Approach.** Smallest change that works; match surrounding style. Describe the approach and ask before large or lossy changes; small dotfile tweaks act directly.
- **Commits.** `#type, what; what; what` — type ∈ `add`/`fix`/`doc`/`refactor`/`stabilize`/`edit`, clauses semicolon-separated. No Co-Authored-By trailer.
- **Testing.** Reason about shell/vim/markdown correctness by reading; functionally test scripts (e.g. `port-skills.sh`) against throwaway temp dirs.

## Design Principles

Pluck-as-needed · tool-agnostic (the AI layer maps onto Claude Code / Cursor / Codex / Copilot) · idempotent (`setup.sh` and `port-skills.sh` re-run safely) · local-first and non-destructive (writes only where told; stamp files and self-port guards prevent surprises) · read-only reference for the outside world.

## Out of scope

- Not a deployable product, library, or application code.
- Secrets — `claude/settings.json` carries theme/status-line only; live per-CLI dirs (`.claude/`, `.cursor/`, …) and `CLAUDE.md` are gitignored so session data never lands in git; never commit credentials.
- `.bashrc` / `.vimrc` / tmux config are personal — fork and adjust, not general-purpose defaults.
- `TODO-tools.md` is a backlog under evaluation, not an install manifest.

---

## Reference

### Setup details

`setup.sh` (idempotent):

1. `apt install` — build-essential, curl, git, vim, tmux, fzf, ripgrep, fd-find, bat, htop, jq, docker, python3, and a Java toolchain (hugo, maven, gradle).
2. `~/.local/bin` symlinks for `bat` and `fd` (Debian ships them as `batcat`/`fdfind`).
3. Adds the current user to the `docker` group.
4. Installs SDKMAN, then Java 17 and Kotlin via `sdk install`.
5. Installs Python packages from `requirements.txt` via `pip3 --user` (numpy/pandas/matplotlib, PyTorch, HuggingFace Transformers, LlamaIndex stack, Jupyter, Flask, pytest).
6. Copies dotfiles (`.bashrc`, `.bash_profile`, `.vimrc`, `.tmux.conf`, tmux theme, Claude Code config) into `$HOME`.

`.bashrc` auto-runs `setup.sh` on first interactive login when `~/.setup-complete` is absent.

### Dotfiles

| File | Purpose |
|---|---|
| `.bashrc` | Interactive shell — history, aliases, `vf`/`vr` functions, SDKMAN, PATH |
| `.bash_profile` | Login shell — sources `.bashrc`, sets colored `user @ dir (git-branch)` prompt |
| `claude/settings.json` | Claude Code — dark theme, custom status line (deployed to `~/.claude/`) |
| `claude/statusline-command.sh` | Status line: `(git-branch) \| model \| ctx%` |

Key aliases/functions: `ll`/`la`/`l` (ls variants) · `vf` (fzf-pick a file, open in vim) · `vr <regex>` (ripgrep → fzf-select → open at the matched line).

### Porting (`port-skills.sh`)

Copies every skill cluster under `.ai/skills/` plus `rules.md` into a target project, auto-detecting its AI tool:

| Target has | Skills land in | Rules land in |
|---|---|---|
| `.claude/` | `.claude/skills/` | managed block in `CLAUDE.md` |
| `.cursor/` | `.ai/skills/` | `.cursor/rules/configs.mdc` |
| `AGENTS.md` or `.ai/` | `.ai/skills/` | managed block in `AGENTS.md` |
| none of the above | `.ai/skills/` | managed block in `AGENTS.md` |

Idempotent — re-run to re-sync; reports `created`/`updated`/`unchanged` per file and never duplicates the rules block. Flags: `--tool` forces a layout, `--skills-only` skips rules, `--dry-run` previews, `-q` quiets. Exit codes: 0 ok · 1 usage · 2 target missing · 3 source missing.

### Tmux

Config: `.tmux.conf` + `.config/tmux/`. **Prefix:** `C-a` (remapped from `C-b`).

| Binding | Action |
|---|---|
| `C-a \|` | Split horizontal |
| `C-a -` | Split vertical |
| `C-a r` | Reload config |
| `C-a T` | Rename pane label |
| `C-a E` | Open Eisenhower Matrix layout |
| `C-h/j/k/l` | Navigate panes (no prefix) |

**Theme:** TokyoNight Moon (`.config/tmux/themes/tokyonight_moon.tmux`). **Pane colors:** `.config/tmux/pane-color.sh` assigns a rotating dark hue per pane ID (Eisenhower windows manage their own). **Eisenhower Matrix** (`C-a E`): a 2×2 tiled window — Do (green), Decide (blue), Delegate (rose), Delete (grey).

### Vim

`.vimrc` — symlinked to `~/.vimrc` by `setup.sh`.

### IntelliJ

| Shortcut | Action |
|---|---|
| `Shift+Shift` | Search everywhere |
| `Shift+Cmd+A` | Find action |
| `Cmd+E` | Recent files |
| `Cmd+G` | Toggle through word instances |
| `Ctrl+Cmd+G` | Select all instances in file |
| `Alt+Shift+click` | Multi-cursor |
| `Cmd+Alt+L` | Format file |
| `Shift+Cmd+Enter` | Auto-complete statement |
| `Cmd+K` | Commit |
| `Cmd+[` / `Cmd+]` | Navigate back/forward |
| `F1` | Hover docs |
| `Alt+Enter` | Quick fix / generate test |

Notable features: distraction-free mode, dependency analysis, zero-latency typing.

### Mac

Quick setup checklist: [iTerm2](https://iterm2.com/) · [Oh My Zsh](https://ohmyz.sh/) · [Rectangle](https://rectangleapp.com/) (window management) · [Homebrew](https://brew.sh/) · vim.

### Windows

Not a primary dev machine. **VS Code** with language extensions, vim keybindings, Markdown, Docker, and Python/data-science plugins (consider Cursor). **WSL2** for Linux tooling, integrated with VS Code remote. VirtualBox VMs for heavier isolation.

### TODO-tools

[`TODO-tools.md`](TODO-tools.md) — curated checklist of CLI tools to evaluate (terminal, git, k8s, IaC, and more). Candidates, not commitments; nothing there is installed by the bootstrap.
