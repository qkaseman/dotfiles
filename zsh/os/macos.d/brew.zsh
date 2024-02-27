# Stop zsh and homebrew fighing over permissions.
export ZSH_DISABLE_COMPFIX="true"

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

fpath+=("$(brew --prefix)/share/zsh/site-functions")

path=('/usr/local/opt/curl/bin' $path)
