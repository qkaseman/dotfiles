-- General --
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = 'tab:▸-,trail:·,extends:»,precedes:«,nbsp:%'
vim.opt.signcolumn = "number" -- LSP icons in number gutter

-- Spelling --
vim.opt.spell = true

-- Tabs vs Spaces --
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search --
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmode = 'longest:full,full'

-- Splits --
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- All bells must die. --
vim.opt.belloff = 'all'
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Buffers --
vim.opt.hidden = true -- Open new buffer with unsaved changes in current
vim.opt.virtualedit = 'block'

-- Tabs --
vim.opt.showtabline = 1 -- show if two tabs

-- Backup/Undo --
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath('data')..'/backup//'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data')..'/undo//'

