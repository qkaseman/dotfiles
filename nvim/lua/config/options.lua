-- Options are automatically loaded before lazy.nvim startup
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Only overrides and additions live here.

local o = vim.o

-- Spell check: enabled globally, scoped to comments/strings via treesitter
-- @spell capture in highlight queries. LazyVim has it off by default.
o.spell = true
vim.opt.spelllang = { 'en' }

-- Don't sync with system clipboard. Use <leader>y / <leader>Y for explicit
-- system-clipboard yanks (see keymaps.lua). LazyVim defaults to unnamedplus.
o.clipboard = ''

-- No markdown rendering tricks. LazyVim defaults to 2 (hide bold/italic
-- markers, etc.); we keep them visible.
o.conceallevel = 0

-- Larger context window when scrolling. LazyVim uses 4 / 8.
o.scrolloff = 10
o.sidescrolloff = 5

-- More time to type multi-key sequences. LazyVim uses 300.
o.timeoutlen = vim.g.vscode and 1000 or 500

-- Disable modelines for security and to keep editor settings out of source
-- files. editorconfig + vim-sleuth handle per-file indent/etc. better.
o.modeline = false

-- Prefer explicit `:q!` to a confirm dialog when quitting unsaved buffers.
-- LazyVim defaults to true (dialog).
o.confirm = false

-- Absolute line numbers only. LazyVim defaults to relative.
o.relativenumber = false

-- Treesitter-based folds via LazyVim's helper, with `0` fallback for
-- buffers without a parser or folds.scm query.
o.foldmethod = 'expr'
o.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"

-- Explicit even though they match LazyVim defaults (intentional documentation
-- of what we want): allow Visual Block cursor where there is no text, and
-- command-line completion mode.
o.virtualedit = 'block'
o.wildmode = 'longest:full,full'

-- Disable snacks animations globally. Pickers, terminals, and explorers
-- will still work, just without movement animation.
vim.g.snacks_animate = false

-- Format-on-save: globally disabled, no exceptions. LazyVim's auto-format
-- mechanism reads `vim.g.autoformat` (and per-buffer `vim.b.autoformat`).
-- We never set `vim.b.autoformat`, so nothing reformats on save under any
-- circumstance. Manual format via `<leader>f` (kickstart-style) still works.
-- Migration plan item D64 (was originally lua-only; revised to off-entirely
-- per user preference -- never any autoformat).
vim.g.autoformat = false

-- Disable eslint LSP's server-side format-on-save hook. LazyVim's eslint
-- extra (loaded transitively via `lang.typescript`) defaults this to true,
-- which (a) sends `format = true` to the eslint server so it advertises
-- itself as a formatter, and (b) registers `willSaveWaitUntil` inside the
-- LSP framework to run `eslint --fix` before every save. That LSP hook
-- runs INSIDE the LSP framework, NOT through LazyVim's format autocmd, so
-- `vim.g.autoformat = false` doesn't reach it. Disable explicitly.
vim.g.lazyvim_eslint_auto_format = false
