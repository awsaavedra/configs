# configs

Personal dotfiles and dev environment bootstrap for Linux/WSL2.

## Objective

Storage repo for personal configurations. Cloned onto a fresh machine, scripts apply locally — that's the entire workflow. Not a deployable product, not a library consumed by other projects, not application code. Pluck-as-needed: copy a dotfile, drop a skill into another project's `.ai/skills/`, run the bootstrap. Everything here is read-only reference for the outside world.

```
configs/
├── .ai-instructions/
│   ├── README.md
│   ├── rules.md
│   └── skills/
│       ├── argumentation/SKILL.md
│       ├── code-review/SKILL.md
│       ├── debug/SKILL.md
│       ├── delegation/SKILL.md
│       ├── diagnostic/SKILL.md
│       ├── research/SKILL.md
│       ├── security/SKILL.md
│       └── software-engineering/SKILL.md
├── .bash_profile
├── .bashrc
├── .claude/
│   ├── settings.json          # theme, status line (no secrets)
│   └── statusline-command.sh
├── .config/tmux/              # tmux theme + pane-color script
├── .gitignore
├── .tmux.conf
├── .vimrc
├── CLAUDE.md                 # session context for Claude Code
├── README.md
├── TODO-tools.md             # backlog of CLI tools to evaluate
└── scripts/
    ├── port-skills.sh         # copy skills + rules into another project
    ├── requirements.txt
    ├── setup.sh
    └── vm-linux-script-minify.sh
```

## Navigation

