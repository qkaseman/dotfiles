-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local au = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup('whitespace', { clear = true })
au({ 'BufRead', 'BufWrite' }, {
  group = group,
  callback = function ()
    local ws_regex = "\\s\\+"

    -- Only do if the buffer is modifiable
    if not vim.bo.modifiable or vim.o.binary and vim.o.filetype == 'diff' then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd("silent! keeppatterns %s/"..ws_regex.."$//e")
    vim.fn.winrestview(view)
  end,
} )
