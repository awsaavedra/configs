# TODO: Tools to Evaluate

Curated checklist of CLI tools, frameworks, and utilities to evaluate for potential adoption. Nothing here is installed by the bootstrap — these are candidates, not commitments.

**Terminal Emulators**
- [ ] **Ghostty** — GPU-accelerated, native UI, config-file-driven
- [ ] **Wezterm** — GPU terminal with Lua config and built-in multiplexing
- [ ] **Alacritty** — Minimal, blazing fast, zero features beyond rendering
- [ ] **Kitty** — GPU terminal with image protocol, tiling layouts, and kittens

**Shell & Prompt**
- [ ] **Starship** — Cross-shell prompt via TOML; shows git, lang versions, cloud context
- [ ] **Fish shell** — Autosuggestions + syntax highlighting out of the box
- [ ] **Atuin** — Replaces shell history with SQLite; cross-machine sync + fuzzy search
- [ ] **Nushell** — Shell that treats all data as typed tables
- [ ] **zsh-autosuggestions** — Fish-style inline suggestions from history
- [ ] **zsh-syntax-highlighting** — Fish-like command highlighting as you type

**Multiplexers**
- [ ] **Zellij** — tmux alternative with layouts, floating panes, and WebAssembly plugins
- [ ] **tmuxinator** — YAML-defined tmux session layouts per project

**File Navigation**
- [ ] **Yazi** — Async file manager; image previews, vim keybindings, plugin system
- [ ] **Broot** — Tree navigator with inline fuzzy search
- [ ] **lf** — Lightweight ranger-like manager; fully shell-scriptable
- [ ] **nnn** — Extremely fast, minimal; large plugin ecosystem

**Dotfile Management**
- [ ] **chezmoi** — Manages dotfiles across machines with templating + secret integration
- [ ] **GNU Stow** — Symlink farm manager; organizes dotfiles into per-app packages
- [ ] **yadm** — Uses git directly; supports alternate files per host/OS

**Git Tools**
- [ ] **lazygit** — Full TUI for git; stage hunks, interactive rebase, stash browser
- [ ] **delta** — Syntax-highlighted pager for `git diff`; side-by-side view
- [ ] **tig** — Text-mode git log/blame/stash browser
- [ ] **gh CLI** — Official GitHub CLI; PRs, issues, Actions from terminal
- [ ] **gitui** — Rust-based lazygit alternative
- [ ] **git-absorb** — Auto-amends staged changes into the right fixup commit

**Modern CLI Replacements**
- [ ] **eza** — `ls` replacement with git status, icons, tree view
- [ ] **zoxide** — Smarter `cd` that learns frecency
- [ ] **sd** — Intuitive `sed` replacement; literal string mode
- [ ] **dust** — `du` replacement; visual proportional tree of disk usage
- [ ] **duf** — `df` replacement; colored disk usage overview by mount point
- [ ] **procs** — `ps` replacement with colors, tree view, Docker awareness
- [ ] **choose** — `cut`/`awk` replacement for selecting delimited fields
- [ ] **moar** — `less` replacement; mouse support + syntax highlighting
- [ ] **dog** — `dig` replacement; colored DNS queries with JSON output

**Diff Tools**
- [ ] **difftastic** — Structural diff that understands syntax, not just text
- [ ] **icdiff** — Side-by-side colored diff as a drop-in `diff` replacement

**Search & Text Processing**
- [ ] **ast-grep** — Structural code search/replace using AST patterns
- [ ] **gron** — Transforms JSON into grep-able `key=value` lines
- [ ] **jless** — Interactive navigable JSON pager
- [ ] **fx** — Interactive terminal JSON viewer with JS transformation REPL
- [ ] **yq** — jq-like processor for YAML, JSON, TOML, and XML
- [ ] **pup** — HTML processor using CSS selectors

**CSV & Data Tools**
- [ ] **miller (mlr)** — `awk`-like stream processor for CSV/TSV/JSON
- [ ] **xsv** — Fast CSV toolkit for slicing, joining, and searching
- [ ] **visidata** — TUI spreadsheet for exploring tabular data interactively
- [ ] **dsq** — Run SQL queries against CSV, JSON, Parquet files directly

