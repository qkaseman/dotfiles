# Setup fzf
# ---------
PATH="${PATH:+${PATH}:}${FZF_HOME}/bin"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Auto-completion
# ---------------
[[ $- == *i* ]] && [ -f ${FZF_HOME}/shell/completion.zsh ] && source ${FZF_HOME}/shell/completion.zsh 2> /dev/null

# Key bindings
# ------------
[ -f ${FZF_HOME}/shell/key-bindings.zsh ] && source ${FZF_HOME}/shell/key-bindings.zsh

# FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
