-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- General --
vim.opt.mouse = "a"
vim.opt.title = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = 'tab:▸-,trail:·,extends:»,precedes:«,nbsp:%'
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes" -- Prevent shifting text, always show the signcolumn

-- Spelling --
vim.opt.spell = true

-- Code Style --
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- Tabs vs Spaces --
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Search --
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmode = 'longest:full,full'

-- All bells must die. --
vim.opt.belloff = 'all'
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Search --
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmode = "longest:full,full"

-- Splits --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Backup/Undo --
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath('data')..'/backup//'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data')..'/undo//'
vim.opt.undolevels = 10000

-- Fix bad LazyVim's defaults. --
vim.opt.relativenumber = false -- Just.... why?
vim.opt.autowrite = false -- Autosaving can break in-progress builds.
vim.opt.wrap = true -- Scrolling is evil.
vim.g.autoformat = false -- So is autoformatting.
vim.opt.clipboard = "" -- So is using the system clipboard for everything.

-- LazyVim defaults I don't know if I like. --
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.formatoptions = "jcroqlnt" -- tcqj
--                       ||||||||
--                       |||||||+- auto-wrap text
--                       ||||||+- recognise number lists
--                       |||||+- don't auto-wrap long lines in Insert mode
--                       ||||+- format comments with `gq`
--                       |||+- add comment leader with `o`, Ctrl-U deletes
--                       ||+- add comment leader when hitting <enter>
--                       |+- wrap comments and add comment leader
--                       +- remove comment leader when joining lines
