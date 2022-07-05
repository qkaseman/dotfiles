# Easily get new aliases without having to open a new shell.
alias realias='zsd alias.d'

# I am lazy.
alias npr='npm run'
alias ..='cd ..'
alias ...='cd ../../'
alias -- -='cd -'
alias l='ls -lah'
alias usage='du -cksh'

# Always smart case searching.
alias rg='rg -s'

# Easy terminal reset.
alias cls='printf "\033c"'

# Scratchpads.
alias todo="vi ${XDG_DATA_HOME}/todo"
alias scratch="vi ${XDG_DATA_HOME}/scratch"