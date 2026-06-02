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
-- buffers without a parser or folds.scm query. Replaces mvim's
-- `lua/config/util/fold.lua` (LazyVim's implementation is more rigorous).
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

-- Format-on-save: globally disabled by default. The matching FileType
-- autocmd in `lua/config/autocmds.lua` enables it for `lua` buffers via
-- `vim.b.autoformat = true`. Other filetypes can be enabled per-buffer
-- with `<leader>uf` or globally with `<leader>uF`. Migration plan item
-- D64 (lua-only).
vim.g.autoformat = false
