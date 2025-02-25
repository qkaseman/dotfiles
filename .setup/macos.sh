#!/usr/bin/env bash

CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}

# Install Homebrew.
[[ -x "$(command -v brew)" ]] || \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Unfortunately install mise for environment management.
[[ -x "$(command -v mise)" ]] || \
    curl https://mise.run | MISE_INSTALL_PATH="${XDG_BIN_HOME:-${HOME}/.local/bin}/mise" sh

# Install default version of Node, needed for Neovim plugins.
[[ -x "$(command -v node)" ]] || mise use -g node@20

# Install tools.

# git is special as MacOS provides a shim to trigger installation if you
# haven't but that makes it harder to detect if it is installed.
INSTALL="git"
PROGS=(
  "fzf"
  "alacritty"
  "ripgrep"
  "skhd"
  "yabai"
)
for p in ${PROGS[@]}; do
    [[ -x "$(command -v ${p})" ]] || INSTALL="${INSTALL} ${p}"
done

brew install ${INSTALL}

# Clone common config.
git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git ${CONFIG_DIR}

# Handle MacOS weirdness.
sudo echo "export SHELL_SESSIONS_DISABLE=1" >> /etc/zprofile
sudo cp "${CONFIG_DIR}/resources/zsh/zshenv.macos" /etc/zshenv
