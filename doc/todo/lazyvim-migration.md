# LazyVim Migration Plan

Source: `~/.config/mvim/` (old hand-rolled config, preserved) Target:
`~/.config/nvim/` (fresh LazyVim 15.x starter)

## Status Legend

- `[x]` decided, will port -- work pending
- `[-]` decided, skip (LazyVim default is sufficient)
- `[~]` decided, drop entirely (not porting)
- `[?]` open question, needs decision

---

## A. Must Port

### Custom plugins

- `[x]` **1.** vim-tmux-navigator -- plugin spec, intercept `<C-hjkl>` for
  tmux-aware split nav
- `[x]` **2.** auto-dark-mode.nvim -- plugin spec, polls OS appearance
- `[x]` **3.** toggleterm.nvim full setup -- D61 resolved (`<C-/>` and `<C-'>`
  retained, REPLs/lazygit/btm/gdu moved to `<leader>T*` per item 110). Contents:
  - Float (rounded border, size 15h / 40%v), `<c-/>` open mapping
  - Term-mode `<C-hjkl>` to nav out of terminal splits
  - `<leader>tf/tH/tv` direction variants (float/horizontal/vertical)
  - `<leader>tn` Node REPL (vsplit), `<leader>tp` Python3 REPL
  - `<leader>tl` and `<leader>gg` lazygit float, `<leader>tt` btm, `<leader>tu`
    gdu (resolves `gdu-go` on mac)
  - `<leader>ts` send line / visual selection to terminal
  - `<c-'>` toggle last terminal
