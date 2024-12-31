-- [[ Basic Keymaps ]]
-- Modes
--  'n' - normal mode
--  'i' - insert mode
--  'v' - visual mode
--  'x' - visual block mode
--  't' - term mode
--  'c' - command mode
--  ''  - equivalent of ':map' (nvo)
--  '!' - equivalent of ':map!'
--
--  See `:help set()`
local set = vim.keymap.set

-- Make semicolon into colon, because lazy.
set('', ';', ':', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- No arrow keys for you (or me).
set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- CTRL+<hjkl> to navigate between splits.
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Remap for dealing with visual line wraps
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Make 'Y' behave like 'D' and 'C'
set('n', 'Y', 'y$', { desc = '[Y]ank full line. Works like `D` and `C`' })
