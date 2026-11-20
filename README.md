# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). One package per tool; each
package mirrors the layout under `$HOME`. No nix or home-manager required.

    sudo dnf install stow            # or your distro's package manager
    cd ~/dotfiles
    stow -n -v --no-folding <pkg>    # dry run
    stow    --no-folding <pkg>       # link

`--no-folding` links individual files so directories like `~/.claude` stay real
directories (they hold credentials and history that must never enter this repo).
Stow refuses to overwrite an existing real file: move it aside first.

| Package | Installs | Needs on PATH |
|---|---|---|
| `claude` | `~/.claude/statusline.sh` (set `statusLine` in settings.json to `bash ~/.claude/statusline.sh`) | bash, jq, git |
| `helix` | `~/.config/helix/{config.toml,languages.toml,ignore}` | hx, ruff, basedpyright |
| `tmux` | `~/.config/tmux/tmux.conf` | tmux, fish |
| `git` | `~/.gitconfig`, `~/.config/git/ignore` | git, gh (credential helper) |

## Not tracked on purpose
- `~/.claude/settings.json`: it held a plaintext `GITHUB_PERSONAL_ACCESS_TOKEN`. Keep the token out of
  the file (shell env var or `gh auth token`) before adding it here.
- `~/.claude/{.credentials.json,projects,sessions,history.jsonl,plugins}`, `~/.claude.json`,
  `~/.config/gh/hosts.yml`, `~/.ssh`, `~/.aws`.
- Fonts: install JetBrainsMono Nerd Font from https://www.nerdfonts.com (or your distro) on each machine.
- `git/.gitconfig` carries a personal name and email: keep this repo private.
