# NeoVim

TODOs and open questions for the Neovim config.

## LSP

### Add `taplo` LSP for TOML files

Not currently in `ensure_installed`. Add to `nvim/lua/plugins/lsp.lua` and
verify `.toml` files get syntax-aware editing (hover, completion, diagnostics).

## Editor integration

### `git commit` message highlighting on new machines

On a fresh laptop, `git commit` opens the commit-message buffer with broken or
absent syntax highlighting even after Neovim and this config are in place.
Investigate whether it's `EDITOR`/`VISUAL` pointing somewhere unexpected, a
missing `gitcommit` treesitter parser, or a filetype-detection race during
setup-script bootstrap.

## Plugins

### Filetype-triggered treesitter parser install

Some Neovim distro (name forgotten) auto-installed the correct treesitter
parser when a new filetype was detected, rather than requiring parsers to be
pre-declared in `ensure_installed`. Nice ergonomic. Worth prototyping if it
fits with LazyVim's `nvim-treesitter` config model. Low priority.

## Syntax / rendering

### Markdown syntax highlighting breaks on multiple backticks

Broken when three sets of backticks appear on a single line, especially with
`<>` mixed in. Treesitter markdown parser edge case. May not reproduce on the
current parser -- verify before spending time on it.

### `lua` indent wrong after `then` newline

Treesitter indents this way:

```lua
if not ok then
<CURSOR>
```

Should indent one shiftwidth:

```lua
if not ok then
  <CURSOR>
```

Verify still reproduces on current treesitter / nvim.

## Storage

### Move spelling additions to `$XDG_DATA_HOME`

Currently `nvim/spell/` is gitignored in the repo. Redirect via
`vim.opt.spellfile = "$XDG_DATA_HOME/nvim/spell/en.utf-8.add"` (data, not
state -- spell additions are portable user dictionary content that should
sync across machines) so the gitignore entry can drop.

### Split spell dictionary: general vs work-specific

Investigate whether `spellfile` accepts multiple paths (comma-separated? `+=`?)
so a portable "public" dictionary can live under `$XDG_DATA_HOME/nvim/spell`
and a work/private one under `$XDG_CONFIG_LOCAL_HOME/nvim/spell` without
leaking company terms across machines.

## Config

### `autochdir` vs LazyVim's `root_dir`

Vim's `autochdir` changes cwd to match each buffer's directory on switch.
LazyVim's `root_dir` logic detects a project marker (`.git`, `package.json`,
`pyproject.toml`, LSP root) and keeps cwd stable at the detected project root
instead. Modern tooling assumes a stable root, so `autochdir` conflicts with:

- LSPs cache their workspace on startup; bouncing cwd re-triggers workspace
  detection and can double-load servers.
- Pickers (`<leader>ff`, `<leader>fg`) scope to root, so `autochdir` makes the
  same key mean different things depending on which buffer is focused.
- Terminal splits inherit cwd from Neovim.
- `persistence.nvim` keys sessions by cwd.

Almost certainly not worth enabling. Kept here so the decision is explicit
rather than reflexive.

## Deferred from LazyVim migration

Three items marked as "deferred discussions" in the LazyVim migration plan
(removed 2026-07-15) that still warrant later attention:

### markdownlint config location

nvim-lint's `markdownlint` linter reads
`.markdownlint.{jsonc,json,yaml,yml,cjs}` walking up from the file's directory.
Config currently lives at `$XDG_CONFIG_HOME/markdownlint/config.json` and
`nvim/lua/plugins/lint.lua` passes it via `--config` flag. Decide whether to
(a) keep the `--config` flag long-term, (b) move to a per-repo
`.markdownlint.jsonc`, or (c) symlink to `~/.markdownlint.jsonc` (home
pollution; not preferred).

### Prefix-meaning audit

Walk through the `<leader>` group prefixes and confirm semantic consistency
after living with them. Current assignments: `c` (code), `b` (buffer),
`d` (debug), `s` (search/find), `g` (git), `h` (hunks), `Q` (session),
`T` (terminal), `u` (UI toggle), `w` (window), `x` (diagnostics/quickfix),
`t` (free for toggles or the `extras.test.core` extra if enabled). Adjust if
any feel off.

### Tabs vs buffers vs marks/jumplist

Revisit navigation patterns. Historical habit is tabs; marks and the jumplist
are underused. Worth exploring: buffer + split + jumplist workflow, or a
harpoon-style pin list, as alternatives to tabs.
