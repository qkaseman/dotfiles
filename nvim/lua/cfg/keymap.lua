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

-- Wrapped lines to go next by default.
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)
vim.keymap.set('n', 'gj', 'j', opts)
vim.keymap.set('n', 'gk', 'k', opts)
