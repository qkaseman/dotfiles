#!/usr/bin/env bash

CONFIG_DIR=${XDG_CONFIG_HOME:-${HOME}/.config}

# Install Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Unfortunately install mise for environment management.
curl https://mise.run | MISE_INSTALL_PATH="${XDG_BIN_HOME:-${HOME}/.local/bin}/mise" sh

# Install default version of Node, needed for Neovim plugins.
mise use -g node@20

# Install tools.
brew install \
    git \
    fzf \
    alacritty \
    neovim \
    ripgrep \
    skhd \
    yabai

# Clone common config.
git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git ${CONFIG_DIR}

# Handle MacOS weirdness.
sudo echo "export SHELL_SESSIONS_DISABLE=1" >> /etc/zprofile
sudo cp "${CONFIG_DIR}/resources/zsh/zshenv.macos" /etc/zshenv
