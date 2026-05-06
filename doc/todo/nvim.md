# NeoVim

## LSP Things

- `toml`

## Other things

- `git` isn't using `nvim` nor my config on new laptop, maybe need to handle
  in setup scripts?

### Major

#### `.d.ts` filetype detection

See title.

#### Tab completion in file search breaks sometimes

`:tabe <file>` tab completion sometimes stops working (why, no idea). Super super annoying though.

#### pink as the error highlight with red text is bad.

Ewwwwww on colors.

#### menu tab completion sometimes doesn't work

It seems to think it's a `variable` (by the completion source) but not sure if
that's just how that kind of thing is "sourced").

### Minor

#### Spelling cache into `.local/share`

So that git ignore can be removed.

#### Markdown syntax highlighting

Is broken if there are 3 sets of backticks on a single line, but maybe only if there are `<>`?

#### `lua` indent bad

Treesitter seems to indent incorrectly as this:

```lua
if not ok then<ENTER>
<CURSOR>
```

When you would expect:

```lua
if not ok then<ENTER>
    <CURSOR>
```

#### Plugin simplification

If `plugin.lua` has the proper dependency modeling, then I can only do the
`pcall` crap on the final one at the top of the file. Much cleaner.

#### tpope surround

I finally see the use of this, look into it.

#### tpope commentary

Look into this as well, pretty sure I used it in the past and liked it.

#### Line highlight not working

Should be highlighting but not underlining the current buffer....

#### Title flicker

The terminal title bar and the vim tab title both flicker a bunch when the
autocomplete extra buffers come up.

#### Column Marker

`80` chars and maybe a lighter one at `100`?

#### `autochdir`

Maybe want, maybe don't. I'll see how it is without it for a while.

#### Telescope plugin

Try it.

#### Other Plugins

The ones these people have:
* https://github.com/williamboman/nvim-config/tree/main/plugin
* https://github.com/LunarVim/LunarVim
* Jess Archer
* Two others from my PC I don't recall

#### Markdown syntax

`npm` tab completion doesn't work `npm <TAB>`

That highlights the middle as code due to the `<`.

#### Look into autopairs plugins

I don't generally like them but it looks like there are a number of indentation
things that only *really* work with that being setup. (`lua` is a current
example but I'm sure it applies to more.

#### `gitcommit` tab completion

The tab completion seems to be broken now? Git gives an error about `hint:
Waiting for your editor to close the file...` which might indicate something.

## From init.lua (moved here)

- fix `gqq` for all buf types
- Figure out auto-install of LSP like Treesitter has for grammar
- Evaluate complexity of LSP module and determine if should be submodules
- Figure out why fidget.nvim isn't showing LSP updates sometimes
- submit help page bug to Neovim `vim.wo.diff` doesn't have anything for
  `:help wo`, it takes you to `wildmenu` not set `window-local` options
- Figure out why resuming workspace froze nvim for a while. Seems like it
  is the LSP struggling when a file has been deleted or changed while
  Neovim is suspended. Seems weird as that should be async.
- Set up TypeScript/JavaScript DAP
- Figure out why prettier support isn't working right
- make keybind to generate hover window of diag error
- make keybind to make hoverwindow of type
- make/figure out keybind to move in completion window without arrows
- figure out the `mini.surround` and `mini.ai` uses

## Keybind Namespace Cleanup

`<leader>t` group mixes terminals (toggleterm: tf/tH/tv/tn/tp/tl/tt/tu/ts)
and toggles (gitsigns: tb/tD, LSP: th). Consider splitting:
- Terminals stay under `<leader>t` (rename group to [T]erminal)
- Move gitsigns toggles (tb, tD) to `<leader>u` (UI Toggle)
- LSP inlay hints (`th`) could also move to `<leader>uh`
