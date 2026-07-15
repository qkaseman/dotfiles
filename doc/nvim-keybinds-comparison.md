# Keybind Comparison: nvim / kickstart / LazyVim 15.x

Reference for the LazyVim migration. Compares Neovim 0.11.x built-in defaults,
kickstart.nvim's init.lua mappings, and LazyVim core (extras noted where
relevant).

## Mode Legend

`n`=normal `v`=visual `x`=visual-block `o`=op-pending `i`=insert `t`=terminal
`s`=select `c`=cmdline

> "plain nvim" = Neovim 0.11.x built-ins (incl. native `gc`/`gcc` commenting and
> 0.11 LSP `LspAttach` defaults). Items flagged `?` are not 100% certain.

## Group: Top-level / non-leader

| Key                  | Mode    | Plain nvim                                           | kickstart                               | LazyVim                                                            | Notes                                                    |
| -------------------- | ------- | ---------------------------------------------------- | --------------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------- |
| `<Esc>`              | n       | clear cmd                                            | clear hlsearch                          | clear hlsearch + stop snippet                                      | both override default                                    |
| `j` `k`              | n,x     | line motion                                          | line motion                             | `gj`/`gk` (visual line aware) when count=0                         | LazyVim wraps                                            |
| `<Down>` `<Up>`      | n,x     | line motion                                          | line motion                             | `gj`/`gk` (visual line aware)                                      | LazyVim only                                             |
| arrow keys           | n       | h/j/k/l (default)                                    | enabled                                 | enabled                                                            | (your config disables them; not stock kickstart/LazyVim) |
| `Y`                  | n       | `y$` (default)                                       | (default)                               | (default)                                                          | nvim changed default to `y$`                             |
| `n` `N`              | n,x,o   | search next/prev                                     | (default)                               | `'Nn'[searchforward].'zv'` (centered)                              | LazyVim wraps for direction-aware repeat                 |
| `<C-h/j/k/l>`        | n       | --                                                   | window nav                              | window nav (with `remap=true` for tmux integration)                | both override defaults                                   |
| `<C-Up>/<C-Down>`    | n       | --                                                   | --                                      | resize +/- 2 height                                                | LazyVim only                                             |
| `<C-Left>/<C-Right>` | n       | --                                                   | --                                      | vertical resize                                                    | LazyVim only                                             |
| `<A-j>` `<A-k>`      | n,i,v   | --                                                   | --                                      | move line(s) down/up                                               | LazyVim only                                             |
| `<S-h>` `<S-l>`      | n       | top/bottom of screen (default)                       | (default)                               | prev/next buffer (`bprevious`/`bnext`; `BufferLineCyclePrev/Next`) | LazyVim shadows H/L                                      |
| `<Tab>` `<S-Tab>`    | n       | `<C-i>` jumplist fwd / --                            | (default)                               | (default)                                                          | neither remaps                                           |
| `<C-d>` `<C-u>`      | n       | half-page scroll (default)                           | (default)                               | (default)                                                          | --                                                       |
| `<C-s>`              | i,n,x,s | --                                                   | --                                      | `:w<cr>` (save file)                                               | LazyVim only                                             |
| `<C-/>`              | n,t     | --                                                   | --                                      | toggle Snacks terminal (root dir)                                  | LazyVim only                                             |
| `<C-_>`              | n,t     | --                                                   | --                                      | terminal (alias of `<C-/>` for terminals that send C-\_)           | LazyVim only                                             |
| `<C-f>` `<C-b>`      | n,i,s   | page fwd/back (default)                              | (default)                               | scroll noice docs / fall through                                   | LazyVim conditional                                      |
| `<C-Space>`          | n,o,x   | --                                                   | --                                      | flash treesitter incremental sel                                   | LazyVim only                                             |
| `<S-Enter>`          | c       | --                                                   | --                                      | redirect cmdline to noice                                          | LazyVim only                                             |
| `gx`                 | n       | open URL under cursor (default 0.10+)                | (default)                               | (default, with which-key label)                                    | --                                                       |
| `K`                  | n       | `keywordprg`; LSP hover when attached (default 0.11) | (default; kickstart relies on built-in) | `vim.lsp.buf.hover()` (explicit)                                   | same effect                                              |
| `gK`                 | n       | --                                                   | --                                      | `vim.lsp.buf.signature_help()`                                     | LazyVim only                                             |
| `<C-k>`              | i       | --                                                   | --                                      | signature help                                                     | LazyVim only                                             |
| `gq` `gw`            | n,o     | format / format-keep-cursor (default)                | (default)                               | (default)                                                          | --                                                       |

