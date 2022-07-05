# All bells must die.
unsetopt beep nomatch notify

# Expansion & Globbing
unsetopt nomatch            # If a pattern has no matches, pass glob along.
setopt extendedglob

setopt autocd               # cd into valid dir names automatically.
setopt cdablevars           # cd $var, if $var is a valid dir, cd into it.
setopt autonamedirs
setopt autopushd            # cd pushes direcotry onto dir stack.
setopt pushdignoredups      # Don't push multiple copies of dir onto stack.
setopt pushdminus           # Use `-` to traverse dir stack.
setopt pushdsilent          # Don't print stack after push/pop.
setopt pushdtohome          # pushd w/no args acts like cd w/no args.

setopt extendedhistory      # Add timestamp and duration.
setopt histexpiredupsfirst  # Remove duplicates first.
setopt histignoredups       # But don't even store if dupe of previous cmd.
setopt histreduceblanks     # Remove superflous blanks from commands.
setopt histignorespace      # Don't save commands starting with a space.
setopt histverify           # When user enters a line with history.
                            # expansion, put into editing buffer rather
                            # than execute.
setopt incappendhistory     # Append to global history immediately.
# setopt appendhistory      # Append to global history on exit.

setopt longlistjobs

[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
