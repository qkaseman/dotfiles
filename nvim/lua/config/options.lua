-- [[ Setting options ]]
-- See `:help vim.opt`
-- For all options, see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false -- relative numbers are evil
vim.opt.mouse = 'a'
-- Don't show mode in command line, since it's already in the status line
vim.opt.showmode = false
vim.opt.clipboard = '' -- don't use the system clipboard unless specified
vim.opt.breakindent = true -- wrapped lines have pseudo-indentation
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- unless `\C` or capital letters are present
vim.opt.undofile = true -- save undo history
vim.opt.signcolumn = 'yes' -- probalby want `number` here
vim.opt.updatetime = 1000 -- ms between swapfile writes
vim.opt.timeoutlen = 500 -- ms, display which-key sooner
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true -- show whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'nosplit' -- preview substitutions in buffer
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5
vim.opt.modeline = false -- only use my configurations
