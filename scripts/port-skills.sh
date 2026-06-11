#!/usr/bin/env bash
#
# port-skills.sh — Copy this repo's AI-instruction layer (skills + rules) into
# another project, mapping to whichever AI tool that project uses.
#
# Detects .claude/ vs .cursor/ vs .ai/ in the target and places the skills and
# rules where that tool expects them. Idempotent: re-running re-syncs from
# source and reports created / updated / unchanged. Writes only inside TARGET.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd -P)"
SKILLS_SRC="$REPO_DIR/.ai/skills"
RULES_SRC="$REPO_DIR/.ai/rules.md"

BEGIN_MARK="<!-- BEGIN configs:rules -->"
END_MARK="<!-- END configs:rules -->"
NOTE_MARK="<!-- Managed by configs/scripts/port-skills.sh — content between these markers is regenerated on each port. -->"

TARGET=""
TOOL=""          # empty => auto-detect
DRY_RUN=0
QUIET=0
SKILLS_ONLY=0

CREATED=0
UPDATED=0
UNCHANGED=0

usage() {
    cat <<'EOF'
Usage: port-skills.sh [OPTIONS] TARGET_DIR

Copy the .ai/ skill clusters and rules.md into TARGET_DIR,
mapping to the AI tool detected there.

Options:
  --tool claude|ai|cursor   Force destination layout (skip auto-detect).
  --skills-only             Copy skills only; skip rules / context-file wiring.
  --dry-run                 Print what would change; write nothing.
  -q, --quiet               Print errors only.
  -h, --help                Show this help.

Detection (target contents -> layout):
  .claude/                  -> .claude/skills/  + rules block in CLAUDE.md
  .cursor/                  -> .ai/skills/      + .cursor/rules/configs.mdc
  AGENTS.md or .ai/         -> .ai/skills/      + rules block in AGENTS.md
  (none of the above)       -> .ai/skills/      + rules block in AGENTS.md

Exit codes:
  0  success
  1  usage error
  2  target directory not found
  3  source skills not found
EOF
}

err() { printf 'port-skills: %s\n' "$1" >&2; }

log() {
    [ "$QUIET" -eq 1 ] && return 0
    printf '%s\n' "$1"
}

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
    local dest="$1" skill_dir name src
    for skill_dir in "$SKILLS_SRC"/*/; do
        name="$(basename "$skill_dir")"
        src="$skill_dir/SKILL.md"
        [ -f "$src" ] || continue
        sync_file "$src" "$dest/$name/SKILL.md"
    done
}

# wire_rules CTX — write rules.md into a managed block inside CTX, replacing any
# prior block so re-runs do not accumulate copies.
wire_rules() {
    local ctx="$1" pre="$TMP_DIR/pre" new="$TMP_DIR/new"

    if [ -f "$ctx" ]; then
        # Drop any existing managed block, then strip trailing blank lines.
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

# ---- parse args ----
while [ "$#" -gt 0 ]; do
    case "$1" in
        --tool)
            shift
            [ "$#" -gt 0 ] || { err "--tool needs a value"; exit 1; }
            TOOL="$1"
            ;;
        --tool=*)      TOOL="${1#--tool=}" ;;
        --skills-only) SKILLS_ONLY=1 ;;
        --dry-run)     DRY_RUN=1 ;;
        -q|--quiet)    QUIET=1 ;;
        -h|--help)     usage; exit 0 ;;
        -*)            err "unknown option: $1"; usage >&2; exit 1 ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            else
                err "unexpected argument: $1"; exit 1
            fi
            ;;
    esac
    shift
done

# ---- validate ----
[ -n "$TARGET" ]      || { err "missing TARGET_DIR"; usage >&2; exit 1; }
[ -d "$SKILLS_SRC" ]  || { err "source skills not found at $SKILLS_SRC"; exit 3; }
[ -d "$TARGET" ]      || { err "target directory not found: $TARGET"; exit 2; }

TARGET="$(cd "$TARGET" && pwd -P)"
if [ "$TARGET" = "$REPO_DIR" ]; then
    err "refusing to port into the configs repo itself"
    exit 1
fi

if [ -n "$TOOL" ]; then
    case "$TOOL" in
        claude|ai|cursor) ;;
        *) err "invalid --tool: $TOOL (expected claude|ai|cursor)"; exit 1 ;;
    esac
else
    TOOL="$(detect_tool "$TARGET")"
fi

case "$TOOL" in
    claude)  SKILLS_DEST="$TARGET/.claude/skills"; CTX="$TARGET/CLAUDE.md";              RULES_MODE=block ;;
    cursor)  SKILLS_DEST="$TARGET/.ai/skills";     CTX="$TARGET/.cursor/rules/configs.mdc"; RULES_MODE=file ;;
    ai|none) SKILLS_DEST="$TARGET/.ai/skills";     CTX="$TARGET/AGENTS.md";              RULES_MODE=block ;;
esac

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# ---- run ----
display_tool="$TOOL"
[ "$TOOL" = none ] && display_tool="none (default .ai/ layout)"
log "Porting .ai -> $TARGET"
log "  tool: $display_tool"
[ "$DRY_RUN" -eq 1 ] && log "  (dry run — no changes written)"

log ""
log "Skills -> ${SKILLS_DEST#"$TARGET"/}/"
copy_skills "$SKILLS_DEST"

if [ "$SKILLS_ONLY" -eq 0 ]; then
    log ""
    log "Rules  -> ${CTX#"$TARGET"/}"
    if [ "$RULES_MODE" = block ]; then
        wire_rules "$CTX"
    else
        sync_file "$RULES_SRC" "$CTX"
    fi
fi

log ""
log "Done: $CREATED created, $UPDATED updated, $UNCHANGED unchanged."
