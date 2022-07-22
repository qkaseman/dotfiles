## NeoVim

### Major

#### `.d.ts` filetype detection

See title.

#### Tab completion in file search breaks sometimes

`:tabe <file>` tab completion sometimes stops working (why, no idea). Super super annoying though.

#### Indentation for JS/TS comments

Comment indentation is **super** wrong.

#### pink as the error highlight with red text is bad.

Ewwwwww on colors.

#### menu tab completion sometimes doesn't work

It seems to think it's a `variable` (by the completion source) but not sure if
that's just how that kind of thing is "sourced").

### Minor

#### Markdown syntax highlighting

Is broken if there are 3 sets of backticks on a single line, but maybe only if there are `<>`?

#### Spell check

Would be nice to always have spellcheck on (prob should auto trigger for `md`
and `txt` etc... files. Also would love spell checking in comments but not sure
how possible that will be.

#### Add lsp servers

From top the list of servers `lsp-installer` supports, these seem useful:
 * `AWK	awk_ls`
 * `C	ccls`
 * `C	clangd`
 * `C++	ccls`
 * `C++	clangd`
 * `CSS	cssmodules_ls`
 * `Jsonnet	jsonnet_ls`
 * `LaTeX	ltex`
 * `LaTeX	texlab`
 * `Markdown	marksman`
 * `Markdown	prosemd_lsp`
 * `Markdown	remark_ls`
 * `Markdown	zk`
 * `Python	jedi_language_server`
 * `Python	sourcery`
 * `Python (docs)	pylsp`
 * `Sphinx	esbonio`

#### `lua` syntax highlighting is wonky

Sometimes not all of the string is highlighted. For example,
`require('config.keymap')` will have `keymap` highlighted but not `config.`.

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
