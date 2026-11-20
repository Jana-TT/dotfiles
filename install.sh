#!/bin/sh
# Prerequisite: Homebrew (see README). Installs the Brewfile, then links every package.
set -eu
cd "$(dirname "$0")"
brew bundle --file brew/.config/homebrew/Brewfile
stow --no-folding -t "$HOME" brew claude ghostty helix starship tmux zsh