- `[~]` **4.** ~Color migration~ -- defer, will do later
- `[x]` **5.** Wildcharm as default colorscheme (built-in, just override
  LazyVim's tokyonight)

### Plugin opts overrides

- `[~]` **6.** vtsls custom settings -- _tabled per user, revisit later_.
  LazyVim's `extras.lang.typescript` ships nearly identical defaults already, so
  no override planned for migration. Contents (from `mvim/lua/plugins/lsp.lua`)
  preserved here for reference:

  ```
  complete_function_calls = true
  vtsls.enableMoveToFileCodeAction = true
  vtsls.autoUseWorkspaceTsdk = true
  vtsls.experimental.maxInlayHintLength = 30
  vtsls.experimental.completion.enableServerSideFuzzyMatch = true
  typescript.updateImportsOnFileMove.enabled = 'always'
  typescript.suggest.completeFunctionCalls = true
  typescript.inlayHints.{enumMemberValues, functionLikeReturnTypes, parameterTypes, propertyDeclarationTypes} enabled
  typescript.inlayHints.parameterNames = 'literals'
  typescript.inlayHints.variableTypes = false
  ```

  LazyVim's `extras.lang.typescript` already ships nearly identical defaults
  (move-to-file, inlay hints, server-side fuzzy match). Enabling that extra
  subsumes most of this.

- `[x]` **7.** Mason `ensure_installed` strategy: **option A** (extras + manual
  hybrid) consolidated into single `lua/plugins/lsp.lua`. Pattern:

  ```lua
  return {
    -- enable language extras
    { import = "lazyvim.plugins.extras.lang.typescript" },  -- vtsls + eslint
    { import = "lazyvim.plugins.extras.lang.python" },      -- basedpyright + ruff (or override to pylsp)
    { import = "lazyvim.plugins.extras.lang.json" },        -- jsonls + SchemaStore
    { import = "lazyvim.plugins.extras.lang.yaml" },        -- yamlls + SchemaStore
    { import = "lazyvim.plugins.extras.lang.markdown" },    -- marksman + markdownlint-cli2 + markdown-toc
    { import = "lazyvim.plugins.extras.lang.java" },        -- jdtls
    { import = "lazyvim.plugins.dap.core" },                -- DAP (item 39)

    -- manual ensure_installed for what extras don't cover
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "bash-language-server",
          "css-lsp",
          "cucumber-language-server",
          "gradle-language-server",
          "html-lsp",
          "some-sass-language-server",
          "stylelint-lsp",
          "commitlint",
          "editorconfig-checker",
          "ktlint",
          "prettierd",
        },
      },
    },
  }
  ```

  `opts_extend = { "ensure_installed" }` is set on mason.nvim by LazyVim, so the
  manual list ADDS to extras. Single file is the source of truth for what's
  installed. Note: LazyVim's python extra uses basedpyright/ruff by default; if
  user prefers pylsp, override `servers.pylsp = {}` and
  `servers.basedpyright = { enabled = false }`. **Open: confirm pylsp vs
  basedpyright preference.**

- `[x]` **8.** markdownlint custom config flag -- defer to system:
  `markdownlint-cli` reads `.markdownlint.{jsonc,json,yaml,yml,cjs}` walking up
  from cwd. **Action: move config to `~/.markdownlint.jsonc`** (no XDG default
  unfortunately) and drop the `--config` flag from the linter spec.
  Outside-of-nvim usage gets the same config. Confirm working before dropping
  the explicit flag.

### Custom code

- `[x]` **9.** Foldexpr -- drop user's `lua/config/util/fold.lua`, use
  `v:lua.LazyVim.treesitter.foldexpr()`. User's was literally a copy of
  LazyVim's; LazyVim caches via `M._installed`/`_queries` so the manual
  `vim.b.has_ts_folds` cache is no longer needed.

### Personal keymaps

All in a single `lua/config/keymaps.lua` override file:

- `[x]` **10.** `;` -> `:` (n/v/op)
- `[x]` **11.** Arrow keys disabled (echo "Use h/j/k/l")
- `[x]` **12.** `<C-S-h/j/k/l>` move windows
- `[x]` **13.** `j`/`k` respect visual line wraps
- `[x]` **14.** `Y` -> `y$`
- `[x]` **15.** Visual `<`/`>` keep selection (`<gv`/`>gv`)
- `[x]` **16.** Visual `p` re-yanks (`pgvy`)
- `[x]` **17.** `<leader>y` (n,v) and `<leader>Y` (n) yank to system clipboard
- `[x]` **18.** `]<Space>` / `[<Space>` insert blank line below/above
- `[x]` **19.** `,` `.` `;` insert undo breakpoints. **Explanation:**
  `inoremap , ,<C-g>u` etc. `<C-g>u` in insert mode breaks the undo sequence.
  Without it, an entire `i...<Esc>` insert is one undo unit. With these mapped,
  punctuation marks split the insert into smaller undoable chunks, so `u` undoes
  back to the last comma/period instead of the whole sentence.

### Option overrides

- `[x]` **20.** `spell = true`, `spelllang = 'en'`. **Treesitter governs
  comment-only**: `@spell` capture in TS highlight queries scopes spell-checking
  to comments/strings. Code tokens are skipped automatically when a TS parser is
  installed.
- `[x]` **21.** `clipboard = ''` keep explicit. Difference: with `clipboard=''`,
  `y` writes only to unnamed register `"`; system clipboard untouched. With
  `clipboard='unnamedplus'` (LazyVim default), `y` writes to `+` (system) AND
  `"`. User wants opt-in clipboard via `<leader>y`.
- `[~]` **22.** `colorcolumn` -- D69: leave off for now (had duplicates issue).
  Drop from override list.
- `[~]` **23.** `conceallevel = 0` keep -- user dislikes prettier rendering.
  **What it does at 2:** for markdown, `**bold**` displays as `bold`, `*italic*`
  as `italic`, `` `code` `` as `code`, `[text](url)` as `text`, `~~strike~~`
  strike-styled. Asterisks/backticks/brackets vanish. **Decision: keep
  `conceallevel=0`** (override LazyVim's 2).
- `[x]` **24.** `scrolloff = 10`, `sidescrolloff = 5`
- `[x]` **25.** `timeoutlen = 500`. **What it controls:** max wait (ms) for next
  key in a mapped sequence. After leader `<Space>`, nvim waits `timeoutlen` ms;
  if nothing arrives, partial sequence times out. Lower = snappier feedback,
  higher = more time to type multi-key sequences. LazyVim default is 300ms
  (faster); user prefers 500ms.
- `[x]` **26.** `undolevels = 10000` keep (matches LazyVim, can drop the
  override line)
- `[x]` **27.** `modeline = false`. **What it is:** `vim:` directives in
  first/last few lines of files (e.g. `# vim: set sw=4 ts=4 :`) get applied as
  buffer-local options. Disabled because (a) trusted-input security history
  (CVEs from arbitrary option execution), (b) editorconfig/vim-sleuth handle
  this better, (c) editor settings shouldn't leak into source files.
- `[x]` **28.** `virtualedit = 'block'` keep explicit
- `[x]` **29.** `wildmode = 'longest:full,full'` keep explicit
- `[x]` **30.** `confirm = false` keep -- user prefers explicit `:q!` over the
  prompt. With `confirm=true`, `:q` on unsaved buffer pops "Save changes?
  [Y]es,[N]o,[C]ancel"; with `false`, `:q` errors
  `E37: No write since last change` and you must `:q!` or `:w`. Override
  LazyVim's default.
- `[x]` **31.** `relativenumber = false`. Toggle binding `<leader>uL` exists in
  LazyVim.

---

## B. Probably Port

- `[x]` **32.** vim-pasta -- port. **What it does:** indent-aware paste only.
  Replaces `p`/`P` with smart variants that re-indent pasted text to match
  destination's indent. Disable list (python/coffee/yaml/markdown/slim) is
  correct -- in whitespace-significant formats, indent-aware paste does the
  wrong thing (changes block indent breaks scope/structure). Keep all five
  disables.
- `[x]` **33.** todo-comments QUESTION keyword + highlight tweaks (`before=''`,
  `keyword='bg'`, `after='fg'`)
- `[x]` **34.** autocmd: trim trailing whitespace on save (LazyVim doesn't ship)
- `[x]` **35.** autocmd: `close_with_q` extra filetypes. **What it is:** on
  `FileType` for helper buffers (help, qf, lspinfo, man, notify, checkhealth,
  dap-\* etc.), set buffer-local `nmap q :close<CR>`. LazyVim ships this autocmd
  by default; user adds `snacks_notif`, `snacks_notif_history`,
  `gitsigns-blame`, `grug-far` to the filetype list.
- `[x]` **36.** autocmd: `wrap_spell` extra filetypes (text, plaintex, typst
  beyond LazyVim's markdown/gitcommit). **What `wrap` does:** buffer-local; long
  lines visually wrap to next screen line instead of running off-screen. Doesn't
  insert real newlines, just display. Combined with `linebreak`, breaks at word
  boundaries. Useful for prose where lines have no hard wrap.
- `[x]` **37.** gitsigns `update_debounce = 500` -- keep user's 500ms override.
  User doesn't want frequent gutter recomputes.
- `[-]` **38.** bufferline pin keys -- **already in LazyVim defaults**.
  `<leader>bp` (TogglePin) and `<leader>bP` (close ungrouped) are in
  `lazyvim/plugins/ui.lua` lines 8-9. Plus LazyVim adds `<leader>br` (close
  right), `<leader>bl` (close left), `<leader>bj` (BufferLinePick). Skip; you
  get these for free.
- `[x]` **39.** DAP via `lazyvim.plugins.extras.dap.core` + delve. **DAP** =
  Debug Adapter Protocol, vendor-neutral protocol (Microsoft) for
  editor↔debugger comms; nvim-dap is the client. **delve** = Go debugger
  backend. User had F1 step-into / F2 step-over / F3 step-out / F5 continue / F7
  toggle UI / `<leader>db` toggle bp / `<leader>dB` conditional bp. LazyVim's
  extra uses `<leader>d*` for everything; F-keys don't carry over by default.

---

## C. Skip (LazyVim default sufficient)

- `[-]` **40.** `telescope.lua` -- LazyVim 15.x uses snacks.picker; equivalent
  commands at `<leader>ff/fg/fr/sg/sw/sd/sr/...`. **Trade-off:** telescope has
  hundreds of community extensions (frecency, project, undo, gh,
  telescope-ui-select, telescope-fzf-native); snacks.picker has only what's
  built into snacks. Snacks faster on huge result sets, simpler/opinionated. Use
  telescope if you rely on community extensions.
- `[-]` **41.** `neo-tree.lua` -- skip, snacks.explorer used instead (D60
  resolved)
- `[-]` **42.** `flash.lua` -- opts/keys identical to LazyVim default. **What
  flash does:** enhanced jump motions. `s` jump (type chars, labels appear,
  press label to jump), `S` treesitter select (expand to TS node), `r` remote
  flash (jump+operate at remote location, `yr` yank remote), `R` treesitter
  search.
- `[-]` **43.** `trouble.lua` -- user's keys match LazyVim default. **User's
  keys:** `<leader>xx` diagnostics, `<leader>xX` buffer diagnostics,
  `<leader>cs` symbols, `<leader>cS` LSP refs, `<leader>xL` loclist,
  `<leader>xQ` qflist.
- `[-]` **44.** `lualine.lua` -- LazyVim default is feature-richer.
  **Difference:** user has
  globalstatus/disabled-on-dashboard/branch+diagnostics+filename(rel)/diff+filetype/progress/location.
  LazyVim adds `root_dir` component, pretty path with icons,
  noice/recording-macro indicators, dap status, lazy update count.
- `[-]` **45.** `mini-icons.lua` -- LazyVim ships mini.icons default with same
  web-devicons mock. Drop.
- `[-]` **46.** `persistence.lua` -- user's keys identical to LazyVim default
  (`<leader>qs` load, `<leader>qS` select, `<leader>ql` last, `<leader>qd`
  stop).
- `[-]` **47.** Mason wiring (mason-tool-installer, fidget.nvim) -- LazyVim has
  equivalents. Only `ensure_installed` content matters (item 7). **Re
  duplication:** Mason `ensure_installed` is `opts_extend`-ed in LazyVim, so
  duplicates merge harmlessly. Fine to restate vtsls etc. for explicit safety,
  but not necessary.
- `[-]` **48.** `bufferline.lua` core -- user's keys (`<S-h>` prev, `<S-l>`
  next, `[b` prev, `]b` next) are LazyVim defaults. Only items 38 are unique.
- `[-]` **49.** `grug-far.lua` -- `<leader>sR` matches default. **What grug-far
  does:** project-wide search-and-replace UI. Opens a buffer where you type
  pattern + replacement + glob, see all matches with context inline, edit
  results in-place, `:w` to apply across files. ripgrep-backed, supports
  regex/literal/case modes.
- `[-]` **50.** `gitsigns.lua` core -- only items 37 (debounce) and `<leader>h*`
  vs `<leader>gh*` (D63) are user-specific
- `[-]` **51.** `blink.cmp.lua` -- LazyVim defaults match user's preferences
  (`documentation.auto_show=false`, `fuzzy.implementation='lua'`, sources
  `lsp/path/snippets/lazydev`)
- `[-]` **52.** lazydev plugin spec -- **What it does:** replaces
  neodev/lua-dev. Configures lua_ls workspace dynamically when editing Neovim
  Lua: adds `vim.*` runtime types and plugin source paths, on demand. Result:
  full completion/hover/go-to-def for `vim.api.*`, plugin module symbols.
  ft='lua' gated. LazyVim ships it default. Drop user's spec.
- `[-]` **53.** mini.{ai,surround,pairs} -- LazyVim ships all three default.
  - **mini.ai:** extended text objects -- `va)`, `yi"`, `cin'` (next/last
    variants `an`/`al`/`in`/`il`), supports treesitter targets, function args,
    etc.
  - **mini.surround:** add/delete/replace surroundings -- `saiw)` add parens
    around word, `sd"` delete quotes, `sr)'` replace parens with quotes.
  - **mini.pairs:** minimal autopair -- `(`->`()`, `"`->`""`, `<CR>`
    smart-newlines. Lightweight vs nvim-autopairs.
- `[-]` **54.** ts-comments and vim-sleuth -- LazyVim defaults.
  - **ts-comments:** fixes `commentstring` for embedded languages via
    treesitter. E.g. `<style>` block in HTML uses `/* */`, `<script>` uses `//`.
    Pairs with built-in `gc`/`gcc` (Neovim 0.10+).
  - **vim-sleuth:** auto-detects `tabstop`, `shiftwidth`, `expandtab` from file
    contents on open. Heuristic, no editorconfig needed.
- `[-]` **55.** mason-tool-installer wiring (only ensure_installed content
  matters)
- `[-]` **56.** snacks.lua opts (LazyVim already enables
  bigfile/dashboard/indent/notifier/scratch/words; user's `terminal=false` is
  moot since toggleterm runs alongside fine)
- `[-]` **57.** which-key group customizations -- mostly overlap with LazyVim
  defaults. **Conflicts:** user's `<leader>t Toggle` collides with LazyVim's
  `<leader>t` (terminal/tabs context); user's `<leader>h Git Hunk` differs from
  LazyVim's `<leader>gh`. Both addressed in D-section. Other groups (`b`, `c`,
  `d`, `q`, `s`, `u`, `x`) match.
- `[-]` **58.** autocmds LazyVim already ships (highlight-yank, last_loc,
  auto_create_dir, checktime, resize_splits)

---

## D. Decisions

- `[x]` **59.** Search/find keymap layout -- **kickstart `<leader>s*`**. LazyVim
  splits `<leader>f*` for files/recent/buffers + `<leader>s*` for
  grep/symbols/diag; kickstart unifies under `<leader>s*` (sf files, sg grep, sw
  word, sd diag, sr resume, s. recent, sn nvim config, sh help, sk keymaps, s/
  buffer fuzzy). **Work needed:** ~20-30 remappings in a single override file.
  Disable LazyVim's `<leader>f*` mappings, remap to `<leader>s*`. Cleanest via
  `keys = function() return {...} end` returning the kickstart-style table.

- `[x]` **60.** File tree -- **snacks.explorer at LazyVim default `<leader>e`**
  (root) and `<leader>E` (cwd). Drop neo-tree. Snacks supports hidden/gitignored
  toggling: `H` toggles hidden, `I` toggles gitignored (in the explorer);
  `<A-h>`/`<A-i>` work in pickers more broadly. Defaults hide both; configure
  `opts.picker.sources.explorer = { hidden = true, ignored = true }` to show by
  default if user wants to match old neo-tree `filtered_items.visible = true`
  behavior.

- `[x]` **61.** `<leader>t*` collision -- **almost no collision in practice**.
  LazyVim's `<leader>t*` is only used by `extras.test.core` (neotest), which
  user is not enabling. snacks.terminal lives at `<leader>fT`/`<leader>ft` and
  `<C-/>`/`<C-_>` (hide in t-mode). Plan:
  - Disable snacks.terminal entirely via `opts.terminal = { enabled = false }`
    in user's snacks override (matches old config).
  - Toggleterm owns `<C-/>` (matches user's old binding) and `<leader>t*` for
    REPLs/lazygit/btm/gdu/send.
  - LazyVim's `<leader>fT`/`<leader>ft` will simply be unbound (snacks.terminal
    disabled) -- no need to actively disable them.
  - If `extras.test.core` ever enabled later, move toggleterm to `<leader>T*`.

- `[x]` **62.** `<leader>th` inlay hints -- **resolved per item 112**: stays at
  `<leader>uh` (LazyVim convention, matches user's adopted `<leader>u*`
  UI-toggles cluster from D65).

- `[x]` **63.** Git hunks prefix -- **kickstart default is `<leader>h*`**.
  Gitsigns' own defaults inside `on_attach` use `<leader>h*` (hs/hr/hp/hb);
  kickstart preserves that. LazyVim moved them to `<leader>gh*`
  (ghs/ghr/ghp/ghb). **User keeps `<leader>h*`** (matches gitsigns/kickstart).

- `[x]` **64.** Format-on-save scope -- **lua only**, per user's existing setup.
  Both implementations respect `vim.g.autoformat`. Override conform's
  `format_on_save` to gate on `vim.bo.filetype == 'lua'`.

- `[x]` **65.** UI toggle cluster (`<leader>u*`) -- **drop user's, use LazyVim's
  `Snacks.toggle.*` set**. **Comparison:** | User's | LazyVim's Snacks.toggle |
  |---|---| | uf format | uf format (buffer), uF format (global) | | us spell |
  us spell | | uw wrap | uw wrap | | ul numbers | ul numbers | | uL relnum | uL
  relnum | | ud diagnostics | ud diagnostics | | uh inlay hints | uh inlay hints
  | | ug indent guides | ug indent guides | | (none) | uc conceallevel, uA
  animations, ub bg dark/light, uT treesitter, ut tabline, uS smoothscroll,
  uz/uZ zen/zoom |

  LazyVim's is a strict superset + nicer notifications via Snacks.notifier.
  Saves ~40 lines.

- `[x]` **66.** `relativenumber` -- **off** (item 31)

- `[x]` **67.** `clipboard` -- **explicit `<leader>y`** (item 21)

- `[x]` **68.** `conceallevel` -- **0**, no prettier rendering (item 23)

- `[x]` **69.** `colorcolumn` -- **off for now** (item 22)

- `[x]` **70.** `timeoutlen` -- **500** (item 25)

- `[x]` **71.** `spell` -- enable globally (`vim.opt.spell = true`,
  `vim.opt.spelllang = 'en'`). Treesitter `@spell` capture in highlight queries
  scopes spell-check to comments/strings only; code identifiers/keywords/types
  are NOT flagged. Major language parsers (lua, python, ts/js, rust, go, c,
  java) all have `@spell` queries. LazyVim's prose-filetype autocmd becomes
  redundant but harmless.

---

## E. Additional kickstart-style overrides

- `[x]` **72.** LSP keymaps -- **kickstart-style**. Restore Neovim 0.11 `gr*`
  defaults plus kickstart additions:
  - `grn` rename (replaces LazyVim's `<leader>cr`)
  - `gra` code action (replaces `<leader>ca`)
  - `grr` references (replaces `gr`)
  - `gri` implementation (replaces `gI`)
  - `grd` definition via telescope/snacks picker (replaces `gd`)
  - `grD` declaration (replaces `gD`)
  - `grt` type definition (replaces `gy`)
  - `gW` workspace symbols (replaces `<leader>sS`)
  - `gO` document symbols (already matches both)

  Implementation: in keymap-overrides plugin spec, disable LazyVim's
  `gr/gI/gd/gy/gD/<leader>cr/<leader>ca` keys (set `lhs = false`), then add the
  kickstart `gr*` series in `lspconfig.opts.servers["*"].keys` so they only fire
  when an LSP is attached.

- `[x]` **73.** `<leader>f` format buffer -- **kickstart-style**. Bind
  `<leader>f` (n/v) to `require('conform').format({ async = true })`. Collides
  with LazyVim's `<leader>f*` find/file group prefix; since D59 remaps the
  `<leader>f*` subkeys to `<leader>s*` anyway, the bare `<leader>f` is freed up
  cleanly for format.

- `[x]` **74.** Terminal `<Esc><Esc>` -- exit terminal mode (kickstart). Already
  in keymaps.lua port; restated here for completeness.

- `[x]` **75.** `<leader>q` bare key -- **kickstart-style**: bind to
  `vim.diagnostic.setloclist` (open diagnostic loclist). `<leader>qq` dropped.
  Session keys move to `<leader>Q*` (capital Q): `Qs` restore, `QS` pick, `Ql`
  last, `Qd` stop.

---

## F. Keybind decisions (from comparison walk-through)

Detailed reference table at `~/.config/doc/nvim-keybinds-comparison.md`. This
section captures override/disable/add decisions per group.

### Top-level / non-leader

- `[x]` **76.** `n`/`N` -- override LazyVim's direction-aware-with-center remap,
  restore vim default (search direction is preserved).
- `[x]` **77.** `<C-s>` save -- drop LazyVim's `:w` binding in n/i/x/s modes.
  Avoids XOFF collision and unintentional saves. (LSP signature_help on `<C-s>`
  in insert mode via Neovim 0.11 LspAttach default is unaffected -- different
  binding mechanism.)
- `[x]` **78.** `K` -- override LazyVim's explicit `vim.lsp.buf.hover()`.
  Restore vim default behavior so `K` falls through to `keywordprg` (man page)
  outside LSP, hover when LSP attached. Functionally similar but lets non-LSP
  buffers behave normally.
- `[x]` **79.** `gK` -- override LazyVim's signature_help binding, unmap.
- `[x]` **80.** `<C-k>` (insert mode) -- override LazyVim's signature_help
  binding, unmap (digraph entry restored as vim default). Note: `<C-s>` insert
  in 0.11+ LSP attach already provides signature help.
- `[x]` **81.** Keep all other LazyVim defaults: `<Esc>` clear hl + stop
  snippet, `j/k <Down>/<Up>` visual-line aware, `<S-h>/<S-l>` buffer cycle,
  `<C-Up/Down/Left/Right>` window resize, `<A-j>/<A-k>` move lines,
  `<C-f>/<C-b>` scroll noice docs / fall through, `<C-Space>` flash treesitter,
  `<S-Enter>` cmdline noice redirect, `<C-_>` (terminal mode unbound after
  snacks.terminal disabled), `gx`, `gq`/`gw`.

### Brackets `[` / `]`

- `[x]` **82.** Keep all LazyVim defaults: `[d`/`]d` (with float + count),
  `[e`/`]e`/`[w`/`]w` severity-filtered, `[q`/`]q` quickfix, `[b`/`]b` buffer
  cycle, `[B`/`]B` move buffer, `[h`/`]h`/`[H`/`]H` hunks, `[t`/`]t`
  todo-comments, `[c`/`]c` diff/hunk default, `[[`/`]]` snacks.words reference
  next/prev, `[s`/`]s` spell, `[m`/`]m` method, ts-textobjects family
  `[f`/`]f`/`[F`/`]F`/`[C`/`]C`/`[a`/`]a`/`[A`/`]A`.

### `g*` (LSP / commenting / surround)

- `[x]` **83.** Disable LazyVim's two-letter LSP keys: `gd`, `gD`, `gr`, `gI`,
  `gy`. Per D72, kickstart uses `gr*` family.
- `[x]` **84.** Add kickstart-style LSP keys via
  `lspconfig.opts.servers["*"].keys` (only fire when LSP attached): `grn`
  rename, `gra` action, `grr` refs (snacks picker), `gri` impl (snacks picker),
  `grd` def (snacks picker), `grD` decl, `grt` type def (snacks picker), `gW`
  workspace symbols (snacks picker).
- `[x]` **85.** `<leader>cA` source action -- move to `grA` (capital A; fits
  gr\* "operate on symbol under cursor" pattern).
- `[x]` **86.** `<leader>co` organize imports -- move to `grO` (capital O; same
  pattern).
- `[x]` **87.** Keep LazyVim defaults: `gc/gcc` toggle comment (vim built-in),
  `gco/gcO` add comment line below/above, `gO` document symbols, `gai` incoming
  calls, `gao` outgoing calls, `gs*` mini.surround group, `<a-n>`/`<a-p>`
  snacks.words cycle.

### `<leader>` top-level bare keys

- `[x]` **88.** Drop `<leader><space>` (find files) -- redundant with restored
  kickstart `<leader>sf`.
- `[x]` **89.** Add `<leader><leader>` -- buffers picker (snacks). Restore
  kickstart pattern.
- `[x]` **90.** Drop `<leader>,` -- redundant with `<leader><leader>`.
- `[x]` **91.** Drop `<leader>:` -- use vim's built-in `q:` for command-line
  history window instead.
- `[x]` **92.** Override `<leader>/` -- kickstart-style buffer-line fuzzy find
  via `Snacks.picker.lines()`. Replaces LazyVim's "live grep root".
- `[x]` **93.** Drop `<leader>K` (force keywordprg) -- redundant since item 78
  restores vim default `K`.
- `[x]` **94.** Drop `<leader>-` and `<leader>|` (split window) -- use `:sp` and
  `:vs` directly.
- `[x]` **95.** Add `<leader>F` -- format injected (moved from `<leader>cF`).
  Capital F variant of `<leader>f` matches LazyVim's "extended" convention.
- `[x]` **96.** Keep LazyVim defaults: `` <leader>` `` alternate file,
  `<leader>e/E` explorer (D60), `<leader>L` changelog, `<leader>l` `:Lazy`,
  `<leader>n` notification history, `<leader>?` keymap panel, `<leader>S`
  scratch select, `<leader>.` toggle scratch.

### `<leader>b*` (buffer)

- `[x]` **97.** Drop `<leader>bb` (alternate buffer) -- redundant with
  `` <leader>` `` and `<C-^>`.
- `[x]` **98.** Keep all other LazyVim defaults: `bd` (preserve window), `bD`
  (close window), `bo` (delete others), `bi` (delete invisible), `bp`/`bP` (pin
  / close non-pinned), `br`/`bl` (close right/left), `bj` (bufferline picker).

### `<leader>c*` (code)

- `[x]` **99.** `<leader>c*` post-consolidation set: `cc` run codelens, `cC`
  refresh codelens, `cd` line diagnostic float, `cl` LSP info, `cm` `:Mason`,
  `cR` rename file, `cs` Trouble symbols, `cS` Trouble LSP refs/defs. Removed:
  `ca`/`cA`/`cf`/`cF`/`co`/`cr` (moved per items 73, 85, 86, 95, and D72). Group
  prefix-meaning revisit deferred to end of migration.

### `<leader>d*` (debug)

- `[x]` **100.** Keep both F-keys AND `<leader>d*` set:
  - `<F5>` continue, `<F1>` step into, `<F2>` step over, `<F3>` step out, `<F7>`
    toggle UI (kickstart-style port from mvim)
  - `<leader>d*` full LazyVim DAP set: `db`/`dB` (breakpoint/conditional,
    replaces kickstart's bare `<leader>b/B` that conflicts with buffer prefix),
    `dc` continue, `dC` run-to-cursor, `dg` go-to-line, `di` step into, `dj/dk`
    stack frame down/up, `dl` run last, `do/dO` step out / over, `dp` pause,
    `dr` REPL, `ds` session, `dt` terminate, `dw` widgets, `du` toggle UI, `de`
    eval, `dpp/dph/dps` snacks profiler.
  - Drop kickstart's bare `<leader>b/B` for breakpoints (collides with
    `<leader>b*` buffer group).

### `<leader>f*` (file/find) -- ABSORBED into `<leader>s*`

- `[x]` **101.** Disable all LazyVim `<leader>f*` keys
  (`ff/fF/fr/fR/fb/fB/fc/fp/fn/fg/fe/fE/ft/fT`). Kickstart uses unified
  `<leader>s*` for both file-finding and content-searching. The bare `<leader>f`
  is reused for format (item 73). `<leader>F` is format injected (item 95).
  `<leader>e/E` already host the explorer (D60).
- `[x]` **102.** Move `<leader>fc` find config file -> `<leader>sn`
  (kickstart-style). Disables LazyVim's noice `<leader>sn*` subgroup (item 105).
- `[x]` **103.** Drop `<leader>fp` projects, `<leader>fn` new file, `<leader>fg`
  git files. Re-add later if missed.

### `<leader>s*` (search) -- restored kickstart-style

- `[x]` **104.** Add kickstart-style top-level keys: `s.` recent files
  (oldfiles), `s/` grep across open files, `sf` find files, `sg` live grep root,
  `sh` help tags, `sk` keymaps, `sn` nvim config files (item 102), `sr` resume
  last picker, `sw` grep word root, `sd` diagnostics. All via `Snacks.picker.*`.
- `[x]` **105.** Resolve conflicts with LazyVim's `<leader>s*`:
  - `<leader>sr` -- kickstart wins (resume), drop LazyVim's `<leader>sR` rebind
    (was the "resume last" alias).
  - `<leader>sn` -- kickstart wins (config files), drop LazyVim's noice subgroup
    `<leader>sn[lhadt]`.
  - `<leader>s/` -- kickstart wins (grep open files), drop LazyVim's search
    history binding.
  - `<leader>ss` -- LSP doc symbols moved to `gO` (item 87) so this key is
    freed; leave unbound.
- `[x]` **106.** Keep LazyVim-only `<leader>s*` keys (no kickstart equivalent,
  all useful or low-cost):
  - Keep: `sa` autocmds, `sb` buffer lines, `sB` grep open buffers, `sc` command
    history, `sC` commands, `sD` buffer diagnostics, `sG` live grep cwd, `sH`
    highlights, `si` icons, `sj` jumps, `sl` loclist, `sm` marks, `sM` man
    pages, `sp` plugin spec, `sq` quickfix, `sS` LSP workspace symbols
    (redundant with `gW`), `st` todo, `sT` todo+fix+fixme, `su` undotree, `sW`
    grep word cwd, `s"` registers.

### `<leader>g*` (git)

- `[x]` **107.** Keep all LazyVim defaults: `gg`/`gG` lazygit, `gb` blame line,
  `gB` browse open, `gY` browse copy URL, `gd` diff vs HEAD, `gD` diff vs
  origin/HEAD, `gf` file history, `gl`/`gL` log, `gs` status, `gS` stash. (Per
  D63, hunks moved out of `<leader>gh*` to `<leader>h*`.)

### `<leader>h*` (hunks)

- `[x]` **108.** Move hunks to `<leader>h*` per D63. Set: `hs` stage, `hr`
  reset, `hS` stage buffer, `hR` reset buffer, `hu` undo stage, `hp` preview,
  `hb` blame full, `hB` blame buffer toggle, `hd` diff HEAD, `hD` diff HEAD~1,
  `htd` toggle deleted, `htb` toggle current-line blame. Implementation: disable
  LazyVim's `<leader>gh*` keys, add `<leader>h*` mappings via gitsigns
  `on_attach`, label group as "git hunks" via which-key.

### `<leader>q*` and `<leader>Q*` (diagnostic / session)

- `[x]` **109.** Per item 75: `<leader>q` -> `vim.diagnostic.setloclist`,
  `<leader>qq` dropped, sessions move to `<leader>Q*`: `Qs` restore, `QS` pick,
  `Ql` last, `Qd` stop.

### `<leader>t*` -- frees up; `<leader>T*` for terminal

- `[x]` **110.** Move toggleterm bindings to `<leader>T*` (capital T): `Tf`
  float, `TH` horizontal, `Tv` vertical, `Tn` Node REPL, `Tp` Python3 REPL, `Tl`
  lazygit, `Tt` btm, `Tu` gdu, `Ts` send line/visual. `<C-/>` and `<C-'>` remain
  at lowercase for primary float toggle (no shift cost). Frees `<leader>t*` for
  kickstart's "Toggle" semantic if user adopts it later, or for
  `extras.test.core` (neotest) if enabled.
- `[x]` **111.** `<leader>t*` left empty. If `extras.test.core` is enabled
  later, neotest claims it cleanly without conflicts.

### `<leader>u*` (UI toggles)

- `[x]` **112.** Adopt all LazyVim defaults wholesale (per D65). Set: `uf`/`uF`
  format buffer/global, `us` spell, `uw` wrap, `ul`/`uL` numbers/relnum, `ud`
  diagnostics, `uh` inlay hints (D62 finalized here), `ug` indent guides, `uc`
  conceallevel cycle, `uA` tabline, `uT` treesitter highlight, `uD` dim, `ua`
  animations, `uS` smoothscroll, `uG` gitsigns gutter, `un` dismiss
  notifications, `ui`/`uI` inspect position/treesitter, `uz`/`uZ` zen/zoom, `uC`
  colorscheme picker, `ub` background dark/light, `ur` redraw.
- `[x]` **113.** Set `vim.g.snacks_animate = false` in `lua/config/options.lua`
  -- animations off by default. Other snacks flags (`snacks_indent`,
  `snacks_scroll`, `snacks_dim`) left at defaults; can flip later.

### `<leader>w*` (windows)

- `[x]` **114.** Keep LazyVim's `<C-w>` -> `<leader>w` proxy. `<leader>wd`
  delete, `<leader>wm` zoom, `<C-w><Space>` hydra. (`<leader>-`/`<leader>|`
  already dropped per item 94.)

### `<leader>x*` (diagnostics/quickfix)

- `[x]` **115.** Keep all LazyVim defaults: `xx` Trouble diagnostics, `xX`
  buffer diagnostics, `xL`/`xQ` Trouble loclist/qflist, `xl`/`xq` toggle native
  loclist/quickfix windows, `xt`/`xT` Trouble todo / todo+fixme.

### `<leader><Tab>*` (tabs)

- `[x]` **116.** Keep all LazyVim defaults (may not actively use): `<Tab><Tab>`
  new tab, `<Tab>l` last, `<Tab>f` first, `<Tab>]` next, `<Tab>[` prev, `<Tab>d`
  close, `<Tab>o` close others. **Followup discussion deferred:** tabs vs
  buffers vs marks/jumplist navigation patterns.

### Insert mode

- `[x]` **117.** `,`/`.`/`;` undo break-points (LazyVim default + mvim default,
  keep). Vim default `<C-h>` (delete word back), `<C-k>` (digraph) preserved per
  item 80. `<A-j>/<A-k>` move line down/up (LazyVim default, keep). `<C-s>` save
  dropped per item 77. `<C-f>/<C-b>` scroll noice popup if visible (LazyVim
  default, keep).

### Terminal mode

- `[x]` **118.** `<Esc><Esc>` exit terminal (item 74). `<C-/>`/`<C-'>`
  toggleterm (item 110). `<C-hjkl>` nav out (toggleterm + vim-tmux-navigator).
  LazyVim's `<C-_>` snacks-terminal alias unbound after snacks.terminal
  disabled.

### Visual / visual-block

- `[x]` **119.**
  `</`>`keep selection after indent (item 15, matches LazyVim default).`j/k
  <Down>/<Up>`wrap-aware (LazyVim default).`n/N`direction-preserving per item 76.`p`paste-and-reyank (item 16, override vim default).`s/S/r/R`
  flash bindings (LazyVim default).

---

## Open Questions Summary

All decisions resolved. No open items.

- **3** -- toggleterm: full port to `<leader>T*` per item 110, `<C-/>` and
  `<C-'>` retained.
- **6** -- vtsls custom settings: confirmed identical to LazyVim's
  `extras.lang.typescript.vtsls` defaults. **No override needed** -- enabling
  the extra reproduces user's mvim settings exactly, plus adds TS-specific keys
  (`gD` source def, `gR` file refs, `<leader>cM` add missing imports,
  `<leader>cD` fix-all, `<leader>cV` TS version). The TS-specific `gD`/`gR` are
  filetype-scoped and coexist with kickstart-style global `gr*` family.
- **7** -- python: basedpyright + ruff (LazyVim's `extras.lang.python` default).
  Typescript: vtsls + eslint (LazyVim's `extras.lang.typescript` default). No
  overrides.
- **32** -- vim-pasta: port with disable list (python, coffee, yaml, markdown,
  slim).
- **62** -- inlay hints: `<leader>uh` (LazyVim convention, finalized via item
  112).

---

## Implementation Plan (after decisions resolved)

Once decisions above are locked, work proceeds in this order. Architectural
notes:

- **Options** -> `lua/config/options.lua` (loaded BEFORE plugins, what LazyVim
  expects)
- **New keymaps** -> `lua/config/keymaps.lua`
- **Overrides of LazyVim's GLOBAL keymaps** (defined in
  `lazyvim/config/keymaps.lua`) -> `lua/config/keymaps.lua` via `vim.keymap.set`
  (replace) or `vim.keymap.del` (remove). User's file loads AFTER LazyVim's, so
  overrides win.
- **Overrides of plugin-attached keymaps** (defined in `keys = {}` of a plugin
  spec) -> the relevant plugin spec file with `keys = { { "lhs", false } }`
  (disable) or new `keys = { ... }` (replace).

NO consolidated `lua/plugins/keymap-overrides.lua` mega-file -- it would
mis-architect by mixing global and plugin keys.

### Files to create/modify

1. **`lua/config/options.lua`** -- option overrides (items 20-31 minus closed) +
   `vim.g.snacks_animate = false` (item 113) +
   `vim.opt.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"` (item 9; replaces
   mvim's `util/fold.lua` which is DROPPED).
2. **`lua/config/keymaps.lua`** -- contains:
   - Personal new keymaps (items 10-18). Skip undo breakpoints (item 19) --
     LazyVim has them.
   - LazyVim global keymap overrides via `del`/`set`: `<C-s>` save (#77), `K`
     (#78), `gK` (#79), `<C-k>` insert (#80), `n`/`N` direction (#76),
     `<leader>K` (#93), `<leader>:` (#91), `<leader>,` (#90), `<leader><space>`
     (#88), `<leader>-`/`<leader>|` (#94), `<leader>cf` (D73 -> bare
     `<leader>f`), `<leader>fn` (drop new file binding),
     `<leader>fT`/`<leader>ft`/`<C-/>`/`<C-_>` snacks-terminal globals (D61 +
     #110), `<leader>qq` (#109), `<leader>bb` (#97).
   - Kickstart-style additions: `<leader>q` diagnostic loclist (#75),
     `<leader><leader>` buffers picker (#89), `<leader>/` buffer-line fuzzy
     (#92), `<leader>f` format buffer (#73), `<leader>F` format injected (#95),
     `<leader>s.` recent (#104), `<leader>s/` grep open files (#104),
     `<leader>sf` find files (#104), `<leader>sg` live grep root (#104),
     `<leader>sh` help tags (#104), `<leader>sk` keymaps (#104), `<leader>sn`
     nvim config files (#102, #104), `<leader>sr` resume picker (#104),
     `<leader>sw` grep word root (#104), `<leader>sd` diagnostics (#104).
   - Visual `p` paste-and-reyank (#16), terminal `<Esc><Esc>` (#74).
3. **`lua/config/autocmds.lua`** -- ONLY trim-trailing-whitespace (#34). LazyVim
   already has identical `wrap_spell` (#36 dropped) and equivalent
   `close_with_q` for relevant filetypes (#35 dropped: man/snacks_notif/trouble
   are handled internally).
4. **`lua/plugins/colorscheme.lua`** -- wildcharm override (#5), disable
   tokyonight + catppuccin.
5. **`lua/plugins/auto-dark-mode.lua`** -- (#2).
6. **`lua/plugins/tmux-nav.lua`** -- vim-tmux-navigator (#1).
7. **`lua/plugins/toggleterm.lua`** -- full mvim port retargeted to `<leader>T*`
   (#3, #110).
8. **`lua/plugins/vim-pasta.lua`** -- with disable list (#32).
9. **`lua/plugins/lsp.lua`** -- consolidated:
   - Language extras enabled: typescript, python, json, yaml, markdown, java,
     dap.core (#7, #39).
   - Manual mason `ensure_installed` for what extras don't cover (#7).
   - Kickstart-style LSP keymaps via `lspconfig.opts.servers["*"].keys` (#84).
     Disable LazyVim's two-letter LSP keys (#83) and `<leader>c*` LSP keys
     consolidated to `gr*` family (#85, #86, item 99).
10. **`lua/plugins/gitsigns.lua`** -- Approach B (wrap on_attach),
    `update_debounce = 500` (#37, #108).
11. **`lua/plugins/snacks.lua`** -- `terminal = { enabled = false }` (D61),
    `animate = { enabled = false }` (alongside `vim.g.snacks_animate`), explorer
    hidden/ignored config (D60). Plus override snacks_picker keys: disable
    `<leader>ff/fF/fr/fR/fb/fB/fc/fp/fg` (item 101).
12. **`lua/plugins/persistence.lua`** -- session key remap from `<leader>q*` to
    `<leader>Q*` (#75 part 2).
13. **`lua/plugins/noice.lua`** -- disable noice `<leader>sn[lhadt]` subgroup so
    `<leader>sn` free for kickstart's nvim-config-files (#105).
14. **`lua/plugins/dap.lua`** -- F-key bindings via `keys = {}` attached to
    nvim-dap and nvim-dap-ui (#100).
15. **`lua/plugins/todo-comments.lua`** -- full mvim opts:
    `keywords.QUESTION = { icon = '?', color = '#d70087' }`,
    `merge_keywords = true`, custom
    `highlight = { before = '', keyword = 'bg', after = 'fg', pattern = [[.*<((KEYWORDS):?)\s*]] }`,
    `signs = true` (#33).
16. **`lua/plugins/example.lua`** -- DELETE.

### External setup

- `brew install lazygit` (per init checkout findings).
- `brew install fd` (optional but recommended; faster pickers).

### Final sanity pass

- `:checkhealth lazyvim`
- Open a TS file, verify vtsls + extras keys work (`gD` source def, `<leader>cM`
  add missing imports)
- Open a python file, verify basedpyright + ruff
- Verify `<leader>sf` finds files, `<leader><leader>` switches buffer
- Verify `<C-/>` opens toggleterm float (NOT snacks.terminal)
- Verify `<C-hjkl>` navigates across vim splits + into tmux pane
- Verify dark mode follows OS toggle
- Verify `gr[nadrtDi]` LSP keys fire when LSP attached
- Verify `<leader>h*` hunks work, `<leader>gh*` does NOT (was disabled)
- Verify `<F5>` starts DAP after `extras.dap.core` loaded a session
- Verify spell checker only flags errors in comments/strings (TS @spell scoping)

After implementation, commit in stages so individual changes can be reverted if
they break something.

---

## Deferred discussions

- **markdownlint config location** (originally item 8): nvim-lint's
  `markdownlint` linter looks at `.markdownlint.{jsonc,json,yaml,yml,cjs}`
  walking up from the file's directory. Currently your config lives at
  `$XDG_CONFIG_HOME/markdownlint/config.json` and mvim passed it via `--config`
  flag. For the migration, keep using `--config` flag in `lint.lua` opts to
  preserve XDG location. Decide later whether to (a) keep `--config` flag
  forever, (b) move config to `.markdownlint.jsonc` per-repo, (c) symlink to
  `~/.markdownlint.jsonc` (pollutes home, user dislikes). Reference: file at
  `~/.config/markdownlint/config.json`.
- **Prefix-meaning audit (final pass)** -- after migration is implemented, walk
  through `<leader>` group prefixes and confirm semantic consistency: c (code),
  b (buffer), d (debug), s (search/find), g (git), h (hunks), Q (session), T
  (terminal), u (UI toggle), w (window), x (diagnostics/quickfix), t (free for
  toggles or test extra). Adjust if any feel off.
- **Tabs vs buffers vs marks/jumplist navigation** -- discuss navigation
  patterns. User historically uses tabs, doesn't use marks/lists actively. Worth
  exploring buffer/split + jumplist + harpoon-style alternatives.
