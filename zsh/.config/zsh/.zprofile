# brew shellenv, hardcoded (Apple Silicon)
export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CELLAR=/opt/homebrew/Cellar
export HOMEBREW_REPOSITORY=/opt/homebrew
typeset -U path
path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
