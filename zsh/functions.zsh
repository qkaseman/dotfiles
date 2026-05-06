# zsh source directory -> zsd
#
# Source all `zsh` scripts from a given directory within $ZDOTDIR.
#
# @param 1 - directory to source from
function zsd() {
  [[ -n $1 ]] || return 1
  local conf
  for conf in ${ZDOTDIR}/$1/**/*.zsh(N); do
    source ${conf}
  done
}
