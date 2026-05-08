[[ -d "${XDG_DATA_HOME:-$HOME/.local/share}/terminfo" ]] && export TERMINFO="${XDG_DATA_HOME:-$HOME/.local/share}/terminfo"

# Detect brew prefix directly (HOMEBREW_PREFIX isn't set until os/macos.d).
case "$(uname -m)" in
  arm64) _brew_ti="/opt/homebrew/share/terminfo" ;;
  *)     _brew_ti="/usr/local/share/terminfo" ;;
esac
export TERMINFO_DIRS="${XDG_DATA_HOME:-$HOME/.local/share}/terminfo:${_brew_ti}:/usr/share/terminfo"
unset _brew_ti
