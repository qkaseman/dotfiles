export ZSH_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
export ZSH_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
export ZSH_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export ZSH_LOCAL_HOME="${XDG_CONFIG_LOCAL_HOME:-${HOME}/.local/config}/zsh"
path+=("${XDG_BIN_HOME:-${HOME}/.local/bin}")
path+=("${XDG_CONFIG_HOME:-$HOME/.config}/bin")
