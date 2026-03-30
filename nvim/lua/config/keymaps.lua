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

-- CTRL+SHIFT+<hjkl> to move windows around, some terminals have colliding
-- built-in keymaps.
set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Remap for dealing with visual line wraps
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Make 'Y' behave like 'D' and 'C'
set('n', 'Y', 'y$', { desc = '[Y]ank full line. Works like `D` and `C`' })

-- Keep selection after indentation changes.
set('v', '<', '<gv')
set('v', '>', '>gv')

-- Keep paste buffer after pasting once.
vim.keymap.set('v', 'p', 'pgvy')

-- Copy to system clipboard
set({ 'n', 'v' }, '<leader>y', '"+y')
set('n', '<leader>Y', '"+Y')

-- Insert blank lines without entering Insert mode.
set('n', ']<Space>', function()
  vim.fn.append(vim.fn.line('.'), '')
end, { noremap = true })
set('n', '[<Space>', function()
  vim.fn.append(vim.fn.line('.') - 1, '')
end, { noremap = true })

-- Undo breakpoints for specific characters rather than last insert block for
-- more granular undos.
set('i', ',', ',<c-g>u')
set('i', '.', '.<c-g>u')
set('i', ';', ';<c-g>u')

-- UI Toggles (<leader>u prefix)
set('n', '<leader>uf', function()
  if vim.g.autoformat == nil then
    vim.g.autoformat = true
  end
  vim.g.autoformat = not vim.g.autoformat
  vim.notify('Autoformat: ' .. (vim.g.autoformat and 'on' or 'off'))
end, { desc = 'Toggle Autoformat' })

set('n', '<leader>us', function()
  vim.o.spell = not vim.o.spell
  vim.notify('Spell: ' .. (vim.o.spell and 'on' or 'off'))
end, { desc = 'Toggle Spelling' })

set('n', '<leader>uw', function()
  vim.o.wrap = not vim.o.wrap
  vim.notify('Wrap: ' .. (vim.o.wrap and 'on' or 'off'))
end, { desc = 'Toggle Wrap' })

set('n', '<leader>ul', function()
  vim.o.number = not vim.o.number
  vim.notify('Line Numbers: ' .. (vim.o.number and 'on' or 'off'))
end, { desc = 'Toggle Line Numbers' })

set('n', '<leader>uL', function()
  vim.o.relativenumber = not vim.o.relativenumber
  vim.notify('Relative Numbers: ' .. (vim.o.relativenumber and 'on' or 'off'))
end, { desc = 'Toggle Relative Numbers' })

set('n', '<leader>ud', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  vim.notify('Diagnostics: ' .. (vim.diagnostic.is_enabled() and 'on' or 'off'))
end, { desc = 'Toggle Diagnostics' })

set('n', '<leader>uh', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify('Inlay Hints: ' .. (vim.lsp.inlay_hint.is_enabled() and 'on' or 'off'))
end, { desc = 'Toggle Inlay Hints' })

set('n', '<leader>ug', function()
  local ok, snacks = pcall(require, 'snacks')
  if ok and snacks.indent then
    if snacks.indent.enabled then
      snacks.indent.disable()
      vim.notify('Indent Guides: off')
    else
      snacks.indent.enable()
      vim.notify('Indent Guides: on')
    end
  end
end, { desc = 'Toggle Indent Guides' })
