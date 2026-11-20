# Portable fish config (replaces the home-manager generated one).
set -gx EDITOR hx

status is-interactive; or return

for d in /usr/local/go/bin /usr/local/odin $HOME/go/bin /usr/local/ols /usr/local/zig /usr/local/renderdoc/bin $HOME/.local/bin
    test -d $d; and fish_add_path -g $d
end

if test "$TERM" != dumb; and command -q starship
    starship init fish | source
end
