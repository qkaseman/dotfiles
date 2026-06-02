-- Keymaps loaded on the VeryLazy event, after LazyVim's defaults.
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- This file:
-- 1. Adds personal new mappings.
-- 2. Overrides LazyVim's global keymaps via `vim.keymap.set` (replace) or
--    `vim.keymap.del` (remove). Plugin-attached keys are overridden in
--    each plugin's spec file, not here.
-- 3. Adds kickstart-style `<leader>s*` search/find keys.

local map = vim.keymap.set
local del = vim.keymap.del

-- Helper to silently remove a default if present.
local function unmap(mode, lhs)
  pcall(del, mode, lhs)
end

------------------------------------------------------------
-- Personal new mappings
------------------------------------------------------------

-- Make semicolon enter command mode. Skips one shift per command.
map({ 'n', 'v', 'o' }, ';', ':', { silent = false })

-- Disable arrow keys in normal mode to enforce hjkl muscle memory.
for _, k in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
  map('n', k, '<cmd>echo "Use h/j/k/l"<cr>')
end

-- Move windows to far edge in their direction.
map('n', '<C-S-h>', '<C-w>H', { desc = 'Move window far left' })
map('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to bottom' })
map('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to top' })
map('n', '<C-S-l>', '<C-w>L', { desc = 'Move window far right' })

-- Yank to system clipboard explicitly (since `clipboard=""` keeps default
-- yank in the unnamed register).
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', '"+y$', { desc = 'Yank line to system clipboard' })

-- Insert blank line below/above without entering insert mode.
map('n', ']<Space>', "<cmd>call append(line('.'), '')<cr>", { desc = 'Blank line below' })
map('n', '[<Space>', "<cmd>call append(line('.') - 1, '')<cr>", { desc = 'Blank line above' })

-- Visual paste keeps the original yank in the register so you can paste again.
map('x', 'p', 'pgvy', { desc = 'Paste and re-yank' })

-- Easier exit from terminal mode.
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

------------------------------------------------------------
-- Override LazyVim global keymaps
------------------------------------------------------------

-- Restore vim default search direction (LazyVim makes n/N always go down/up
-- regardless of search direction). Vim default preserves the original search
-- direction.
unmap({ 'n', 'x', 'o' }, 'n')
unmap({ 'n', 'x', 'o' }, 'N')

-- Drop save-on-Ctrl-S (XOFF collision risk; saves should be deliberate).
unmap({ 'i', 'x', 'n', 's' }, '<C-s>')

-- Restore vim default `K` (keywordprg outside LSP, hover with LSP attached).
-- LazyVim hard-codes `vim.lsp.buf.hover()` which loses keywordprg fallback.
unmap('n', 'K')

-- Drop signature-help duplicates: `<C-s>` (insert mode, set by 0.11 LSP
-- attach) covers signature help cleanly.
unmap('n', 'gK')
unmap('i', '<C-k>')

-- `<leader>K` was a force-keywordprg escape hatch only needed because
-- LazyVim's `K` overrode the default. With default `K` restored, drop it.
unmap('n', '<leader>K')

-- Drop find-files at top-level (use kickstart `<leader>sf` below instead).
unmap('n', '<leader><space>')

-- Drop buffer picker at `<leader>,`. Kickstart-style at `<leader><leader>`.
unmap('n', '<leader>,')

-- Drop command history at `<leader>:`. Use vim's built-in `q:` instead.
unmap('n', '<leader>:')

-- Drop window-split shortcuts. Use `:sp` and `:vs` directly.
unmap('n', '<leader>-')
unmap('n', '<leader>|')

-- Drop redundant alternate-buffer key. Use `` <leader>` `` (LazyVim default
-- which we keep) or `<C-^>`.
unmap('n', '<leader>bb')

-- Drop format key under code prefix; rebound to bare `<leader>f` below
-- (kickstart-style).
unmap({ 'n', 'x' }, '<leader>cf')

-- Drop new-file shortcut. `:enew` works fine.
unmap('n', '<leader>fn')

-- Drop snacks-terminal launchers and toggles (snacks.terminal disabled in
-- snacks plugin spec; toggleterm handles `<C-/>` and `<C-'>`).
unmap('n', '<leader>fT')
unmap('n', '<leader>ft')
unmap({ 'n', 't' }, '<C-/>')
unmap({ 'n', 't' }, '<C-_>')

-- Drop `<leader>qq` (quit-all). Trivial enough as `:qa`.
unmap('n', '<leader>qq')

------------------------------------------------------------
-- Kickstart-style additions
------------------------------------------------------------

-- Diagnostic loclist: kickstart's `<leader>q` action.
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic loclist' })

-- Buffers picker (kickstart pattern).
map('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = 'Find buffers' })

-- Buffer-line fuzzy find (kickstart's `<leader>/`). LazyVim's default was
-- live grep at root; we use snacks lines picker scoped to current buffer.
map('n', '<leader>/', function() Snacks.picker.lines() end, { desc = 'Search current buffer' })

-- Format buffer (kickstart's `<leader>f`).
map({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ async = true })
end, { desc = 'Format buffer' })

-- Format injected (capital F follows LazyVim's "extended" convention; was at
-- `<leader>cF` in LazyVim).
map({ 'n', 'v' }, '<leader>F', function()
  require('conform').format({ async = true, formatters = { 'injected' } })
end, { desc = 'Format injected languages' })

-- `<leader>s*` search prefix (kickstart-style; absorbs LazyVim's `<leader>f*`
-- find namespace as well as native search).
map('n', '<leader>s.', function() Snacks.picker.recent() end, { desc = 'Recent files' })
map('n', '<leader>s/', function() Snacks.picker.grep_buffers() end, { desc = 'Grep open buffers' })
map('n', '<leader>sf', function() Snacks.picker.files() end, { desc = 'Find files' })
map('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Live grep (root)' })
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help tags' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>sn', function()
  Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Search Neovim config files' })
map({ 'n', 'v' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Grep word (root)' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
-- Resume picker stays at LazyVim's `<leader>sR`; kickstart used lowercase
-- `<leader>sr`. Both work; we add lowercase for muscle memory.
map('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = 'Resume picker' })
