#!/usr/bin/env bash
#
# port.sh — Port selected pieces of this configs repo into another project with
# one command. Pick only what you need:
#
#   skills  — AI skill clusters from .ai/skills/  (+ behavioral rules.md)
#   config  — dotfiles (vim / tmux / bash)
#   tools   — a generated scripts/install-tools.sh for the CLI tools you choose
#
# With no category flag it ports all skills + rules (auto-detecting the target's
# AI tool: .claude / .cursor / .ai). Idempotent: re-running re-syncs and reports
# created / updated / unchanged. Writes only inside TARGET.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd -P)"
SKILLS_SRC="$REPO_DIR/.ai/skills"
RULES_SRC="$REPO_DIR/.ai/rules.md"

BEGIN_MARK="<!-- BEGIN configs:rules -->"
END_MARK="<!-- END configs:rules -->"
NOTE_MARK="<!-- Managed by configs/scripts/port.sh — content between these markers is regenerated on each port. -->"

TARGET=""
TOOL=""              # empty => auto-detect (skills/rules only)
DRY_RUN=0
QUIET=0
DO_LIST=0
DO_RULES=1
EXPLICIT_CATEGORY=0

SEL_SKILLS=""        # "all" or comma list of cluster names
SEL_CONFIG=""        # "all" or comma list of config names
SEL_TOOLS=""         # "all" or comma list of tool names

CREATED=0
UPDATED=0
UNCHANGED=0

# ---- catalogs --------------------------------------------------------------

CONFIG_ALL="vim tmux bash"
# config name -> repo-relative source paths (one per line)
config_paths() {
    case "$1" in
        vim)  printf '%s\n' ".vimrc" ;;
        tmux) printf '%s\n' ".tmux.conf" ".config/tmux/themes/tokyonight_moon.tmux" ".config/tmux/pane-color.sh" ;;
        bash) printf '%s\n' ".bashrc" ".bash_profile" ;;
        *)    return 1 ;;
    esac
}

TOOLS_ALL="fzf ripgrep fd bat jq tree htop tmux vim git curl"
# tool name -> "apt_pkg brew_pkg"
tool_pkgs() {
    case "$1" in
        fzf)        echo "fzf fzf" ;;
        ripgrep|rg) echo "ripgrep ripgrep" ;;
        fd|fd-find) echo "fd-find fd" ;;
        bat)        echo "bat bat" ;;
        jq)         echo "jq jq" ;;
        tree)       echo "tree tree" ;;
        htop)       echo "htop htop" ;;
        tmux)       echo "tmux tmux" ;;
        vim)        echo "vim vim" ;;
        git)        echo "git git" ;;
        curl)       echo "curl curl" ;;
        *)          return 1 ;;
    esac
}

usage() {
    cat <<'EOF'
Usage: port.sh [OPTIONS] TARGET_DIR

Port selected parts of this configs repo into TARGET_DIR. With no category flag,
ports all skills + rules.md, mapping to the AI tool detected in TARGET_DIR.

Categories (combine freely; value is `all` or a comma list):
  --skills VALUE   AI skill clusters into the target's skills dir (+ rules).
  --config VALUE   Dotfiles: vim, tmux, bash.
  --tools  VALUE   Generate scripts/install-tools.sh for: fzf, ripgrep, fd, bat,
                   jq, tree, htop, tmux, vim, git, curl.
  --no-rules       With --skills, skip rules.md / context-file wiring.

Other:
  --tool claude|ai|cursor   Force AI layout for skills/rules (skip auto-detect).
  --list                    List available skills / config / tools and exit.
  --dry-run                 Print what would change; write nothing.
  -q, --quiet               Print errors only.
  -h, --help                Show this help.

Detection for skills/rules (target contents -> layout):
  .claude/        -> .claude/skills/  + rules block in CLAUDE.md
  .cursor/        -> .ai/skills/      + .cursor/rules/configs.mdc
  AGENTS.md/.ai/  -> .ai/skills/      + rules block in AGENTS.md
  (none)          -> .ai/skills/      + rules block in AGENTS.md

Examples:
  port.sh ../proj                              # all skills + rules
  port.sh --skills debug,security ../proj      # two clusters only
  port.sh --config vim,tmux --tools fzf,fd,bat ../proj
  port.sh --list

Exit codes: 0 ok · 1 usage · 2 target missing · 3 source missing
EOF
}

err() { printf 'port: %s\n' "$1" >&2; }

log() {
    [ "$QUIET" -eq 1 ] && return 0
    printf '%s\n' "$1"
}

in_list() { case ",$2," in *",$1,"*) return 0 ;; esac; return 1; }

detect_tool() {
    local t="$1"
    if [ -d "$t/.claude" ]; then
        printf 'claude\n'
    elif [ -d "$t/.cursor" ]; then
        printf 'cursor\n'
    elif [ -f "$t/AGENTS.md" ] || [ -d "$t/.ai" ]; then
        printf 'ai\n'
    else
        printf 'none\n'
    fi
}

