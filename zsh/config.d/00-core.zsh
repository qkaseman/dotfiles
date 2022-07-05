# All bells must die.
unsetopt beep nomatch notify

# If a pattern has no matches, pass glob to program.
unsetopt nomatch

setopt autocd
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent

setopt extended_history         # Add timestamp and duration.
setopt hist_expire_dups_first   # Remove duplicates first.
setopt hist_ignore_dups         # But don't even store if dupe of previous command.
setopt hist_reduce_blanks       # Remove superflous blanks from commands.
setopt hist_ignore_space        # Don't save commands starting with a space.
setopt hist_verify              # When user enters a line with history.
                                # expansion, put into editing buffer rather
                                # than execute.
setopt inc_append_history       # Append to global history immediately.
# setopt append_history         # Append to global history on exit.

setopt long_list_jobs