## Group: Brackets `[` and `]`

| Key       | Mode  | Plain nvim                           | kickstart | LazyVim                                              | Notes                             |
| --------- | ----- | ------------------------------------ | --------- | ---------------------------------------------------- | --------------------------------- |
| `[d` `]d` | n     | diagnostic prev/next (default 0.10+) | (default) | `diagnostic_goto(false/true)` w/ float               | LazyVim wraps with `vim.v.count1` |
| `[e` `]e` | n     | --                                   | --        | prev/next ERROR                                      | LazyVim only                      |
| `[w` `]w` | n     | --                                   | --        | prev/next WARN                                       | LazyVim only                      |
| `[q` `]q` | n     | --                                   | --        | quickfix prev/next (or trouble if open)              | LazyVim only                      |
| `[b` `]b` | n     | --                                   | --        | prev/next buffer                                     | LazyVim only                      |
| `[B` `]B` | n     | --                                   | --        | move buffer in bufferline                            | LazyVim only                      |
| `[h` `]h` | n     | --                                   | --        | gitsigns prev/next hunk                              | LazyVim only                      |
| `[H` `]H` | n     | --                                   | --        | first/last hunk                                      | LazyVim only                      |
| `[t` `]t` | n     | --                                   | --        | prev/next todo-comment                               | LazyVim only                      |
| `[c` `]c` | n     | diff change prev/next (default)      | (default) | (default; or hunk if gitsigns and diff)              | --                                |
| `[[` `]]` | n     | section start/end (default)          | (default) | snacks.words prev/next reference (when LSP attached) | LazyVim shadows                   |
| `[s` `]s` | n     | spell error prev/next (default)      | (default) | (default)                                            | --                                |
| `[m` `]m` | n     | method start/end (default)           | (default) | (default)                                            | --                                |
| `[f` `]f` | n,x,o | --                                   | --        | ts-textobjects prev/next function start              | LazyVim only                      |
| `[F` `]F` | n,x,o | --                                   | --        | function end                                         | LazyVim only                      |
| `[C` `]C` | n,x,o | --                                   | --        | class end (start = `[c`/`]c` non-diff buffers)       | LazyVim only                      |
| `[a` `]a` | n,x,o | --                                   | --        | parameter prev/next                                  | LazyVim only                      |
| `[A` `]A` | n,x,o | --                                   | --        | parameter end                                        | LazyVim only                      |

## Group: `g*` (LSP / commenting / surround)

