# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). One package per tool; each
package mirrors the layout under `$HOME`.

    cd ~/dotfiles
    stow -n -v --no-folding <pkg>     # dry run
    stow    --no-folding <pkg>        # link

`--no-folding` links individual files so directories like `~/.claude` stay real
directories (they hold credentials and history that must never enter this repo).

| Package | Contents | Status |
|---|---|---|
| `claude` | `~/.claude/statusline.sh` (jq + git status line) | stowed |
| `helix`  | `~/.config/helix/{config.toml,languages.toml,ignore}` | stowed |
| `tmux`   | `~/.config/tmux/tmux.conf` | stowed |

## Not tracked on purpose
- `~/.claude/settings.json` contains `env.GITHUB_PERSONAL_ACCESS_TOKEN`. Move the token out
  (e.g. a shell env var or `gh auth token`), then add a `settings.json` here.
- `~/.claude/{.credentials.json,projects,sessions,history.jsonl,plugins}`, `~/.claude.json`,
  `~/.config/gh/hosts.yml`, `~/.ssh`, `~/.aws`.

helix and tmux were cut over from home-manager on 2026-11-20 (nix is being decommissioned).
