-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

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
-- vim.keymap.set('', 'gf', ':edit <cfile><CR>', opts)
