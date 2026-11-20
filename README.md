# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). One package per tool; each
package mirrors the layout under `$HOME`. No nix or home-manager required.

## New macOS machine

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # follow brew's "Next steps" to put it on PATH, then:
    brew install gh && gh auth login
    gh repo clone Jana-TT/dotfiles ~/code/dotfiles
    ~/code/dotfiles/install.sh

`install.sh` installs everything in `brew/.config/homebrew/Brewfile`, then stows every package.
After installing or removing a brew package, refresh the Brewfile and commit it:

    brew bundle dump --global --force    # writes through the symlink into this repo

## Stow

    cd ~/code/dotfiles
    stow -n -v --no-folding -t ~ <pkg>    # dry run
    stow    --no-folding -t ~ <pkg>       # link

`--no-folding` links individual files so directories like `~/.claude` stay real
directories (they hold credentials and history that must never enter this repo).
Stow refuses to overwrite an existing real file: move it aside first.

| Package | Installs | Needs on PATH |
|---|---|---|
| `brew` | `~/.config/homebrew/Brewfile` (global Brewfile) | brew |
| `claude` | `~/.claude/CLAUDE.md`, `~/.claude/statusline.sh` (wired up by the seeded settings.json) | bash, jq, git |
| `ghostty` | `~/.config/ghostty/config.ghostty` | ghostty, JetBrainsMono Nerd Font |
| `helix` | `~/.config/helix/{config.toml,languages.toml,ignore}` | hx, ruff, basedpyright |
| `starship` | `~/.config/starship.toml` | starship |
| `tmux` | `~/.config/tmux/tmux.conf` | tmux |
| `zsh` | `~/.zshenv` (sets `ZDOTDIR`), `~/.config/zsh/*` | zsh plugins and tools from the Brewfile |

## Not tracked on purpose
- `~/.claude/settings.json` is seeded, not stowed: Claude rewrites it itself, which would break a symlink.
  `install.sh` copies `seed/claude-settings.json` there once and never overwrites it. Edits made in `~` do not
  flow back; update the seed by hand. Never put tokens in either file (the old copy held a plaintext
  `GITHUB_PERSONAL_ACCESS_TOKEN`; use a shell env var or `gh auth token`).
- `~/.claude/{.credentials.json,projects,sessions,history.jsonl,plugins}`, `~/.claude.json`,
  `~/.config/gh/hosts.yml`, `~/.ssh`, `~/.aws`.
- Zsh history (`~/.local/state/zsh`) and the completion cache (`~/.cache/zsh`).
