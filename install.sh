#!/bin/sh
# Prerequisite: Homebrew (see README). Installs the Brewfile, seeds settings, then links every package.
set -eu
cd "$(dirname "$0")"
brew bundle --file brew/.config/homebrew/Brewfile
# Claude rewrites settings.json itself, so it is copied once, never linked
mkdir -p "$HOME/.claude"
cp -n seed/claude-settings.json "$HOME/.claude/settings.json" || true
stow --no-folding -t "$HOME" brew claude ghostty helix starship tmux zsh
