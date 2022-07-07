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

## ZSH

### Aliases

I don't generally rely on plugins for my aliases as I add them too piecemeal for a plugin that provides a large number to be useful. But, here are some places to look for inspiration if desired:

* [Common Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
* [Ubuntu Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu)
* [MacOS Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos)


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

TODO: Decide if `asdf` should be a submodule and have a `bin` directory in
`.config` that is symlinked inside `${XDG_BIN_HOME}` for each dir. This would
keep the version the same across computers which is maybe good, maybe bad?

### Installation

Install `asdf` into `${XDG_BIN_HOME}`:

```
> git clone https://github.com/asdf-vm/asdf.git ${XDG_BIN_HOME}/asdf --branch v0.10.0
```

#### NodeJS Plugin

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

# TODO

## fzf

[fzf]() is a fuzzy file finder that needs to be installed.

This should get installed however is appropriate for the distro. If manual, the
repo should be cloned into XDG_BIN_HOME and `./install` run. I need to see what
actually gets installed into the zsh configurations to figure out exactly what
args to run.

Looks like `./install --no-fish --no-bash --xdg` currently but in the future
might also want to have it not do some of the setup stuff (like if it just adds
parts to zshrc to source the exact location of the completion files in the fzf
repo.

```
git clone --depth=1 https://github.com/junegunn/fzf.git /tmp/fzf
/tmp/fzf/install
```

## Plugins

**Searching**
* https://github.com/changyuheng/fz
* https://github.com/skywind3000/z.lua
**Completion**
* https://github.com/lincheney/fzf-tab-completion
* https://github.com/Aloxaf/fzf-tab
**Alias Recommenders (maybe)**
* https://github.com/Aloxaf/fzf-tab
* https://github.com/MichaelAquilina/zsh-you-should-use
**Maybe**
* https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fzf/fzf.plugin.zsh
* https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ripgrep

## Neovim

* https://github.com/NLKNguyen/papercolor-theme
* trim whitespace
* Highlight trailing whitespace
* lsp/coc
* system clipboard
* default spacing to 2 :shocked_face:
* clear search term
* spell check but not code
* persistent undo
* backup dir
* undo dir
* smart case search
* no highlight matching braces
* block visual allowed past end of lines
* open splits on the "correct" sides

## ZSH

* better expansion (a-d<TAB> --> amazing-directory)
* arrow search

## Git

* Merge summary perhaps
