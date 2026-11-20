# Claude Code's shell: skip everything interactive
[[ -n $CLAUDECODE ]] && return

for f in history completion aliases fzf plugins prompt; do
  source $ZDOTDIR/$f.zsh
done
