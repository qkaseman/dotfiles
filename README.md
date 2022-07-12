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

This sets up `zsh` to have XDG variables defined and make `zsh` itself follow
the spec.

The exports in this script should be added to `/etc/zsh/zshenv`. Eventually
this might get automated, but manual is fine for now.

# Applications

## Slack

No way to automate the colorschme, but paste this into the "Custom Theme
Colors" section of `slack` to get a theme that is `PaperColor`-esque.

```
#005F87,#350d36,#0087AF,#E4E4E4,#00AFAF,#E4E4E4,#008700,#AF0000,#005F87,#E4E4E4
```

## ZSH

### Aliases

I don't generally rely on plugins for my aliases as I add them too piecemeal
for a plugin that provides a large number to be useful. But, here are some
places to look for inspiration if desired:

* [Common Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
* [Ubuntu Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu)
* [MacOS Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos)

### Zsh Plugins to look at in the future.

* [`fz`](https://github.com/changyuheng/fz) might be replicated by having `fzf-tab` installed.
* [`fzf-tab-completion`](https://github.com/lincheney/fzf-tab-completion) seems to be the same thing as `fzf-tab` pretty much (and the additional change of the `zsh` completion to `fzf` seemed unneeded). Maybe change in the future if issues come up with `fzf-tab`.
* [`you-should-use`](https://github.com/MichaelAquilina/zsh-you-should-use) for suggestions on aliases that are defined that match the command you just ran. There is also a plugin with the name `tipz` or something that looks similar.
* [`fzf.plugin.zsh`](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fzf/fzf.plugin.zsh) possibly useful things associated with `fzf`
* [`Zsh Zephyr`](https://github.com/mattmc3/zephyr) seems to have a lot of good default settings so I should look at those and pull out what seems nice after I live with these settings for a while.
* [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting) apparently has better and faster highlighting so should try that.

### Plugin/module changes

Could do something like [`zsh-unplugged`](https://github.com/mattmc3/zsh_unplugged) rather than have them as git submodules. Might be easier to deal with?

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
> git clone https://github.com/asdf-vm/asdf.git ${ASDF_BIN_HOME} --branch v0.10.0
```

If the installation is elsewhere (i.e. homebrew), set `$ASDF_BIN_HOME` in the
local `zshenv` (`${XDG_CONFIG_LOCAL_HOME}/zsh/zshenv`) to override the default
location so setup works appropriately.

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

## `fzf`

[`fzf`](https://github.com/junegunn/fzf) is a fuzzy file finder that needs to
be installed separately. All the configuration files in this repo assume it is
installed into `$FZF_HOME`. This can be set in the local `zshenv` to override
the default location.

For the install itself, all we want is for the binary to be downloaded,
everything else is already configured.

```
git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_HOME}
${FZF_HOME}/install --bin
```

### `ripgrep`

`fzf` is configured to use [`ripgrep`](https://github.com/BurntSushi/ripgrep)
which also needs to be installed. Make sure it's in the path.

# Inspiration

Locations to go look at for organization or useful features.

* [Big ol' list](https://dotfiles.github.io/inspiration/)
* [owl4ce/dotfiles](https://github.com/owl4ce/dotfiles)
* [jessarcher/dotfiles](https://github.com/owl4ce/dotfiles)
  * [YT mini-walkthrough](https://www.youtube.com/watch?v=434tljD-5C8)
* [kazhala/dotfiles](https://github.com/kazhala/dotfiles)
* [MyPickles/dotfiles](https://github.com/MrPickles/dotfiles)
* [EdenEast/dots](https://github.com/EdenEast/dots)
* [dotfiles](https://dotfiles.github.io/inspiration/)

# TODO

## Zsh plugin completions

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
* `autosuggestions` maybe not as nice as I always think before adding them?

## Git

* Merge summary perhaps
