# ZSH

TODOs and open questions for the ZSH config.

## fzf-tab

### `sudo` tab completion doesn't work

`sudo <cmd><TAB>` produces no completions at all. Standard `_sudo` completion
is a known friction point. Look at whether `fzf-tab` needs a `sudo`-specific
rule, whether zsh's `_sudo` completion isn't loading, or whether it's a
`securesudo` interaction.

### Single-child directory auto-fills too eagerly

When only one entry exists in the directory being completed, `fzf-tab` fills
it in and immediately opens the next completion menu without a pause.
Frustrating in practice. Look for a config option to suppress -- likely
`continuous-trigger` or `accept-line` in the `fzf-tab` config.

## Completions

### Install `ripgrep`'s official zsh completions

Prefer `rg`'s built-in generator over the ohmyzsh plugin:

```zsh
rg --generate=complete-zsh > "${XDG_DATA_HOME}/zsh/completions/_rg"
```

Make sure `${XDG_DATA_HOME}/zsh/completions` is on `$fpath` before
`compinit` runs. Add the generation step to `.setup/` and the fpath entry
to `env.d/`.

## Plugins

### Reevaluate `zsh-autosuggestions`

Always think I like them, but seeing them I'm never quite sure. Live
without for a week and decide.

### Try `fzf-tab-completion` as an alternative to `fzf-tab`

[lincheney/fzf-tab-completion](https://github.com/lincheney/fzf-tab-completion)
looks redundant with `fzf-tab` but may address the annoyances above. Worth a
trial if the `fzf-tab` issues persist.

### Consider `zsh-unplugged`-style plugin management

Move away from git submodules toward
[`zsh-unplugged`](https://github.com/mattmc3/zsh_unplugged)-style loading.
Would match `nvim`'s lazy-loading paradigm and simplify plugin
add/update/remove. Could also fold in installation of tools like `fzf` and
`mise`.