| Key             | Mode  | Plain nvim                              | kickstart                                 | LazyVim                                      | Notes                                    |
| --------------- | ----- | --------------------------------------- | ----------------------------------------- | -------------------------------------------- | ---------------------------------------- |
| `gc`            | n,o,x | comment operator (default 0.10+)        | (default)                                 | (default)                                    | --                                       |
| `gcc`           | n     | linewise comment (default)              | (default)                                 | (default)                                    | --                                       |
| `gco`           | n     | --                                      | --                                        | add comment line below                       | LazyVim only                             |
| `gcO`           | n     | --                                      | --                                        | add comment line above                       | LazyVim only                             |
| `gd`            | n     | (no default)                            | telescope `lsp_definitions` (`grd`)       | snacks.picker `lsp_definitions`              | LazyVim binds gd to LSP                  |
| `gD`            | n     | --                                      | `vim.lsp.buf.declaration` (`grD`)         | `vim.lsp.buf.declaration`                    | LazyVim uses unmodified `gD`             |
| `gr`            | n     | (default `gr` = virtual-replace 1 char) | -- (uses `grr`)                           | `vim.lsp.buf.references` / snacks picker     | LazyVim shadows the rare `gr` default    |
| `gI`            | n     | --                                      | -- (uses `gri`)                           | snacks picker `lsp_implementations`          | --                                       |
| `gy`            | n     | --                                      | --                                        | snacks picker `lsp_type_definitions`         | LazyVim only                             |
| `grn`           | n     | rename (default 0.11 LSP attach)        | rename                                    | -- (replaced by `<leader>cr`)                | nvim 0.11 default; LazyVim removes       |
| `gra`           | n,x   | code action (default 0.11)              | code action                               | -- (replaced by `<leader>ca`)                | nvim 0.11 default                        |
| `grr`           | n     | references (default 0.11)               | telescope `lsp_references`                | -- (replaced by `gr`)                        | nvim 0.11 default                        |
| `gri`           | n     | implementation (default 0.11)           | telescope `lsp_implementations`           | -- (replaced by `gI`)                        | nvim 0.11 default                        |
| `grt`           | n     | -- ? (not in 0.11 defaults)             | telescope `lsp_type_definitions`          | -- (replaced by `gy`)                        | kickstart only                           |
| `grd`           | n     | --                                      | telescope `lsp_definitions`               | -- (replaced by `gd`)                        | kickstart only                           |
| `grD`           | n     | --                                      | `vim.lsp.buf.declaration`                 | -- (replaced by `gD`)                        | kickstart only                           |
| `gO`            | n     | document symbols (default 0.10+)        | telescope `lsp_document_symbols`          | (default; LazyVim doesn't override)          | --                                       |
| `gW`            | n     | --                                      | telescope `lsp_dynamic_workspace_symbols` | -- (use `<leader>sS`)                        | kickstart only                           |
| `gai`           | n     | --                                      | --                                        | snacks picker incoming calls                 | LazyVim only                             |
| `gao`           | n     | --                                      | --                                        | snacks picker outgoing calls                 | LazyVim only                             |
| `gs*`           | n,x   | (default `gs` sleep)                    | --                                        | which-key group "surround" via mini.surround | LazyVim binds surround under `gs` prefix |
| `<a-n>` `<a-p>` | n     | --                                      | --                                        | snacks.words next/prev reference (cycle)     | LazyVim only                             |

## Group: `<leader>` top-level

| Key                               | Mode | Plain nvim | kickstart                   | LazyVim                         | Notes              |
| --------------------------------- | ---- | ---------- | --------------------------- | ------------------------------- | ------------------ |
| `<leader><space>`                 | n    | --         | --                          | find files (root dir)           | LazyVim only       |
| `<leader><leader>`                | n    | --         | telescope buffers           | -- (LazyVim uses `<leader>,`)   | --                 |
| `<leader>,`                       | n    | --         | --                          | snacks buffers picker           | LazyVim only       |
| `<leader>:`                       | n    | --         | --                          | command history                 | LazyVim only       |
| `<leader>/`                       | n    | --         | telescope buffer fuzzy find | snacks live grep (root dir)     | DIFFERENT BEHAVIOR |
| <code>&lt;leader&gt;`</code>      | n    | --         | --                          | switch to other buffer (`:e #`) | LazyVim only       |
| `<leader>-`                       | n    | --         | --                          | split window below              | LazyVim only       |
| <code>&lt;leader&gt;&#124;</code> | n    | --         | --                          | split window right              | LazyVim only       |
| `<leader>e`                       | n    | --         | --                          | snacks explorer (root dir)      | LazyVim only       |
| `<leader>E`                       | n    | --         | --                          | snacks explorer (cwd)           | LazyVim only       |
| `<leader>f`                       | n,v  | --         | format buffer (conform)     | (group: file/find)              | DIFFERENT MEANING  |
| `<leader>K`                       | n    | --         | --                          | run normal `K` (keywordprg)     | LazyVim only       |
| `<leader>L`                       | n    | --         | --                          | LazyVim changelog               | LazyVim only       |
| `<leader>l`                       | n    | --         | --                          | `:Lazy`                         | LazyVim only       |
| `<leader>n`                       | n    | --         | --                          | notification history            | LazyVim only       |
| `<leader>q`                       | n    | --         | diagnostic loclist          | (group: quit/session)           | DIFFERENT MEANING  |
| `<leader>?`                       | n    | --         | --                          | which-key buffer keymaps        | LazyVim only       |
| `<leader>S`                       | n    | --         | --                          | scratch buffer select           | LazyVim only       |
| `<leader>.`                       | n    | --         | --                          | toggle scratch buffer           | LazyVim only       |

## Group: `<leader>b*` (buffer)

| Key                       | Mode | Plain nvim | kickstart | LazyVim                   | Notes   |
| ------------------------- | ---- | ---------- | --------- | ------------------------- | ------- |
| `<leader>bb`              | n    | --         | --        | switch to other buffer    | LazyVim |
| `<leader>bd`              | n    | --         | --        | delete buffer (snacks)    | LazyVim |
| `<leader>bD`              | n    | --         | --        | delete buffer + window    | LazyVim |
| `<leader>bo`              | n    | --         | --        | delete other buffers      | LazyVim |
| `<leader>bi`              | n    | --         | --        | delete invisible buffers  | LazyVim |
| `<leader>bp`              | n    | --         | --        | bufferline toggle pin     | LazyVim |
| `<leader>bP`              | n    | --         | --        | delete non-pinned         | LazyVim |
| `<leader>br` `<leader>bl` | n    | --         | --        | delete buffers right/left | LazyVim |
| `<leader>bj`              | n    | --         | --        | bufferline pick           | LazyVim |

## Group: `<leader>c*` (code)

| Key                       | Mode    | Plain nvim | kickstart          | LazyVim                           | Notes     |
| ------------------------- | ------- | ---------- | ------------------ | --------------------------------- | --------- |
| `<leader>ca`              | n,x     | --         | --                 | code action (replaces 0.11 `gra`) | LazyVim   |
| `<leader>cA`              | n       | --         | --                 | source action                     | LazyVim   |
| `<leader>cc` `<leader>cC` | n,x / n | --         | --                 | run / refresh codelens            | LazyVim   |
| `<leader>cd`              | n       | --         | --                 | line diagnostics float            | LazyVim   |
| `<leader>cf`              | n,x     | --         | (uses `<leader>f`) | format (force)                    | DIFFERENT |
| `<leader>cF`              | n,x     | --         | --                 | format injected langs             | LazyVim   |
| `<leader>cl`              | n       | --         | --                 | snacks LSP info                   | LazyVim   |
| `<leader>cm`              | n       | --         | --                 | `:Mason`                          | LazyVim   |
| `<leader>co`              | n       | --         | --                 | organize imports                  | LazyVim   |
| `<leader>cr`              | n       | --         | --                 | rename (replaces 0.11 `grn`)      | LazyVim   |
| `<leader>cR`              | n       | --         | --                 | rename file                       | LazyVim   |
| `<leader>cs`              | n       | --         | --                 | symbols (Trouble)                 | LazyVim   |
| `<leader>cS`              | n       | --         | --                 | LSP refs/defs (Trouble)           | LazyVim   |

## Group: `<leader>f*` (file/find) -- LazyVim-specific prefix

| Key                       | Mode | Plain nvim | kickstart | LazyVim                  | Notes   |
| ------------------------- | ---- | ---------- | --------- | ------------------------ | ------- |
| `<leader>ff` `<leader>fF` | n    | --         | --        | find files (root / cwd)  | LazyVim |
| `<leader>fg`              | n    | --         | --        | git files                | LazyVim |
| `<leader>fr` `<leader>fR` | n    | --         | --        | recent files (all / cwd) | LazyVim |
| `<leader>fb` `<leader>fB` | n    | --         | --        | buffers                  | LazyVim |
| `<leader>fc`              | n    | --         | --        | find config file         | LazyVim |
| `<leader>fp`              | n    | --         | --        | projects                 | LazyVim |
| `<leader>fn`              | n    | --         | --        | new file (`:enew`)       | LazyVim |
| `<leader>fe` `<leader>fE` | n    | --         | --        | snacks explorer          | LazyVim |
| `<leader>ft` `<leader>fT` | n    | --         | --        | terminal                 | LazyVim |

Kickstart equivalents lived under `<leader>s` (e.g. `sf`, `s.`). LazyVim
duplicates many in `<leader>s*` too.

## Group: `<leader>g*` (git)

| Key                         | Mode  | Plain nvim | kickstart                     | LazyVim                        | Notes          |
| --------------------------- | ----- | ---------- | ----------------------------- | ------------------------------ | -------------- |
| `<leader>gg` `<leader>gG`   | n     | --         | --                            | lazygit (root / cwd)           | LazyVim        |
| `<leader>gb`                | n     | --         | --                            | git blame line (snacks picker) | LazyVim        |
| `<leader>gB`                | n,x   | --         | --                            | git browse (open in browser)   | LazyVim        |
| `<leader>gY`                | n,x   | --         | --                            | git browse (copy URL)          | LazyVim        |
| `<leader>gd` `<leader>gD`   | n     | --         | --                            | git diff hunks / vs origin     | LazyVim        |
| `<leader>gf`                | n     | --         | --                            | git current file history       | LazyVim        |
| `<leader>gl` `<leader>gL`   | n     | --         | --                            | git log                        | LazyVim        |
| `<leader>gs` `<leader>gS`   | n     | --         | --                            | git status / stash             | LazyVim        |
| `<leader>gh*`               | n,x,o | --         | (kickstart uses `<leader>h*`) | hunk operations (gitsigns)     | RENAMED PREFIX |
| `<leader>ghs`               | n,x   | --         | `<leader>hs`                  | stage hunk                     | --             |
| `<leader>ghr`               | n,x   | --         | `<leader>hr`                  | reset hunk                     | --             |
| `<leader>ghS` `<leader>ghu` | n     | --         | `<leader>hS`/`<leader>hu`     | stage buffer / undo stage      | --             |
| `<leader>ghR`               | n     | --         | `<leader>hR`                  | reset buffer                   | --             |
| `<leader>ghp`               | n     | --         | `<leader>hp`                  | preview hunk                   | --             |
| `<leader>ghb` `<leader>ghB` | n     | --         | `<leader>hb`                  | blame line / blame buffer      | --             |
| `<leader>ghd` `<leader>ghD` | n     | --         | `<leader>hd`/`<leader>hD`     | diff this / diff this~         | --             |

## Group: `<leader>h*` -- kickstart gitsigns / LazyVim unbound

| Key          | Mode | Plain nvim | kickstart         | LazyVim                                       | Notes                                                     |
| ------------ | ---- | ---------- | ----------------- | --------------------------------------------- | --------------------------------------------------------- |
| `<leader>h*` | n,v  | --         | gitsigns hunk ops | unbound (used by harpoon2 extra if installed) | MIGRATE TO `<leader>gh*` (or rebind back to `<leader>h*`) |

## Group: `<leader>q*` (quit/session) -- LazyVim only

| Key          | Mode | Plain nvim | kickstart             | LazyVim              | Notes    |
| ------------ | ---- | ---------- | --------------------- | -------------------- | -------- |
| `<leader>q`  | n    | --         | diagnostic setloclist | (group prefix)       | CONFLICT |
| `<leader>qq` | n    | --         | --                    | `:qa` quit all       | LazyVim  |
| `<leader>qs` | n    | --         | --                    | restore session      | LazyVim  |
| `<leader>qS` | n    | --         | --                    | select session       | LazyVim  |
| `<leader>ql` | n    | --         | --                    | restore last session | LazyVim  |
| `<leader>qd` | n    | --         | --                    | stop saving session  | LazyVim  |

## Group: `<leader>s*` (search) -- biggest divergence

| Key                       | Mode | Plain nvim | kickstart                           | LazyVim                               | Notes             |
| ------------------------- | ---- | ---------- | ----------------------------------- | ------------------------------------- | ----------------- |
| `<leader>sh`              | n    | --         | telescope help_tags                 | snacks help                           | both: help search |
| `<leader>sk`              | n    | --         | telescope keymaps                   | snacks keymaps                        | --                |
| `<leader>sf`              | n    | --         | telescope find_files                | -- (use `<leader>ff`)                 | RENAMED           |
| `<leader>ss`              | n    | --         | telescope builtin picker            | LSP document symbols                  | DIFFERENT         |
| `<leader>sS`              | n    | --         | --                                  | LSP workspace symbols                 | LazyVim           |
| `<leader>sw`              | n,v  | --         | telescope grep_string               | snacks grep word (root)               | both: word grep   |
| `<leader>sW`              | n,x  | --         | --                                  | grep word (cwd)                       | LazyVim           |
| `<leader>sg`              | n    | --         | telescope live_grep                 | snacks live grep (root)               | similar           |
| `<leader>sG`              | n    | --         | --                                  | live grep (cwd)                       | LazyVim           |
| `<leader>sd`              | n    | --         | telescope diagnostics               | snacks diagnostics                    | --                |
| `<leader>sD`              | n    | --         | --                                  | buffer diagnostics                    | LazyVim           |
| `<leader>sr`              | n    | --         | telescope resume                    | -- (use `<leader>sR`)                 | RENAMED           |
| `<leader>sR`              | n    | --         | (your config: grug-far)             | snacks resume picker                  | LazyVim           |
| `<leader>s.`              | n    | --         | telescope oldfiles                  | -- (use `<leader>fr`)                 | RENAMED           |
| `<leader>sc`              | n    | --         | telescope commands                  | command history                       | DIFFERENT         |
| `<leader>sC`              | n    | --         | --                                  | commands                              | LazyVim           |
| `<leader>sn`              | n    | --         | telescope find files in nvim config | (group: noice)                        | DIFFERENT         |
| `<leader>snl/h/a/d/t`     | n    | --         | --                                  | noice last/history/all/dismiss/picker | LazyVim           |
| `<leader>s/`              | n    | --         | telescope live grep open files      | search history                        | DIFFERENT         |
| `<leader>s"`              | n    | --         | --                                  | registers                             | LazyVim           |
| `<leader>sa`              | n    | --         | --                                  | autocmds                              | LazyVim           |
| `<leader>sb` `<leader>sB` | n    | --         | --                                  | buffer lines / grep open buffers      | LazyVim           |
| `<leader>sH`              | n    | --         | --                                  | highlights                            | LazyVim           |
| `<leader>si`              | n    | --         | --                                  | icons                                 | LazyVim           |
| `<leader>sj`              | n    | --         | --                                  | jumps                                 | LazyVim           |
| `<leader>sl`              | n    | --         | --                                  | location list                         | LazyVim           |
| `<leader>sm` `<leader>sM` | n    | --         | --                                  | marks / man pages                     | LazyVim           |
| `<leader>sp`              | n    | --         | --                                  | search plugin spec                    | LazyVim           |
| `<leader>sq`              | n    | --         | --                                  | quickfix list                         | LazyVim           |
| `<leader>su`              | n    | --         | --                                  | undotree                              | LazyVim           |
| `<leader>st` `<leader>sT` | n    | --         | --                                  | todo / todo+fix+fixme                 | LazyVim           |

## Group: `<leader>t*` -- varies

| Key          | Mode | Plain nvim | kickstart                    | LazyVim                                       | Notes                                  |
| ------------ | ---- | ---------- | ---------------------------- | --------------------------------------------- | -------------------------------------- |
| `<leader>t`  | n    | --         | (kickstart group "[T]oggle") | -- (used by extras: test/neotest, claudecode) | YOUR CONFIG: toggleterm; LazyVim drops |
| `<leader>th` | n    | --         | toggle inlay hints           | (use `<leader>uh`)                            | RENAMED                                |

## Group: `<leader>u*` (UI toggles)

| Key                       | Mode | Plain nvim | kickstart                  | LazyVim                               | Notes   |
| ------------------------- | ---- | ---------- | -------------------------- | ------------------------------------- | ------- |
| `<leader>uf` `<leader>uF` | n    | --         | --                         | toggle format on save (buf / global)  | LazyVim |
| `<leader>us`              | n    | --         | --                         | spell                                 | LazyVim |
| `<leader>uw`              | n    | --         | --                         | wrap                                  | LazyVim |
| `<leader>ul` `<leader>uL` | n    | --         | --                         | line numbers / relative               | LazyVim |
| `<leader>ud`              | n    | --         | --                         | diagnostics                           | LazyVim |
| `<leader>uh`              | n    | --         | (kickstart's `<leader>th`) | inlay hints                           | RENAMED |
| `<leader>ug`              | n    | --         | --                         | indent guides                         | LazyVim |
| `<leader>uc`              | n    | --         | --                         | conceal level                         | LazyVim |
| `<leader>ub`              | n    | --         | --                         | dark/light background                 | LazyVim |
| `<leader>uA`              | n    | --         | --                         | tabline                               | LazyVim |
| `<leader>uT`              | n    | --         | --                         | treesitter                            | LazyVim |
| `<leader>uD`              | n    | --         | --                         | dim                                   | LazyVim |
| `<leader>ua`              | n    | --         | --                         | animate                               | LazyVim |
| `<leader>uS`              | n    | --         | --                         | scroll                                | LazyVim |
| `<leader>uG`              | n    | --         | --                         | git signs                             | LazyVim |
| `<leader>un`              | n    | --         | --                         | dismiss notifications                 | LazyVim |
| `<leader>ui`              | n    | --         | --                         | inspect pos                           | LazyVim |
| `<leader>uI`              | n    | --         | --                         | inspect TS tree                       | LazyVim |
| `<leader>uz` `<leader>uZ` | n    | --         | --                         | zen / zoom                            | LazyVim |
| `<leader>uC`              | n    | --         | --                         | colorschemes picker                   | LazyVim |
| `<leader>ur`              | n    | --         | --                         | redraw / clear hlsearch / diff update | LazyVim |

## Group: `<leader>w*` (windows) -- LazyVim proxies `<C-w>`

| Key            | Mode | Plain nvim | kickstart | LazyVim                           | Notes   |
| -------------- | ---- | ---------- | --------- | --------------------------------- | ------- |
| `<leader>w*`   | n    | --         | --        | proxies `<C-w>` (all window cmds) | LazyVim |
| `<leader>wd`   | n    | --         | --        | delete window (`<C-W>c`)          | LazyVim |
| `<leader>wm`   | n    | --         | --        | toggle zoom                       | LazyVim |
| `<C-w><Space>` | n    | --         | --        | which-key window hydra mode       | LazyVim |

## Group: `<leader>x*` (diagnostics/quickfix)

| Key                       | Mode | Plain nvim | kickstart | LazyVim                           | Notes   |
| ------------------------- | ---- | ---------- | --------- | --------------------------------- | ------- |
| `<leader>xx`              | n    | --         | --        | Trouble diagnostics               | LazyVim |
| `<leader>xX`              | n    | --         | --        | Trouble buffer diagnostics        | LazyVim |
| `<leader>xL`              | n    | --         | --        | Trouble loclist                   | LazyVim |
| `<leader>xQ`              | n    | --         | --        | Trouble qflist                    | LazyVim |
| `<leader>xl` `<leader>xq` | n    | --         | --        | toggle loclist / quickfix windows | LazyVim |
| `<leader>xt` `<leader>xT` | n    | --         | --        | Trouble todo / todo+fix+fixme     | LazyVim |

## Group: `<leader><tab>*` (tabs)

| Key                               | Mode | Plain nvim | kickstart | LazyVim                 | Notes   |
| --------------------------------- | ---- | ---------- | --------- | ----------------------- | ------- |
| `<leader><tab><tab>`              | n    | --         | --        | new tab                 | LazyVim |
| `<leader><tab>l` `<leader><tab>f` | n    | --         | --        | last / first tab        | LazyVim |
| `<leader><tab>]` `<leader><tab>[` | n    | --         | --        | next / prev tab         | LazyVim |
| `<leader><tab>d` `<leader><tab>o` | n    | --         | --        | close tab / close other | LazyVim |

## Insert mode

| Key             | Plain nvim        | kickstart | LazyVim                      | Notes                                    |
| --------------- | ----------------- | --------- | ---------------------------- | ---------------------------------------- |
| `<C-h>`         | (default)         | (default) | (default)                    | not remapped                             |
| `<C-k>`         | digraph (default) | (default) | signature_help               | LazyVim shadows digraph                  |
| `<C-s>`         | --                | --        | save file                    | LazyVim                                  |
| `<A-j>` `<A-k>` | --                | --        | move line down/up            | LazyVim                                  |
| `,` `.` `;`     | (default)         | (default) | undo break-points (`<c-g>u`) | LazyVim only (your config has these too) |
| `<c-f>` `<c-b>` | (default)         | (default) | scroll noice docs            | LazyVim                                  |

## Terminal mode

| Key             | Plain nvim | kickstart          | LazyVim                     | Notes                                 |
| --------------- | ---------- | ------------------ | --------------------------- | ------------------------------------- |
| `<Esc><Esc>`    | --         | exit terminal mode | -- (LazyVim doesn't bind)   | KICKSTART ONLY (your config keeps it) |
| `<C-/>` `<C-_>` | --         | --                 | hide snacks terminal        | LazyVim                               |
| `<C-h/j/k/l>`   | --         | --                 | snacks terminal: nav window | LazyVim only                          |

## Visual / Visual-block

| Key                     | Mode | Plain nvim                          | kickstart | LazyVim                       | Notes                                                |
| ----------------------- | ---- | ----------------------------------- | --------- | ----------------------------- | ---------------------------------------------------- |
| `<` `>`                 | x    | indent (loses sel)                  | (default) | `<gv` / `>gv` (keeps sel)     | LazyVim only                                         |
| `j` `k` `<Down>` `<Up>` | x    | (default)                           | (default) | wrap-aware `gj/gk`            | LazyVim only                                         |
| `n` `N`                 | x,o  | (default)                           | (default) | direction-aware repeat        | LazyVim only                                         |
| `p` (visual paste)      | x    | overwrites + replaces register      | (default) | (default)                     | YOUR CONFIG: paste-and-reyank; LazyVim does NOT bind |
| `s` `S`                 | x,o  | substitute / linewise sub (default) | --        | flash jump / flash treesitter | LazyVim shadows `s`/`S`                              |
| `R`                     | x    | --                                  | --        | flash treesitter search       | LazyVim                                              |

## Major divergences kickstart -> LazyVim

The biggest user-visible changes when migrating from kickstart-derived:

- **Buffer cycling on `<S-h>`/`<S-l>`** -- LazyVim shadows the vim defaults H/L
  (top/bottom of screen). Kickstart leaves them alone.
- **Buffer/file finding moved to `<leader>f*`** -- kickstart puts everything
  under `<leader>s*` (e.g. `sf`, `s.`). LazyVim splits: file/find under
  `<leader>f*`, search/grep under `<leader>s*`. Many `<leader>s*` keys exist in
  both with different meanings (e.g. `<leader>sr` = telescope resume in
  kickstart, but in LazyVim resume is `<leader>sR`).
- **`<leader>q` collision** -- kickstart binds it directly to "open diagnostic
  loclist." LazyVim claims `<leader>q` as the quit/session group prefix. The
  kickstart action has no direct LazyVim equivalent (closest: `<leader>xl` for
  loclist toggle, `<leader>xq` for quickfix, or `<leader>cd` for line
  diagnostics float).
- **`<leader>/` flips meaning** -- kickstart: fuzzy find in current buffer.
  LazyVim: live grep (root dir). The buffer-fuzzy equivalent in LazyVim is
  `<leader>sb` (snacks buffer lines).
- **Gitsigns prefix renamed `<leader>h*` -> `<leader>gh*`** -- every hunk op
  (`hs`, `hr`, `hp`, `hb`, etc.) gains a `g` prefix in LazyVim. Your migration
  plan rebinds these back to `<leader>h*`.
- **LSP `gr*` series replaced** -- kickstart and Neovim 0.11 both ship
  `grn`/`gra`/`grr`/`gri` defaults. LazyVim removes those and rebinds to
  `<leader>cr` (rename), `<leader>ca` (code action), `gr` (references), `gI`
  (implementation), `gd` (definition), `gy` (type def), `gD` (declaration).
- **Inlay hints toggle** `<leader>th` -> `<leader>uh`. The whole `<leader>t*`
  ("toggle") prefix is gone in LazyVim -- toggles live under `<leader>u*` (UI).
- **`<leader>f` no longer formats** -- kickstart binds `<leader>f` to conform
  format. LazyVim uses `<leader>cf` for force-format and auto-formats on save by
  default. `<leader>f*` becomes the file/find group.
- **LazyVim adds heavy `<C-*>` and `<A-*>` usage** -- `<C-h/j/k/l>` window nav
  (with `remap=true`), `<C-Up/Down/Left/Right>` resize, `<A-j>/<A-k>` move
  lines, `<C-s>` save, `<C-/>` terminal toggle, `<C-Space>` ts incremental
  selection.
- **`s`/`S` shadowed by flash** -- kickstart users still get vim's substitute on
  `s`/`S` (unless they install flash). LazyVim makes flash a default, breaking
  muscle memory.
- **Many new bracket motions** -- `[b/]b` buffers, `[h/]h` hunks, `[t/]t` todo,
  `[q/]q` quickfix, `[e/]e` errors, `[w/]w` warnings, plus `[f/]f`, `[c/]c`,
  `[a/]a` from ts-textobjects. Plain nvim and kickstart only ship `[d/]d`,
  `[c/]c` (diff), `[s/]s` (spell), `[m/]m` (method), `[[/]]` (section).
- **`[[`/`]]` repurposed** -- LazyVim binds them to "next/prev LSP reference"
  (snacks.words) when LSP is attached, shadowing vim's section motion.
- **Visual `p` differs** -- kickstart-style configs (yours included) bind visual
  `p` to "paste and re-yank." LazyVim does NOT bind it; vim default applies.
- **Terminal `<Esc><Esc>`** -- kickstart binds it to exit terminal mode. LazyVim
  does not -- you must use `<C-\><C-n>` unless your terminal plugin
  (toggleterm/snacks) maps it.
- **LazyVim adds `<leader>w*` window proxy** -- every `<C-w>x` is reachable as
  `<leader>wx` with which-key hints.
- **LazyVim adds `<leader>b*` buffer ops** -- kickstart provides nothing here.
- **`gco`/`gcO`** (add comment line below/above) -- LazyVim only. Plain nvim's
  native commenting (since 0.10) only ships `gc` and `gcc`.

Caveats: Plain Neovim 0.11 LSP-attach defaults: `grn`, `gra`, `grr`, `gri`,
`gO`, `K`, and `<C-s>` (insert sig help). Not certain whether `grt`/`grd`/`grD`
are 0.11 defaults; to my knowledge they aren't (kickstart adds them).
`:help lsp-defaults` on a fresh nvim install confirms.
