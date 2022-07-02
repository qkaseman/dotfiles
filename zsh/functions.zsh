# zsh source directory -> zsd
#
# Source all `zsh` scripts from a given directory within $ZDOTDIR.
#
# @param 1 - directory to source from
function zsd() {
  foreach conf (${ZDOTDIR}/$1/**/*.zsh)
    source ${conf}
  end
  unset conf
}
