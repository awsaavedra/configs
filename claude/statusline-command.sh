#!/usr/bin/env bash
# Claude Code status line – git branch | model | ctx usage

input=$(cat)

cwd=$(python3 -c "
import sys, json
d = json.loads(sys.argv[1])
print(d.get('workspace', {}).get('current_dir') or d.get('cwd', '') or '')
" "$input" 2>/dev/null)

model=$(python3 -c "
import sys, json
d = json.loads(sys.argv[1])
m = d.get('model', '')
print(m if isinstance(m, str) else m.get('display_name', '') if isinstance(m, dict) else '')
" "$input" 2>/dev/null)

used=$(python3 -c "
import sys, json
d = json.loads(sys.argv[1])
v = d.get('context_window', {}).get('used_percentage')
print(v if v is not None else '')
" "$input" 2>/dev/null)

branch=""
if [ -n "$cwd" ]; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
fi

parts=()
[ -n "$branch" ] && parts+=("($branch)")
[ -n "$model" ]  && parts+=("$model")
[ -n "$used" ]   && parts+=("$(printf 'ctx: %.0f%%' "$used")")

out=""
for part in "${parts[@]}"; do
  [ -z "$out" ] && out="$part" || out="$out | $part"
done

echo "$out"