**Log Viewing & Analysis**
- [ ] **lnav** — Advanced log navigator; auto-detects formats, supports SQL queries
- [ ] **tailspin** — Auto-colorizes timestamps, IPs, URLs, and severity levels in logs
- [ ] **angle-grinder** — Splunk-like query syntax over log files or stdin

**System Monitoring**
- [ ] **btop** — Beautiful resource monitor; successor to htop with graphs
- [ ] **glances** — Cross-platform overview of CPU, mem, disk, net, processes
- [ ] **bottom (btm)** — Rust-based monitor with customizable widget layout
- [ ] **bandwhich** — Network utilization broken down by process and connection

**Container Tools**
- [ ] **lazydocker** — TUI dashboard for Docker/Compose; containers, logs, stats
- [ ] **dive** — Explores Docker image layers to find what's bloating image size
- [ ] **ctop** — `top`-like interface for per-container CPU/mem/net metrics
- [ ] **podman** — Daemonless, rootless Docker-compatible container engine

**Kubernetes Tools**
- [ ] **k9s** — TUI for Kubernetes; navigate clusters, tail logs, exec into pods
- [ ] **kubectx / kubens** — Fast context and namespace switching for kubectl
- [ ] **stern** — Multi-pod log tailing; streams from many pods simultaneously

**Database CLIs**
- [ ] **pgcli** — PostgreSQL CLI with auto-completion and syntax highlighting
- [ ] **mycli** — MySQL CLI with auto-completion and syntax highlighting
- [ ] **litecli** — SQLite CLI with auto-completion
- [ ] **usql** — Universal SQL CLI connecting to Postgres, MySQL, SQLite, and more

**HTTP & API Tools**
- [ ] **xh** — Fast httpie-like HTTP client in Rust
- [ ] **hurl** — Runs HTTP requests from plain text files; good for scripting/testing
- [ ] **posting** — TUI HTTP client with Postman-like interface in the terminal

**Network Tools**
- [ ] **mtr** — Combines traceroute + ping into a live per-hop latency display
- [ ] **gping** — Ping multiple hosts simultaneously with live graph visualization
- [ ] **bandwhich** — Per-process network utilization monitor

**SSH & Remote Access**
- [ ] **mosh** — SSH over UDP; stays connected through roaming and poor networks
- [ ] **sshuttle** — Routes traffic through SSH like a lightweight VPN
- [ ] **autossh** — Auto-restarts SSH sessions and tunnels on disconnect

**Secrets & Security**
- [ ] **age** — Simple, modern file encryption; designed to replace GPG
- [ ] **sops** — Encrypts specific values inside YAML/JSON config
- [ ] **gopass** — Team-oriented `pass` rewrite with secret sharing
- [ ] **trufflehog** — Scans git history for secrets and credential leaks
- [ ] **gitleaks** — Detects hardcoded secrets in repos via regex rules
- [ ] **trivy** — Vulnerability scanner for containers, filesystems, and git repos
- [ ] **grype** — Container and filesystem vulnerability scanner from Anchore

**Keyboard Remapping**
- [ ] **keyd** — Kernel-level key remapper for Linux; supports layers and tap-hold
- [ ] **Karabiner-Elements** — Powerful macOS keyboard customizer
- [ ] **Kanata** — Cross-platform key remapper with advanced layer and chord support

**Window Management**
- [ ] **yabai** — Scripted tiling window manager for macOS
- [ ] **i3** — Keyboard-driven tiling window manager for X11
- [ ] **sway** — Wayland-native i3 replacement

**Build & Task Runners**
- [ ] **just** — `make` replacement with simpler syntax and cross-platform support
- [ ] **task (go-task)** — YAML-based Taskfile runner
- [ ] **mage** — Make-like build tool using real Go code

**Language / Tool Version Managers**
- [ ] **mise** — Fast asdf-compatible polyglot version manager in Rust
- [ ] **asdf** — Universal version manager via plugin system + `.tool-versions`
- [ ] **pyenv** — Manages multiple Python versions per project or shell

**Package Managers & Env Isolation**
- [ ] **Nix** — Purely functional package manager; fully reproducible, declarative envs
- [ ] **devbox** — Wraps Nix for portable shell environments via simple JSON config
- [ ] **pipx** — Installs Python CLI tools in isolated venvs

