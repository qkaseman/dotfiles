# This needs to be loaded after `compinit` but before any plugins that wrap
# widgets, like `zsh-autosuggestions` or `fast-syntax-highlighting`.
#
# It also needs to be called after any plugins that bind `^I`.
source ${ZDOTDIR}/plugin/fzf-tab/fzf-tab.plugin.zsh
