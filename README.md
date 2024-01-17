# Dotfiles

My configuration files that (mostly) follow the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

## Installation

1. Clone into `.config`: `git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git ~/.config`
1. Setup root zshenv from `resources`
1. Install fonts, or use a local configuration to override the default.
1. Profit?

## Local Configuration

These configuration files will also look for local configuration files at
`$XDG_CONFIG_LOCAL_HOME`. Mostly this is for odd install paths and aliases for
confidential tools as OS differences are (currently) handled via conditional
script sourcing inside this repository. These local configurations are the
final configuration files loaded and will therefore override the configurations
set here.

`$XDG_CONFIG_LOCAL_HOME` defaults to `${HOME}/.local/config` and the programs
in this expect their 'root' directory to have the same name as the one in
`${HOME}/.config`. Some applications have their own, more specific, local
environment variables. See those sections for more details. Some applications
cannot perform environment variable expansion, so those will directly reference
the default location.

### Super Special MacOS Configuration

MacOS has a weird `${ZDOTDIR}/.zsh_sessions/` directory it creates when
starting a default Apple Terminal instance. As far as I can tell, it is used
for storing history per terminal session, which isn't a feature I want even if
I did use the default terminal. However, some commands, such as
`react-native`, may trigger a new instance of the Apple Terminal to open
and that will still generate the `.zsh_sessions` directory.

The only way you can disable it is to add the your `/etc/zprofile`:

```bash
# Disable Apple Terminal's session files.
export SHELL_SESSIONS_DISABLE=1
```

## Resources

### `zsh/zshenv`

This sets up `zsh` to follow the XDG specification. If you own the computer,
you should add these in `/etc/zsh/zshenv` (or the equivalent) and you won't
need a `~/.zshrc` or `~/.zshenv` at all. If you can't, you'll need to add these
exports to `~/.zshenv` and then have both configuration files in your home
directory source from the ones in this repository.

### `font/*`

Open-source fonts that are nice to use. Install as appropriate for the OS.
Currently aren't any as I'm not sure the nicest way to actually store them.

#### macOS

Double click on the `.ttf` and then click `Install`. You'll have to do this for
each `.ttf` file.

#### Ubuntu

Copy fonts into `~/.local/share/fonts/`:

```bash
> cp ${XDG_CONFIG_HOME}/resources/font/* ~/.local/share/fonts/
```

# Applications

## Slack

Slack now provides even less of a way to create custom themes and still no
light/dark custom theme support, yay....

This set of colours is an attempt to have a
[`PaperColor`](https://github.com/NLKNguyen/papercolor-theme)-esque theme in
Slack, though less successful than within the legacy theming system.

| Property              | Hex     | Swatch                                                       |
|-----------------------|---------|--------------------------------------------------------------|
| Window background     | #005f87 |![#005f87](https://place-hold.it/100x40/005f87/000000?text=+) |
| Selected items        | #0087af |![#0087af](https://place-hold.it/100x40/0087af/000000?text=+) |
| Presence indication   | #008700 |![#008700](https://place-hold.it/100x40/008700/000000?text=+) |
| Notifications         | #af0000 |![#af0000](https://place-hold.it/100x40/af0000/000000?text=+) |

### Legacy Slack Theme

This is the legacy theme string. You can just put this in as the string to
import in `Theme colors`, but I have no faith that process won't change.

```
#005F87,#350d36,#0087AF,#E4E4E4,#00AFAF,#E4E4E4,#008700,#AF0000,#005F87,#E4E4E4
```

## ZSH

### Local Configuration

The configuration load order is as follows:

1. `${ZDOTDIR}/zshenv`
1. `${ZSH_LOCAL_HOME}/zshenv`
1. `${ZDOTDIR}/zshrc`
1. `${ZSH_LOCAL_HOME}/zshrc`

This order enables things like the installation directory to be set in the
local `zshenv` and then the various installed files are properly sourced by the
`rc` files.

### Aliases

I don't generally rely on plugins for my aliases as I add them too piecemeal
for a plugin that provides a large number to be useful. But, here are some
places to look for inspiration if desired:

* [Common Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
* [Ubuntu Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu)
* [MacOS Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos)

## Alacritty

### Window Decoration

For non-tiling window managers (or if you want to be able to drag with the
mouse), add the following to the local configuration:

```yaml
window:
  decorations: full
```

## `asdf`

[`asdf`](https://asdf-vm.com/) is a terribly named runtime manager.

### Installation

If the installation is done via a package manager (i.e. `brew`), set
`ASDF_BIN_HOME` in your local local `zshenv`
(`${XDG_CONFIG_LOCAL_HOME}/zsh/zshenv`) to override the default location so
initialization works correctly. If you don't, it will look like `asdf` is
installed (you'll have the shell completion and command) but none of the
environments installed will be available.

For a 'standard' installation, do:

```bash
> git clone --depth 1 https://github.com/asdf-vm/asdf.git ${ASDF_BIN_HOME} --branch v0.10.0
```

#### NodeJS Plugin

If desired, install the NodeJS plugin to manage Node runtimes:

```bash
> asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
> asdf install nodejs lts-gallium
```

## Git

`git` nicely handles multiple configuration files, though not sourcing (as far
as I know). Therefore, the core `git` configurations are provided by this
repository but specifics (i.e. email) or overrides should be set in
`~/.gitconfig`.

At a minimum, `~/.gitconfig` should contain:

```
[user]
    email = <email>
    name = <username>
```

## `fzf`

[`fzf`](https://github.com/junegunn/fzf) is a fuzzy file finder that is quite useful.

If the installation is done via a package manager or you just want to install
it into a different location, set `FZF_HOME` in your local `zshenv`, just like
with `asdf`.

For the install itself, all we want is for the binary to be downloaded,
everything else is already configured/included in this repository:

```bash
> git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_HOME}
> ${FZF_HOME}/install --bin
```

### `ripgrep`

`fzf` is configured to use [`ripgrep`](https://github.com/BurntSushi/ripgrep),
if installed. Highly recommend.

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
