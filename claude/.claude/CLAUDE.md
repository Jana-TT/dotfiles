# Machine context

Apple Silicon MacBook, macOS. One person, one machine: everything is set up for speed and minimal moving parts. Only add a feature or tool when it clearly helps.

## Languages
- Go is the default for everything, including throwaway scripts and one-off tools. Not Python, not JS/TS.
- Shell is only for short, simple scripts. As soon as one needs an array, a loop, or a branch, rewrite it in Go.
- Go comes from brew. Use `go run` for scripts; no version managers.

## Tooling
- Install everything with Homebrew, never from curl-pipe installers or other package managers. After installing or removing a brew package, refresh the Brewfile: `brew bundle dump --global --force`, then commit the change in the dotfiles repo (the global Brewfile is a symlink into it).
- Shell: zsh (kept as the default), with Starship, fzf, eza, bat, fd and ripgrep. Prefer `rg` and `fd` over grep and find.
- Terminal: Ghostty, in tmux. Editor: Helix (`hx`).
- Containers: Colima + docker CLI (no Docker Desktop). Postgres 17 from brew. AWS CLI and gh are installed.
- Fonts: JetBrains Mono Nerd Font with ligatures disabled (performance).

## Layout
- All repos live in `~/code/`, cloned with `gh repo clone` over HTTPS. GitHub account: Jana-TT.
- Dotfiles: `~/code/dotfiles`, managed with GNU Stow (`stow --no-folding -t ~ <package>`). Edit configs in that repo, not by replacing symlinks in `~`. Commit changes there so they are kept. `install.sh` there reinstalls the Brewfile and re-links every package.
- Never put secrets, tokens or credentials in dotfiles (`~/.claude/settings.json`, `~/.config/gh`, `~/.ssh` and `~/.aws` stay untracked).

## Working with this shell
- `CLAUDECODE=1` is set in Claude's shell, and the zsh config skips aliases, prompt and plugins when it is set. So `ls`, `cat` etc. are the plain macOS tools in Claude's shell, even though the user's terminal aliases `ls` to eza.
- Zsh config is split into modules under `~/.config/zsh/`. Keep startup fast: measure with `time zsh -i -c exit` after changes (about 40ms now).
