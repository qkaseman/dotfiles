# Stop zsh and homebrew fighing over permissions.
export ZSH_DISABLE_COMPFIX="true"

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

case "$(uname -m)" in
  arm64)
    BREW_PREFIX="/opt/homebrew"
    ;;
  *) # x86_64-*)
    BREW_PREFIX="/usr/local"
    ;;
esac

export HOMEBREW_PREFIX="${BREW_PREFIX:-/usr/local}"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";

export INFOPATH="${HOMEBREW_PREFIX}/usr/local/share/info:${INFOPATH:-}";
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")
path+=("${HOMEBREW_PREFIX}/bin" '/usr/local/opt/curl/bin')
