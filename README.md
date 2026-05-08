# Dotfiles

My configuration files that (mostly) follow the [XDG Base Directory
Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

## Installation

1. Clone into `.config`: `git clone --recurse-submodules https://github.com/qkaseman/dotfiles.git ~/.config`
1. Setup root zshenv from `resources`
1. Install fonts, or use a local configuration to override the default.
1. Run `.setup/macos.sh` (macOS) for tool installation and service setup.
1. Profit?

### macOS

#### Manual Steps

After running the setup script, these manual steps are required:

1. **Hide the macOS menu bar** (SketchyBar replaces it):
   System Settings → Control Center →
   "Automatically hide and show the menu bar" → "Always"
2. **Disable macOS Spaces animations** (AeroSpace uses virtual workspaces):
   System Settings → Accessibility → Display → "Reduce motion" → ON
3. **Consolidate to a single macOS Space**: Move all windows to one desktop in
   Mission Control. AeroSpace manages workspaces — macOS Spaces will conflict.
4. **Install fonts**: Double-click each `.ttf` in `resources/font/` and click
   "Install".
5. **Disable Finder search shortcut** (`alt-cmd-space` conflicts with AeroSpace):
   System Settings → Keyboard → Keyboard Shortcuts → Spotlight →
   uncheck "Show Finder search window"

#### Keybinding Conflicts

AeroSpace uses `alt` (Option) as its modifier. The following macOS defaults
may conflict. Verified on macOS 15.7.4 (Sequoia).

| AeroSpace Binding | macOS Default | Notes |
| ----------------- | ------------- | ----- |
| `alt-cmd-space` | Finder search window | Rebind or disable in System Settings → Keyboard → Shortcuts |
| `alt-e` | Accent dead key (´ + next key → é) | Blocks accented character input |
| `alt-h/j/k/l` | Special characters (ø, ∆, ˚, ¬) | Acceptable — rarely needed |
| `alt-shift-h/j/k/l` | More special characters | Acceptable |
| `alt-v` | √ | Acceptable |
| `alt-s` | ß | Acceptable |
| `alt-w` | ∑ | Acceptable |
| `alt-c` | ç | Acceptable |
| `alt-r` | ® | Acceptable |
| `alt-1` through `alt-0` | ¡™£¢∞§¶•ªº | Acceptable |

## Architecture

### XDG Variables

Set in `/etc/zshenv` (or equivalent) and available to all config files:

| Variable | Default |
|----------|---------|
| `XDG_CONFIG_HOME` | `~/.config` |
| `XDG_CONFIG_LOCAL_HOME` | `~/.local/config` |
| `XDG_DATA_HOME` | `~/.local/share` |
| `XDG_STATE_HOME` | `~/.local/state` |
| `XDG_BIN_HOME` | `~/.local/bin` |
| `XDG_CACHE_HOME` | `~/.cache` |
| `XDG_RUNTIME_DIR` | `/tmp/${UID}` |

Note: `XDG_RUNTIME_DIR` is set on macOS for completeness only. macOS does not
natively support the XDG runtime directory concept (no per-user tmpfs with
guaranteed permissions).

### Local Configuration

These configuration files will also look for local configuration files at
`$XDG_CONFIG_LOCAL_HOME`. This is for work-specific configuration that cannot
be made public, as well as odd install paths and tool-specific overrides.

The public configs in this repo are set up to source from `$XDG_CONFIG_LOCAL_HOME`
where appropriate. Tools that don't natively look there will need environment
variables pointing them to the right directories -- the actual directory names
within the local config are meaningless to the system, but I recommend following
the same naming pattern as `$XDG_CONFIG_HOME` for sanity.

`$XDG_CONFIG_LOCAL_HOME` defaults to `${HOME}/.local/config`.

I recommend running the global `.setup/` scripts first to ensure base tools are
installed, which simplifies local setup scripts by letting them assume things
like brew, git, and mise are already available. But the local config is entirely
its own thing -- structure it however makes sense for your environment.

#### ZSH

The global `zshrc` sources `${ZSH_LOCAL_HOME}/zshrc` as the very last thing it
does. What happens inside that file is up to you. I recommend following the
same `zsd` pattern (sourcing `.d/` directories) for consistency, but it's not
required.

### ZSH

#### Load Order

1. `${ZDOTDIR}/zshenv`
1. `${ZSH_LOCAL_HOME}/zshenv`
1. `${ZDOTDIR}/zshrc`
   1. `zsd alias.d`
   2. `zsd config.d`
   3. `zsd os/{macos,linux}.d`
1. `${ZSH_LOCAL_HOME}/zshrc` (whatever you put here)

The entire global config is fully loaded before the local `zshrc` runs. The
local config can reference any variable or function defined globally.

#### File Numbering Convention

Borrowed from
[init.d](https://en.wikipedia.org/wiki/Init#SysV-style) scripts. Within each
`.d/` directory, files are sourced in glob order. Numeric prefixes control
ordering:

- `00-core.zsh` -- foundational setup (variables, guards)
- `20-powerlevel10k.zsh-theme.zsh` -- theme loading
- `21-powerlevel10k.zsh` -- theme configuration
- `50-completion.zsh` -- completion system
- `90-zsh-syntax-highlighting.zsh` -- must be last

Gaps between numbers exist so I don't have to `git mv` things and pollute
history every time something new needs to slot in.

#### Platform Dispatch

Platform-specific config lives in `os/{macos,linux,freebsd}.d/` directories.
Architecture differences (arm64 vs x86_64) are handled inside those files. I
recommend following the same pattern in your local configuration repo.

#### PATH

The global `zshrc` automatically adds `${XDG_CONFIG_LOCAL_HOME}/bin` to `$PATH`
if the directory exists. Scripts placed there are available without further
configuration.

### Git

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

## Applications

### Slack

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

#### Legacy Slack Theme

This is the legacy theme string. You can just put this in as the string to
import in `Theme colors`, but I have no faith that process won't change.

```
#005F87,#350d36,#0087AF,#E4E4E4,#00AFAF,#E4E4E4,#008700,#AF0000,#005F87,#E4E4E4
```

### Alacritty

#### Window Decoration

For non-tiling window managers (or if you want to be able to drag with the
mouse), add the following to the local configuration:

```yaml
window:
  decorations: full
```

### `mise`

> DO NOT USE `mise`. The maintainer is dismissive and unreceptive to feedback and
> that should not be supported. I am required to use it because of my job
> otherwise I would kill it.

[`mise`](https://mise.jdx.dev/), formerly `rtx`, is the new agnostic version
management tool, similar to [`asdf`](https://asdf-vm.com/). It is a bit more
flexible than `asdf` but also has already succumbed to scope creep, adding task
execution and general development environment management features. Hopefully
those won't conflict with the core usefulness of `mise`.

Thankfully `mise` respects the XDG specification, so as long as you have those
set everything will work properly, just follow the [Quick Start
Guide](https://mise.jdx.dev/getting-started.html).

#### How to use Node code names with `mise`?

Add this to `${XDG_CONFIG_HOME}/mise/config.toml`:

```toml
[alias.node.versions]
    argon = '4'
    boron = '6'
    carbon = '8'
    dubnium = '10'
    erbium = '12'
    fermium = '14'
    gallium = '16'
    hydrogen = '18'
    iron = '20'
    jod = '22'
```

### `fzf`

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

#### `ripgrep`

`fzf` is configured to use [`ripgrep`](https://github.com/BurntSushi/ripgrep),
if installed. Highly recommend.

### ZSH Aliases

I don't generally rely on plugins for my aliases as I add them too piecemeal
for a plugin that provides a large number to be useful. But, here are some
places to look for inspiration if desired:

* [Common Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
* [Ubuntu Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu)
* [MacOS Aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos)

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
cp ${XDG_CONFIG_HOME}/resources/font/* ~/.local/share/fonts/
```

## Inspiration

Locations to go look at for organization or useful features.

* [Big ol' list](https://dotfiles.github.io/inspiration/)
* [owl4ce/dotfiles](https://github.com/owl4ce/dotfiles)
* [jessarcher/dotfiles](https://github.com/jessarcher/dotfiles)
  * [YT mini-walkthrough](https://www.youtube.com/watch?v=434tljD-5C8)
* [kazhala/dotfiles](https://github.com/kazhala/dotfiles)
* [MyPickles/dotfiles](https://github.com/MrPickles/dotfiles)
* [EdenEast/dots](https://github.com/EdenEast/dots)
* [dotfiles](https://dotfiles.github.io/inspiration/)
* [mattmc3/zshrc](https://github.com/mattmc3/zshrc.d)
* [ibnunes/zshrc](https://github.com/ibnunes/zshrc)
