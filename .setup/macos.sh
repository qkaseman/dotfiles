#!/usr/bin/env bash

CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}

# git is special as MacOS provides a shim to trigger installation if you
# haven't but that makes it harder to detect if it is installed.
INSTALL="git"
TOOLS=(
  "tree"
  "fzf"
  "alacritty"
  "ripgrep"
  "neovim"
  "skhd"
  "yabai"
  "stats"
)

# Install Homebrew.
#
# Note: Install Xcode Command Line Tools
if [[ ! -x "$(command -v brew)" ]]; do
    export HOMEBREW_NO_ANALYTICS=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    case "$(uname -m)" in
      arm64)
        BREW_PREFIX="/opt/homebrew"
        ;;
      *) # x86_64-*)
        BREW_PREFIX="/usr/local"
        ;;
    esac
    export PATH="${BREW_PREFIX}/bin:${PATH}";
done

# Unfortunately install mise for environment management.
[[ -x "$(command -v mise)" ]] || \
    curl https://mise.run | MISE_INSTALL_PATH="${XDG_BIN_HOME:-${HOME}/.local/bin}/mise" sh && ${MISE_INSTALL_PATH} activate zsh

# Install default version of Node, needed for Neovim plugins.
[[ -x "$(command -v node)" ]] || mise use -g node@20

# Install tools.
for p in ${TOOLS[@]}; do
    [[ -x "$(command -v ${p})" ]] || INSTALL="${INSTALL} ${p}"
done
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install cormacrelf/tap/dark-notify
brew tap homebrew/command-not-found
brew install ${INSTALL}

# TODO: symlink or alias?
sudo ln -s "$(command -v nvim)" /usr/local/bin/vi

# FIXME: Make smarter
skhd --start-service
read -n 1 -p Once you have give a11y permissions, hit any key to continue.
skhd --start-service

yabai --start-service
read -n 1 -p Once you have give a11y permissions, hit any key to continue.
yabai --start-service

# Clone common config.
git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git ${CONFIG_DIR}

# Create Alacritty color symlink (dark-notify swaps this).
ln -sf light.toml "${CONFIG_DIR}/alacritty/color/color.toml"

# Install dark-notify launchd service for automatic light/dark switching.
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
        <string>$(command -v dark-notify)</string>
        <string>-c</string>
        <string>${CONFIG_DIR}/bin/alacritty-theme-swap</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF
launchctl load ~/Library/LaunchAgents/com.user.dark-notify.plist

# Handle MacOS weirdness.

# MacOS's default shell config is weird.
echo "export SHELL_SESSIONS_DISABLE=1" | sudo tee -a /etc/zprofile > /dev/null
sudo cp "${CONFIG_DIR}/resources/zsh/zshenv.macos" /etc/zshenv

# The "helpers" are annoying.
sudo ln -s /Library/Developer/CommandLineTools/usr/bin/python3 /Library/Developer/CommandLineTools/usr/bin/python
sudo ln -s /usr/bin/python3 /usr/local/bin/python
