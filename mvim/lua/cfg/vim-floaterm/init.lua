local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>t', ':FloatermToggle scratch<CR>', opts)
vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:FloatermToggle scratch<CR>', opts)

-- Default is a split for git commit, still use a floating window.
vim.g.floaterm_gitcommit='floaterm'

vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_wintitle=0
