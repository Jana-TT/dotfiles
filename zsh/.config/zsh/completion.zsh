fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

ZSH_COMPDUMP=$XDG_CACHE_HOME/zsh/.zcompdump
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}

# full compinit security scan once a day, cached dump otherwise
autoload -Uz compinit
setopt local_options extended_glob
if [[ -n $ZSH_COMPDUMP(#qN.mh+24) ]]; then
  compinit -d $ZSH_COMPDUMP
else
  compinit -C -d $ZSH_COMPDUMP
fi

zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
