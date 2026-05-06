# Setup fzf
# ---------
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Auto-completion & key bindings
# ------------------------------
(( $+commands[fzf] )) && source <(fzf --zsh)

# FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