# sync_file SRC DST — copy SRC to DST unless byte-identical; tally and report.
sync_file() {
    local src="$1" dst="$2" status
    if [ ! -e "$dst" ]; then
        status=created
    elif cmp -s "$src" "$dst"; then
        status=unchanged
    else
        status=updated
    fi

    case "$status" in
        created)   CREATED=$((CREATED + 1)) ;;
        updated)   UPDATED=$((UPDATED + 1)) ;;
        unchanged) UNCHANGED=$((UNCHANGED + 1)) ;;
    esac

    if [ "$DRY_RUN" -eq 0 ] && [ "$status" != unchanged ]; then
        mkdir -p "$(dirname "$dst")"
        cp "$src" "$dst"
    fi

    [ "$QUIET" -eq 1 ] && return 0
    printf '  %-9s %s\n' "$status" "${dst#"$TARGET"/}"
}

copy_skills() {
    local dest="$1" want="$2" skill_dir name src
    for skill_dir in "$SKILLS_SRC"/*/; do
        name="$(basename "$skill_dir")"
        src="$skill_dir/SKILL.md"
        [ -f "$src" ] || continue
        if [ "$want" != all ] && ! in_list "$name" "$want"; then
            continue
        fi
        sync_file "$src" "$dest/$name/SKILL.md"
    done
}

# wire_rules CTX — write rules.md into a managed block inside CTX, replacing any
# prior block so re-runs do not accumulate copies.
wire_rules() {
    local ctx="$1" pre="$TMP_DIR/pre" new="$TMP_DIR/new"

    if [ -f "$ctx" ]; then
        awk -v b="$BEGIN_MARK" -v e="$END_MARK" '
            $0 == b { inblock = 1; next }
            inblock && $0 == e { inblock = 0; next }
            !inblock { print }
        ' "$ctx" \
        | awk 'NF { last = NR } { line[NR] = $0 } END { for (i = 1; i <= last; i++) print line[i] }' \
        > "$pre"
    else
        : > "$pre"
    fi

    {
        if [ -s "$pre" ]; then
            cat "$pre"
            printf '\n'
        fi
        printf '%s\n%s\n' "$BEGIN_MARK" "$NOTE_MARK"
        cat "$RULES_SRC"
        [ -z "$(tail -c1 "$RULES_SRC")" ] || printf '\n'
        printf '%s\n' "$END_MARK"
    } > "$new"

    sync_file "$new" "$ctx"
}

port_config() {
    local want="$1" names name p
    if [ "$want" = all ]; then names="$CONFIG_ALL"; else names="${want//,/ }"; fi
    for name in $names; do
        if ! config_paths "$name" >/dev/null 2>&1; then
            err "unknown config: $name (have: $CONFIG_ALL)"; continue
        fi
        while IFS= read -r p; do
            [ -f "$REPO_DIR/$p" ] || { err "missing source: $p"; continue; }
            sync_file "$REPO_DIR/$p" "$TARGET/$p"
        done < <(config_paths "$name")
    done
}

port_tools() {
    local want="$1" names name pair apt brew apt_list="" brew_list=""
    if [ "$want" = all ]; then names="$TOOLS_ALL"; else names="${want//,/ }"; fi
    for name in $names; do
        if ! pair="$(tool_pkgs "$name")"; then
            err "unknown tool: $name (have: $TOOLS_ALL)"; continue
        fi
        apt="${pair%% *}"; brew="${pair##* }"
        apt_list+="$apt "; brew_list+="$brew "
    done
    [ -n "$apt_list" ] || { err "no valid tools selected"; return; }

    local out="$TARGET/scripts/install-tools.sh" tmp="$TMP_DIR/install-tools.sh"
    cat > "$tmp" <<EOF
#!/usr/bin/env bash
# install-tools.sh — generated by configs/scripts/port.sh
# Installs the CLI tools selected when this project was ported. Idempotent.
set -euo pipefail

APT_PKGS=(${apt_list})
BREW_PKGS=(${brew_list})

if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y "\${APT_PKGS[@]}"
elif command -v brew >/dev/null 2>&1; then
    brew install "\${BREW_PKGS[@]}"
else
    echo "No apt or brew found. Install manually: \${APT_PKGS[*]}" >&2
    exit 1
fi

# Debian/Ubuntu ship bat as 'batcat' and fd as 'fdfind' — add ~/.local/bin shims.
mkdir -p "\$HOME/.local/bin"
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
    ln -sf "\$(command -v batcat)" "\$HOME/.local/bin/bat"
fi
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    ln -sf "\$(command -v fdfind)" "\$HOME/.local/bin/fd"
fi
echo "Tools installed: \${APT_PKGS[*]}"
EOF
    sync_file "$tmp" "$out"
    [ "$DRY_RUN" -eq 0 ] && [ -f "$out" ] && chmod +x "$out"
}

list_catalog() {
    printf 'skills:\n'
    local d
    for d in "$SKILLS_SRC"/*/; do [ -d "$d" ] && printf '  %s\n' "$(basename "$d")"; done
    printf 'config:\n  %s\n' "$CONFIG_ALL"
    printf 'tools:\n  %s\n' "$TOOLS_ALL"
}

