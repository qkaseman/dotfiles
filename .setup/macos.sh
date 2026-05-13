#!/usr/bin/env bash
set -euxo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
BIN_DIR="${XDG_BIN_HOME:-${HOME}/.local/bin}"
KIRO_STEERING_DIR="${HOME}/.kiro/steering"

# ─── Homebrew ────────────────────────────────────────────────────────────────

case "$(uname -m)" in
  arm64)  BREW_PREFIX="/opt/homebrew" ;;
  *)      BREW_PREFIX="/usr/local" ;;
esac

if [[ ! -x "$(command -v brew)" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH="${BREW_PREFIX}/bin:${PATH}"
fi

# ─── Taps ────────────────────────────────────────────────────────────────────

brew tap koekeishiya/formulae
brew tap cormacrelf/tap
brew tap FelixKratz/formulae

# ─── Packages ────────────────────────────────────────────────────────────────

TOOLS=(
  git
  tree
  fzf
  ripgrep
  alacritty
  neovim
  wget
  jq
  zoxide
  prettier
  markdownlint-cli
  lazygit
  bottom
  gdu
  sketchybar
  borders
  # Theme switching
  dark-notify
)

# Casks (GUI apps / non-formula packages).
CASKS=(nikitabobko/tap/aerospace itsycal stats)
for c in "${CASKS[@]}"; do
  brew list --cask "${c##*/}" &>/dev/null || brew install --cask "${c}"
done

# Formula install check uses brew list (command names differ from formula names).
INSTALL=()
for p in "${TOOLS[@]}"; do
  brew list --formula "${p}" &>/dev/null || INSTALL+=("${p}")
done

if (( ${#INSTALL[@]} > 0 )); then
  brew install "${INSTALL[@]}"
fi

# ─── mise (version management) ──────────────────────────────────────────────

if [[ ! -x "$(command -v mise)" ]]; then
  mkdir -p "${BIN_DIR}"
  curl https://mise.run | MISE_INSTALL_PATH="${BIN_DIR}/mise" sh
  eval "$("${BIN_DIR}/mise" activate bash)"
fi

# Node is needed for Neovim plugins.
command -v node &>/dev/null || mise use -g node@22

# ─── Clone dotfiles ─────────────────────────────────────────────────────────

if [[ ! -d "${CONFIG_DIR}/.git" ]]; then
  git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git "${CONFIG_DIR}"
fi

# ─── Symlinks ────────────────────────────────────────────────────────────────

# Neovim as vi.
if [[ ! -e "${BREW_PREFIX}/bin/vi" ]]; then
  nvim_path="$(command -v nvim)"
  if [[ -n "${nvim_path}" ]]; then
    sudo ln -s "${nvim_path}" "${BREW_PREFIX}/bin/vi"
  else
    echo "WARNING: nvim not found, skipping vi symlink" >&2
  fi
fi

# Python convenience alias (macOS ships python3 but not python).
if [[ ! -e "${BREW_PREFIX}/bin/python" ]]; then
  sudo ln -s /usr/bin/python3 "${BREW_PREFIX}/bin/python"
fi

# Alacritty color symlink (dark-notify swaps this).
ln -sf light.toml "${CONFIG_DIR}/alacritty/color/color.toml"

# Shared steering docs into kiro global steering.
mkdir -p "${KIRO_STEERING_DIR}"
ln -sfn "${CONFIG_DIR}/doc/genai/steering/shared" "${KIRO_STEERING_DIR}/public"

# ─── dark-notify launchd service ─────────────────────────────────────────────

dark_notify_path="$(command -v dark-notify)"
if [[ -z "${dark_notify_path}" ]]; then
  echo "WARNING: dark-notify not found, skipping launchd service" >&2
else
  mkdir -p ~/Library/LaunchAgents
  cat > ~/Library/LaunchAgents/com.user.dark-notify.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.dark-notify</string>
    <key>ProgramArguments</key>
    <array>
        <string>${dark_notify_path}</string>
        <string>-c</string>
        <string>${CONFIG_DIR}/bin/theme-swap</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF
  launchctl unload ~/Library/LaunchAgents/com.user.dark-notify.plist 2>/dev/null || true
  launchctl load ~/Library/LaunchAgents/com.user.dark-notify.plist
fi

# ─── launchd env vars for GUI-launched processes ────────────────────────────

# Sets XDG + tool-specific env vars in the launchd user session so GUI apps
# (Kiro, IDEs, etc.) inherit them when they spawn child processes like npm
# or gradle. Without this, those tools fall back to polluting $HOME.

mkdir -p ~/Library/LaunchAgents
cat > ~/Library/LaunchAgents/com.user.env.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.env</string>
    <key>ProgramArguments</key>
    <array>
        <string>${CONFIG_DIR}/bin/launchd-env</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
launchctl unload ~/Library/LaunchAgents/com.user.env.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.user.env.plist

# ─── Window management services ─────────────────────────────────────────────

echo "Starting AeroSpace — grant accessibility permissions when prompted."
open -a AeroSpace
read -rp "Press any key once permissions are granted..." -n 1
echo

# SketchyBar is launched by AeroSpace via after-startup-command.
brew services start sketchybar

# ─── macOS shell config ─────────────────────────────────────────────────────

# Disable macOS session restoration.
if ! grep -q "SHELL_SESSIONS_DISABLE" /etc/zprofile 2>/dev/null; then
  echo "export SHELL_SESSIONS_DISABLE=1" | sudo tee -a /etc/zprofile > /dev/null
fi

# Set up XDG-compliant zshenv.
if [[ -f /etc/zshenv ]]; then
  echo "WARNING: overwriting /etc/zshenv (backup at /tmp/zshenv.bak)" >&2
  sudo cp /etc/zshenv /tmp/zshenv.bak
fi
sudo cp "${CONFIG_DIR}/resources/zsh/zshenv.macos" /etc/zshenv

# ─── Manual steps ────────────────────────────────────────────────────────────

cat << 'MANUAL'

╔══════════════════════════════════════════════════════════════════════════════╗
║ Manual steps required:                                                      ║
║                                                                             ║
║ 1. Hide the macOS menu bar (SketchyBar replaces it):                        ║
║    System Settings → Control Center →                                       ║
║    "Automatically hide and show the menu bar" → "Always"                    ║
║                                                                             ║
║ 2. Disable macOS Spaces animations (AeroSpace uses virtual workspaces):     ║
║    System Settings → Accessibility → Display →                              ║
║    "Reduce motion" → ON                                                     ║
║                                                                             ║
║ 3. Consolidate to a single macOS Space:                                     ║
║    Move all windows to one desktop in Mission Control.                      ║
║    AeroSpace manages workspaces — macOS Spaces will conflict.               ║
║                                                                             ║
║ 4. Install fonts:                                                           ║
║    Double-click each .ttf in resources/font/ and click "Install".           ║
║                                                                             ║
║ 5. Disable Finder search shortcut (alt-cmd-space conflicts with AeroSpace): ║
║    System Settings → Keyboard → Keyboard Shortcuts → Spotlight →            ║
║    uncheck "Show Finder search window"                                      ║
║                                                                             ║
╚══════════════════════════════════════════════════════════════════════════════╝
MANUAL
