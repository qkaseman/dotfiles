# zoxide: smarter cd (replaces rupa/z).
# Install: brew install zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
