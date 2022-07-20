## NeoVim

### Major

#### `js` indent

Should be 2 not 4.

#### `.d.ts` filetype detection

See title.

#### `json` LSP for errors

See title.

#### Tab completion in file search breaks sometimes

`:tabe <file>` tab completion sometimes stops working (why, no idea). Super super annoying though.

#### Indentation for JS/TS comments

Comment indentation is **super** wrong.

#### Easy Quick List

* block visual past EOL
* Smart case search
* persistent undo
* backup dir
* undo dir
* no highlight matching braces
* default spacing to 2 :shocked_face: -- maybe....
* clear search highlight until next search

#### Use system clipboard

Don't want it as they yank buffer but do want a command to be able to yank and
paste to/from the system clipboard.

#### pink as the error highlight with red text is bad.

Ewwwwww on colors.

#### <TAB> with a space before it blows up tab complete

```
E5108: Error executing lua /Users/quillank/.config/nvim/lua/config/nvim-cmp.lua:10: attempt to call field 'unpack' (a nil value)
stack traceback:
        /Users/quillank/.config/nvim/lua/config/nvim-cmp.lua:10: in function 'has_words_before'
        /Users/quillank/.config/nvim/lua/config/nvim-cmp.lua:63: in function 'on_keymap'
        ...re/nvim/site/pack/packer/start/nvim-cmp/lua/cmp/core.lua:146: in function 'callback'
        ...site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:118: in function <...site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:112>
        ...site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:248: in function <...site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:247>
```
This happens when I try to tab (in lua at least) without anything previous on
the line. Also in txt if the previous thing isn't a character (is whitespace).

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

#### Refactor lsp

Refactor the lsp server setup so it's a little cleaner (not just one giant file
for a start).

#### Add lsp servers

From top the list of servers `lsp-installer` supports, these seem useful:
 * `AWK	awk_ls`
 * `Bash	bashls`
 * `C	ccls`
 * `C	clangd`
 * `C++	ccls`
 * `C++	clangd`
 * `CMake	cmake`
 * `CSS	cssls`
 * `CSS	cssmodules_ls`
 * `Cucumber	cucumber_language_server`
 * `Docker	dockerls`
 * `ESLint (docs)	eslint`
 * `HTML	html`
 * `JSON	jsonls`
 * `Java (docs)	jdtls`
 * `Jsonnet	jsonnet_ls`
 * `Kotlin	kotlin_language_server`
 * `LaTeX	ltex`
 * `LaTeX	texlab`
 * `Lua	sumneko_lua`
 * `Markdown	marksman`
 * `Markdown	prosemd_lsp`
 * `Markdown	remark_ls`
 * `Markdown	zk`
 * `Python	jedi_language_server`
 * `Python	pyright`
 * `Python	sourcery`
 * `Python (docs)	pylsp`
 * `Ruby	solargraph`
 * `Rust	rust_analyzer`
 * `Sphinx	esbonio`
 * `Tailwind CSS	tailwindcss`

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