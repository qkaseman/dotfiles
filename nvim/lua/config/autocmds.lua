-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup('TrimWhiteSpaceGrp', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

--- Indentation/Format Settings ---
-- Needed because file type plugins that Neovim provides get loaded after
-- options are set.
--[[
local IndentationGrp = vim.api.nvim_create_augroup('IndentationGrp', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*.js', '*.ts', '*.tsx', '*.jsx' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append({ c = true, r = true, o = true, q = true })
  end,
    group = IndentationGrp,
})
--]]
