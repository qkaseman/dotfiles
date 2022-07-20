# `fzf-tab-completion`, but these don't play well together.
# source ${ZDOTDIR}/plugin/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# bindkey '^I' fzf_completion

# This needs to be loaded after `compinit` but before any plugins that wrap
# widgets, like `zsh-autosuggestions` or `fast-syntax-highlighting`.
#
# It also needs to be called after any plugins that bind `^I`.
source ${ZDOTDIR}/plugin/fzf-tab/fzf-tab.plugin.zsh
