# Command Line Application Configurations

XDG-compliant (as much as possible) configuration files.

## Installation

1. Clone into `.config` (make sure to backup anything that is already there!)
1. Setup root zshenv from `scripts`
1. Install fonts, or override the config to use different fonts
1. Profit?

## Local Configuration

Local configurations go into `$XDG_CONFIG_LOCAL_HOME`, which is set by default
in the scripts provided to `${HOME}/.local/config`. This allows for computer or
work-specific files to be self-contained and even a repo set up like this one.

Some configuration files don't allow for shell variables or variable expansion,
so those will directly reference the default location. These configurations are
generally the last thing loaded into the particular configuration and will
therefore override the default configurations in this repo.

## Scripts

### `etc-zsh-zshenv`

This sets up `zsh` to have XDG variables defined and make `zsh` itself follow the spec.

The exports in this script should be added to `/etc/zsh/zshenv`. Eventually
this might get automated, but manual is fine for now.

# Applications

## Local Configuration

Local configurations go into `$XDG_CONFIG_LOCAL_HOME`, which is set by default
in the scripts provided to `${HOME}/.local/config`. This allows for computer or
work-specific files to be self-contained and even a repo set up like this one.

Some configuration files don't allow for shell variables or variable expansion,
so those will directly reference the default location.

## Alacritty

### Window Decoration

For non-tiling window managers (or if you want to be able to drag with the
mouse), add the following to the local configuration:

```
window:
  decorations: full
```

### Fonts

Install fonts into `~/.local/share/fonts/`.

## `asdf`

[`asdf`](https://asdf-vm.com/) is a terribly named runtime manager.

### Installation

#### Core

Follow their [installation
instructions](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf).

#### Plugins

##### NodeJS

```
> asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
> asdf install nodejs lts-gallium
```

## Git

The core git configurations are within the `git` directory here. However, as
the name and email might change (for example, when using work email) so that
information should be added to `~/.gitconfig` as:

```
[user]
    email = <email>
    name = <username>
```

# Inspiration

Locations to go look at for organization or useful features.

* [Big ol' list](https://dotfiles.github.io/inspiration/)
* [owl4ce/dotfiles](https://github.com/owl4ce/dotfiles)
* [jessarcher/dotfiles](https://github.com/owl4ce/dotfiles)
  * [YT mini-walkthrough](https://www.youtube.com/watch?v=434tljD-5C8)
