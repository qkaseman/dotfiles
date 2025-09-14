-- [[ Setting options ]]
-- See `:help vim.o`
-- For all options, see `:help option-list`
--
-- WARN: Don't set 'formatoptions' here, the file type plugins that get loaded
-- last will override whatever you set. Use an autocommand.
--
-- `vim.o` is used over `vim.opt` b/c eventually it will be required and it
-- has better overall devex. The one exception is tables, so those still use
-- `vim.opt`.
local o = vim.o

-- Make line numbers default
o.number = true
o.relativenumber = false -- relative numbers are evil
o.mouse = 'a'
-- Don't show mode in command line, since it's already in the status line
o.showmode = false
o.clipboard = '' -- don't use the system clipboard unless specified
o.breakindent = true -- wrapped lines have pseudo-indentation
o.ignorecase = true -- case-insensitive search
o.smartcase = true -- unless `\C` or capital letters are present
o.undofile = true -- save undo history
o.signcolumn = 'yes' -- probalby want `number` here
o.updatetime = 1000 -- ms between swapfile writes
o.timeoutlen = 500 -- ms, display which-key sooner
o.splitright = true
o.splitbelow = true
o.list = true -- show whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'nosplit' -- preview substitutions in buffer
o.cursorline = true
o.scrolloff = 10
o.sidescrolloff = 5
o.modeline = false -- only use my configurations
o.colorcolumn = '+1,80' -- highlight 80th column and one past `textwidth`.
o.virtualedit = 'block'
o.confirm = true -- if operation would fail, ask for confirm first
o.spell = true

-- Tabs vs Spaces --
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.shiftround = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
