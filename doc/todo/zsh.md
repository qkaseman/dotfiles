## ZSH

### Major

#### `sudo` Tab Completion

Just doesn't seem to work at all.

#### Tab Completion jump

When there is only one directory (option?) inside of the directory you are
completing to, `fzf-tab` automatically fills that in and then opens a new
completion menu, which is really frustrating.

#### Tab Completion color

The color of the tab completion is dark grey background with black text which
is impossible to read. The general background is fine but the selection is bad.

#### Tab completion `npm`

`npm` tab completion doesn't work `npm <TAB>` or with any amount of leading `-`
will also fail.

### Minor

#### `ripgrep` completions

Add [`ripgrep completions`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ripgrep)

#### Reevaluate `autosuggestions`

Always think I like them, but when seeeing them I'm never quite sure I do.

#### Try `fzf-tab-complete`

Seemed redundant with `fzf-tab` (and might be) and with less features but the
annoyances in `fzf-tab` might make it worth trying.

#### Plugin/module relayout

Could do something like
[`zsh-unplugged`](https://github.com/mattmc3/zsh_unplugged) rather than have
them as git submodules. Would be more consistent with `nvim` and might be
easier to deal with. Could also automate the installing of tools like `fzf` and
`asdf`.

#### Moar plugins!

* [`fz`](https://github.com/changyuheng/fz) might be replicated by having
  `fzf-tab` installed.
* [`fzf-tab-completion`](https://github.com/lincheney/fzf-tab-completion) seems
  to be the same thing as `fzf-tab` pretty much (and the additional change of
  the `zsh` completion to `fzf` seemed unneeded). Maybe change in the future if
  issues come up with `fzf-tab`.
* [`you-should-use`](https://github.com/MichaelAquilina/zsh-you-should-use) for
  suggestions on aliases that are defined that match the command you just ran.
  There is also a plugin with the name `tipz` or something that looks similar.
* [`fzf.plugin.zsh`](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fzf/fzf.plugin.zsh)
  possibly useful things associated with `fzf`
* [`Zsh Zephyr`](https://github.com/mattmc3/zephyr) seems to have a lot of good
  default settings so I should look at those and pull out what seems nice after
  I live with these settings for a while.
* [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting)
  apparently has better and faster highlighting so should try that.
