#!/usr/bin/env bash
# Assign a rotating background color to a tmux pane based on its numeric ID.
# Usage: pane-color.sh <pane_id>   (e.g. %3)

PANE_ID="${1:-%0}"

# Skip Eisenhower matrix windows — they manage their own pane colors
WINDOW_NAME=$(tmux display-message -p -t "$PANE_ID" '#{window_name}' 2>/dev/null)
[ "$WINDOW_NAME" = "Eisenhower" ] && exit 0

# Extract the numeric part of the pane ID (format: %N)
N=$(tmux display-message -p -t "$PANE_ID" '#{pane_id}' 2>/dev/null | tr -d '%')
N="${N:-0}"

# Dark palette with clearly distinct hues — compatible with TokyoNight Moon.
# All are dark enough to feel at home but different enough to tell apart.
# Uses standard 256-colour indices (colour0-colour255) per screen-256color/tmux-256color.
COLORS=(
    colour65    # muted sage green
    colour24    # teal-navy blue
    colour95    # dusty rose
    colour60    # blue-grey lavender
    colour66    # muted teal
    colour96    # muted mauve
)

COLOR="${COLORS[$((N % ${#COLORS[@]}))]}"

tmux select-pane -t "$PANE_ID" -P "bg=${COLOR}"
tmux set -p -t "$PANE_ID" @pane-label "C-a T: rename"
