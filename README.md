# Configurations

Yeah, that's really it. I'm sure I'll have more to add later.

## Alacritty

### Local Configuration

The local configuration file `~/.local/share/alacritty/config.yml` is loaded last and will override any configurations in this repo.

### Window Decoration

For non-tiling window managers (or if you want to be able to drag with the mouse), add the following to the local configuration:

```
window:
  decorations: full
```

### Fonts

Install fonts into `~/.local/share/fonts/`.

## Git

The core git configurations are within the `git` directory here. However, as the name and email might change (for example, when using work email) so that information should be added to `~/.gitconfig` as:

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
