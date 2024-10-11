-- Modes
--  'n' - normal mode
--  'i' - insert mode
--  'v' - visual mode
--  'x' - visual block mode
--  't' - term mode
--  'c' - command mode
--  ''  - equivalent of ':map' (nvo)
--  '!' - equivalent of ':map!'
local opts = { noremap=true, silent=true }

-- Make semicolon into colon, because lazy.
vim.keymap.set('', ';', ':', opts)

-- space is easier than \
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Wrapped lines to go next by default.
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)
vim.keymap.set('n', 'gj', 'j', opts)
vim.keymap.set('n', 'gk', 'k', opts)

-- Clear search highlight.
vim.keymap.set('', '<leader>c', ':noh<CR>', opts)

-- Make 'Y' behave like 'D' and 'C'
vim.keymap.set('n', 'Y', 'y$', opts)

-- Keep paste buffer after pasting once.
vim.keymap.set('x', 'p', 'pgvy', opts)

-- System clipboard integrations.
vim.keymap.set('n', '<leader>p', '"+p', opts)
vim.keymap.set('v', '<leader>p', '"+p', opts)
vim.keymap.set('n', '<leader>P', '"+P', opts)
vim.keymap.set('v', '<leader>P', '"+P', opts)
vim.keymap.set('n', '<leader>y', '"+y', opts)
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>Y', '"+y$', opts)

-- Allow gf to open no-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>', opts)