| Section | What's there |
|---|---|
| [Setup](#setup) | Bootstrap script — install everything on a fresh Linux/WSL2 machine |
| [Dotfiles](#dotfiles) | Shell, prompt, Claude Code config — what each file does and key aliases |
| [Tmux](#tmux) | Keybindings, TokyoNight theme, Eisenhower Matrix layout |
| [Vim](#vim) | `.vimrc` location and setup |
| [AI Instructions](#ai-instructions) | Cross-project AI behavioral rules, tool-agnostic structure template, and reusable skill clusters |
| [Porting](#porting) | One command to copy the skills + rules into another project |
| [IntelliJ](#intellij) | Key shortcuts reference |
| [Mac](#mac) | Quick-start checklist (iTerm2, Oh My Zsh, Rectangle, Homebrew) |
| [Windows](#windows) | VS Code + WSL2 setup notes |
| [TODO-tools.md](TODO-tools.md) | Curated checklist of CLI tools to evaluate (terminal, git, k8s, IaC, and more) |
| [VM Minify](#vm-minify) | Script to zero/compress a VM image before export |

---

## Setup

`setup.sh` bootstraps a fresh Linux/WSL2 machine. Idempotent — leaves a `~/.setup-complete` stamp so it only runs once (delete the stamp to re-run).

**What it does:**
1. `apt install` — build-essential, curl, git, vim, tmux, fzf, ripgrep, fd-find, bat, htop, jq, docker, python3, java toolchain (hugo, maven, gradle), etc.
2. Creates `~/.local/bin` symlinks for `bat` and `fd` (Debian renames them `batcat`/`fdfind`).
3. Adds your user to the `docker` group.
4. Installs **SDKMAN**, then Java 17 and Kotlin via `sdk install`.
5. Installs Python packages from `requirements.txt` via `pip3 --user`.
6. Copies dotfiles (`.bashrc`, `.bash_profile`, `.vimrc`, `.tmux.conf`, tmux theme, Claude Code config) into `$HOME`.

```bash
bash scripts/setup.sh
```

`scripts/requirements.txt` covers: numpy/pandas/matplotlib, PyTorch, HuggingFace Transformers, LlamaIndex stack, Jupyter, Flask, pytest.

---

## Dotfiles

| File | Purpose |
|---|---|
| `.bashrc` | Interactive shell — history, aliases, `vf`/`vr` functions, SDKMAN, PATH |
| `.bash_profile` | Login shell — sources `.bashrc`, sets colored prompt with git branch |
| `.tmux.conf` | Tmux config (see [Tmux](#tmux)) |
| `.vimrc` | Vim config (see [Vim](#vim)) |
| `.claude/settings.json` | Claude Code — dark theme, custom status line |
| `.claude/statusline-command.sh` | Status line: `user@host:cwd \| model \| ctx%` |

**Key aliases/functions in `.bashrc`:**
- `ll` / `la` / `l` — ls variants
- `vf` — fzf-pick a file and open in vim
- `vr <regex>` — ripgrep search, fzf-select result, open at matched line in vim

`.bash_profile` sets a colored prompt: `user @ dir (git-branch)`.

`.bashrc` auto-runs `setup.sh` on first login if `~/.setup-complete` doesn't exist.

---

## Tmux

Config: `.tmux.conf` + `.config/tmux/`

**Prefix:** `C-a` (remapped from `C-b`)

| Binding | Action |
|---|---|
| `C-a \|` | Split horizontal |
| `C-a -` | Split vertical |
| `C-a r` | Reload config |
| `C-a T` | Rename pane label |
| `C-a E` | Open Eisenhower Matrix layout |
| `C-h/j/k/l` | Navigate panes (no prefix) |

**Theme:** TokyoNight Moon (`.config/tmux/themes/tokyonight_moon.tmux`)

**Pane colors:** `.config/tmux/pane-color.sh` assigns a rotating dark hue (sage, teal, rose, lavender, etc.) to each new pane based on pane ID. Eisenhower windows manage their own colors.

**Eisenhower Matrix** (`C-a E`): Opens a 2×2 tiled window with color-coded quadrants — Do (green), Decide (blue), Delegate (rose), Delete (grey).

---

## Vim

Config: `.vimrc` — symlinked to `~/.vimrc` by `setup.sh`.

---

## AI Instructions

Three things live under [`.ai-instructions/`](.ai-instructions/):

- [`rules.md`](.ai-instructions/rules.md) — cross-cutting behavioral rules I want every AI assistant to follow in any project.
- [`README.md`](.ai-instructions/README.md) — a **tool-agnostic project structure** for organizing AI context (`AGENTS.md`, `.ai/rules/`, `.ai/commands/`, `.ai/skills/`, `.ai/agents/`, `.ai/hooks/`, `.mcp.json`). Generalized from Claude Code / Cursor / Aider / Codex CLI / Copilot conventions into one shared layout, with a cheatsheet mapping each concept to each tool.
- [`skills/`](.ai-instructions/skills/) — reusable skill clusters ready to drop into any project's `.ai/skills/` or `.claude/skills/`.

To copy them automatically, see [Porting](#porting).

---

## Porting

Drop this repo's AI-instruction layer (every skill cluster under `.ai-instructions/skills/` + `rules.md`) into another project with one command:

```bash
bash scripts/port-skills.sh /path/to/your/project
```

It auto-detects the target's AI tool and places files where that tool expects them:

| Target has | Skills land in | Rules land in |
|---|---|---|
| `.claude/` | `.claude/skills/` | managed block in `CLAUDE.md` |
| `.cursor/` | `.ai/skills/` | `.cursor/rules/configs.mdc` |
| `AGENTS.md` or `.ai/` | `.ai/skills/` | managed block in `AGENTS.md` |
| none of the above | `.ai/skills/` | managed block in `AGENTS.md` |

Idempotent — re-run to re-sync; it reports `created` / `updated` / `unchanged` per file and never duplicates the rules block. Flags: `--tool claude|ai|cursor` forces a layout, `--skills-only` skips rules, `--dry-run` previews, `-q` quiets output. Run with `--help` for details.

---

## IntelliJ

Key shortcuts:

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

---

## Mac

Quick setup checklist:

1. [iTerm2](https://iterm2.com/)
2. [Oh My Zsh](https://ohmyz.sh/)
3. [Rectangle](https://rectangleapp.com/) — window management
4. [Homebrew](https://brew.sh/)
5. vim

---

## Windows

Windows is not a primary dev machine.

- **VS Code** with: language extensions, vim keybindings, Markdown, Docker, Python/data science plugins. Consider Cursor.
- **WSL2** — run Linux tooling inside Windows; integrate with VS Code remote.
- VM environments (VirtualBox) for heavier isolation.

---

## VM Minify

`scripts/vm-linux-script-minify.sh` — stops all services (apache2, jenkins, jira, mysql, mongodb, etc.), prunes Docker completely, cleans apt caches, removes swap, zeroes free disk space, and prepares the VM image for export/transport.

```bash
# Run as root inside the VM before exporting
sudo bash scripts/vm-linux-script-minify.sh
```
