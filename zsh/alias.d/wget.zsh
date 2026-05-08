# `wget` doesn't have a config way to handle this.
alias wget='wget --hsts-file=${XDG_STATE_HOME}/wget/hsts'
