-- [[ Setting options ]]
-- See `:help vim.opt`
-- For all options, see `:help option-list`
--
-- WARN: Don't set 'formatoptions' here, the file type plugins that get loaded
-- last will override whatever you set. Use an autocommand.
local opt = vim.opt

-- Make line numbers default
opt.number = true
opt.relativenumber = false -- relative numbers are evil
opt.mouse = 'a'
-- Don't show mode in command line, since it's already in the status line
opt.showmode = false
opt.clipboard = '' -- don't use the system clipboard unless specified
opt.breakindent = true -- wrapped lines have pseudo-indentation
opt.ignorecase = true -- case-insensitive search
opt.smartcase = true -- unless `\C` or capital letters are present
opt.undofile = true -- save undo history
opt.signcolumn = 'yes' -- probalby want `number` here
opt.updatetime = 1000 -- ms between swapfile writes
opt.timeoutlen = 500 -- ms, display which-key sooner
opt.splitright = true
opt.splitbelow = true
opt.list = true -- show whitespace characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'nosplit' -- preview substitutions in buffer
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 5
opt.modeline = false -- only use my configurations
opt.colorcolumn = "+1,80" -- highlight 80th column and one past `textwidth`.
