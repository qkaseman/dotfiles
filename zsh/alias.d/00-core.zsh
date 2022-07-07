# Easily get new aliases without having to open a new shell.
alias realias='zsd alias.d'

alias ls="ls --color=auto"

# I am lazy.
alias npr='npm run'
alias ..='cd ..'
alias ...='cd ../../'
alias -- -='cd -'
alias l='ls -lah'
alias usage='du -cksh'

# Easy terminal reset.
alias cls='printf "\033c"'

# Scratchpads.
alias todo="vi ${XDG_DATA_HOME}/todo"
alias scratch="vi ${XDG_DATA_HOME}/scratch"