# ---- parse args ------------------------------------------------------------
while [ "$#" -gt 0 ]; do
    case "$1" in
        --skills)   shift; SEL_SKILLS="${1:-all}"; EXPLICIT_CATEGORY=1 ;;
        --skills=*) SEL_SKILLS="${1#--skills=}"; EXPLICIT_CATEGORY=1 ;;
        --config)   shift; SEL_CONFIG="${1:-all}"; EXPLICIT_CATEGORY=1 ;;
        --config=*) SEL_CONFIG="${1#--config=}"; EXPLICIT_CATEGORY=1 ;;
        --tools)    shift; SEL_TOOLS="${1:-all}"; EXPLICIT_CATEGORY=1 ;;
        --tools=*)  SEL_TOOLS="${1#--tools=}"; EXPLICIT_CATEGORY=1 ;;
        --no-rules) DO_RULES=0 ;;
        --tool)     shift; TOOL="${1:-}" ;;
        --tool=*)   TOOL="${1#--tool=}" ;;
        --list)     DO_LIST=1 ;;
        --dry-run)  DRY_RUN=1 ;;
        -q|--quiet) QUIET=1 ;;
        -h|--help)  usage; exit 0 ;;
        -*)         err "unknown option: $1"; usage >&2; exit 1 ;;
        *)
            if [ -z "$TARGET" ]; then TARGET="$1"
            else err "unexpected argument: $1"; exit 1; fi
            ;;
    esac
    shift
done

# ---- --list short-circuit --------------------------------------------------
[ -d "$SKILLS_SRC" ] || { err "source skills not found at $SKILLS_SRC"; exit 3; }
if [ "$DO_LIST" -eq 1 ]; then list_catalog; exit 0; fi

# ---- validate --------------------------------------------------------------
[ -n "$TARGET" ] || { err "missing TARGET_DIR"; usage >&2; exit 1; }
[ -d "$TARGET" ] || { err "target directory not found: $TARGET"; exit 2; }

TARGET="$(cd "$TARGET" && pwd -P)"
if [ "$TARGET" = "$REPO_DIR" ]; then
    err "refusing to port into the configs repo itself"; exit 1
fi

# Default: nothing requested -> all skills + rules (back-compat).
if [ "$EXPLICIT_CATEGORY" -eq 0 ]; then SEL_SKILLS="all"; fi

if [ -n "$SEL_SKILLS" ]; then
    if [ -n "$TOOL" ]; then
        case "$TOOL" in
            claude|ai|cursor) ;;
            *) err "invalid --tool: $TOOL (expected claude|ai|cursor)"; exit 1 ;;
        esac
    else
        TOOL="$(detect_tool "$TARGET")"
    fi
    case "$TOOL" in
        claude)  SKILLS_DEST="$TARGET/.claude/skills"; CTX="$TARGET/CLAUDE.md";                 RULES_MODE=block ;;
        cursor)  SKILLS_DEST="$TARGET/.ai/skills";     CTX="$TARGET/.cursor/rules/configs.mdc"; RULES_MODE=file ;;
        ai|none) SKILLS_DEST="$TARGET/.ai/skills";     CTX="$TARGET/AGENTS.md";                 RULES_MODE=block ;;
    esac
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# ---- run -------------------------------------------------------------------
log "Porting configs -> $TARGET"
[ "$DRY_RUN" -eq 1 ] && log "  (dry run — no changes written)"

if [ -n "$SEL_SKILLS" ]; then
    display_tool="$TOOL"
    [ "$TOOL" = none ] && display_tool="none (default .ai/ layout)"
    log ""
    log "Skills ($SEL_SKILLS) -> ${SKILLS_DEST#"$TARGET"/}/  [tool: $display_tool]"
    copy_skills "$SKILLS_DEST" "$SEL_SKILLS"
    if [ "$DO_RULES" -eq 1 ]; then
        log "Rules  -> ${CTX#"$TARGET"/}"
        if [ "$RULES_MODE" = block ]; then wire_rules "$CTX"; else sync_file "$RULES_SRC" "$CTX"; fi
    fi
fi

if [ -n "$SEL_CONFIG" ]; then
    log ""
    log "Config ($SEL_CONFIG) ->"
    port_config "$SEL_CONFIG"
fi

if [ -n "$SEL_TOOLS" ]; then
    log ""
    log "Tools  ($SEL_TOOLS) -> scripts/install-tools.sh"
    port_tools "$SEL_TOOLS"
fi

log ""
log "Done: $CREATED created, $UPDATED updated, $UNCHANGED unchanged."