**Infrastructure as Code**
- [ ] **Terraform** — Declarative HCL to provision infrastructure across cloud providers
- [ ] **Pulumi** — IaC using real languages (TypeScript, Python, Go) instead of DSL
- [ ] **Ansible** — Agentless config management and deployment over SSH

**Cloud CLIs**
- [ ] **aws-cli** — Official CLI for all AWS APIs and resource management
- [ ] **gcloud** — Google Cloud official CLI for GCP resources
- [ ] **infracost** — Shows cloud cost estimates for Terraform changes before apply

**Terminal Recording & Sharing**
- [ ] **asciinema** — Records terminal sessions as text casts; playable in browser
- [ ] **vhs** — Generates terminal GIFs from a simple tape script file
- [ ] **tmate** — Instant terminal sharing over SSH

**Fonts & Appearance**
- [ ] **Nerd Fonts** — Patched fonts with thousands of icons for prompts and file managers
- [ ] **JetBrains Mono** — Coding font with tall x-height and ligature support
- [ ] **Cascadia Code** — Microsoft's monospace font with ligatures and Nerd Font variant

**Color Themes**
- [ ] **Catppuccin** — Soothing pastel theme ported to 300+ apps
- [ ] **base16** — Framework for building themes from a 16-color palette across all tools
- [ ] **pywal** — Generates a color scheme from wallpaper and applies it system-wide

**Shell Scripting Utilities**
- [ ] **shellcheck** — Static analyzer for bash/sh scripts
- [ ] **shfmt** — Opinionated formatter for shell scripts
- [ ] **bats** — TAP-compliant testing framework for bash scripts
- [ ] **gum** — Builds interactive shell scripts with prompts, filters, and spinners

**Dotfile & Config Productivity**
- [ ] **direnv** — Auto-loads/unloads env vars when entering/leaving a directory
- [ ] **navi** — Interactive cheatsheet browser with inline parameter substitution
- [ ] **thefuck** — Corrects your last console command when you type `fuck`

**File Sync & Backup**
- [ ] **restic** — Fast, encrypted snapshot backups to local or cloud repos
- [ ] **rclone** — Syncs files to/from S3, GCS, Dropbox, and 40+ cloud providers
- [ ] **syncthing** — Continuous P2P file sync between devices without a server

**Code Statistics & Benchmarking**
- [ ] **tokei** — Counts lines of code/comments/blanks per language; extremely fast
- [ ] **scc** — Fast code counter with cyclomatic complexity estimation
- [ ] **hyperfine** — CLI benchmarking tool; runs commands multiple times with stats
- [ ] **poop** — Compares two programs by time and memory with statistical output

**Prose & Documentation**
- [ ] **vale** — Prose linter enforcing style guide rules for technical writing
- [ ] **codespell** — Finds common spelling mistakes in source code and comments
- [ ] **glow** — Terminal Markdown renderer
- [ ] **pandoc** — Universal document converter (Markdown ↔ HTML ↔ DOCX ↔ LaTeX)
- [ ] **presenterm** — Terminal slideshow tool that renders Markdown presentations

**Note-Taking (CLI)**
- [ ] **nb** — CLI note-taking, bookmarking, and archiving with git sync + encryption
- [ ] **zk** — Zettelkasten-style plain-text notes with full-text search and linking
- [ ] **jrnl** — Simple CLI journal storing entries in plain text or encrypted files

**Process Management**
- [ ] **overmind** — Procfile process manager with per-process tmux windows
- [ ] **supervisord** — Client/server system for controlling and monitoring Unix processes

**Clipboard Tools**
- [ ] **xclip** — Read/write X11 clipboard from scripts (Linux)
- [ ] **wl-clipboard** — `wl-copy`/`wl-paste` for Wayland clipboard access
- [ ] **cliphist** — Stores clipboard history under Wayland; fuzzy-searchable

**Hex & Binary Inspection**
- [ ] **hexyl** — Colorful terminal hex viewer with human-readable ASCII panel
- [ ] **binwalk** — Firmware analysis tool; extracts and identifies embedded files in binaries

**System Tracing & Debugging**
- [ ] **strace** — Traces Linux system calls; essential for debugging mysterious failures
- [ ] **bpftrace** — High-level eBPF tracing language for live kernel + userspace events
