#!/bin/bash
# Claude Code status line: model | repo | branch | S/U/A | context %
# Needs only bash, jq and git. Reads Claude's JSON on stdin.
input=$(cat)
[ -n "$STATUSLINE_DUMP" ] && printf '%s' "$input" > "$STATUSLINE_DUMP"

eval "$(jq -r '@sh "model=\(.model.display_name // .model.id // "unknown") effort=\(.effort.level // "") cwd=\(.workspace.current_dir // .cwd // "") ctx=\(.context_window.used_percentage // "")"' <<<"$input")"

[ -n "$effort" ] && model="$model ($effort)"
out=$(printf '\033[01;35m%s\033[00m' "$model")

if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  repo=${cwd/#$HOME\/code\//}
  repo=${repo/#$HOME/\~}
  s=0 u=0 a=0 branch=
  while IFS= read -r line; do
    case $line in
      '# branch.head '*) branch=${line#\# branch.head } ;;
      '?'*) a=$((a+1)) ;;
      [12]\ *) x=${line:2:1} y=${line:3:1}
               [ "$x" != . ] && s=$((s+1)); [ "$y" != . ] && u=$((u+1)) ;;
    esac
  done < <(git -C "$cwd" --no-optional-locks status --porcelain=v2 --branch 2>/dev/null)
  out+=$(printf ' | \033[01;36m%s\033[00m | \033[01;32m%s\033[00m | S: \033[01;33m%s\033[00m | U: \033[01;33m%s\033[00m | A: \033[01;33m%s\033[00m' "$repo" "$branch" "$s" "$u" "$a")
elif [ -n "$cwd" ]; then
  out+=$(printf ' | \033[01;36m%s\033[00m' "${cwd/#$HOME/\~}")
fi

[ -n "$ctx" ] && out+=$(printf ' | \033[01;33m%.0f%%\033[00m' "$ctx")
printf '%s' "$out"
