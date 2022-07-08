zstyle ':completion:*' cache-path ${ZSH_CACHE_HOME}/zcompcache
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' squeeze-slashes true

autoload -Uz compinit
compinit -d ${ZSH_CACHE_HOME}/zcompdump-$ZSH_VERSION
