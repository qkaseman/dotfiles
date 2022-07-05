alias ls='ls -G'

# Annoyingly, MacOS has defaults for some environment variables in
# `/etc/zshrc`, which is sourced after `$ZDOTDIR/zshenv`, which means the
# definitions in `/etc/zshrc` take precedence.
#
# So we have to define/source them here again :( 
source ${ZDOTDIR}/env.d/**/*history.zsh

# Stop zsh and homebrew fighing over permissions.
export ZSH_DISABLE_COMPFIX="true"
