# Easily get new aliases without having to open a new shell.
alias realias='zsd alias.d'

alias ls="ls --color=auto"

# I am lazy.
alias ..='cd ..'
alias ...='cd ../../'
alias -- -='cd -'
alias usage='du -cksh'

# Easy terminal reset.
alias cls='printf "\033c"'

# Scratchpads.
function todo {
    vi ${XDG_DATA_HOME}/notes/todo${1:+-$1}.md
}
function scratch {
    vi ${XDG_DATA_HOME}/notes/scratch${1:+-$1}.md
}

# Pretty dir stack
alias dirs="dirs -v"
alias d='dirs -v | head -10'

# List directory contents.
# -l - use long listing format
# -a - all files, include dotfiles
# -A - almost all, don't list '.' and '..'
# -h - with '-l', human readable size formats
alias l='ls -lah'
alias la='ls -lAh'
