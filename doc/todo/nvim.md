## NeoVim

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
