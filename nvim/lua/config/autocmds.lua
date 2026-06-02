-- Autocmds loaded on the VeryLazy event.
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- LazyVim already covers: highlight-yank, checktime, resize_splits,
-- last_loc, close_with_q (for help/qf/grug-far/gitsigns-blame/snacks/etc),
-- man_unlisted, wrap_spell (text/markdown/gitcommit/typst/plaintex),
-- json_conceal, auto_create_dir.
--
-- This file only adds what LazyVim doesn't ship.

-- Strip trailing whitespace on save.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('user_trim_whitespace', { clear = true }),
  desc = 'Trim trailing whitespace on save',
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! keepjumps keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Enable format-on-save for `lua` buffers only. `vim.g.autoformat = false`
-- in options.lua disables it globally; this autocmd flips `vim.b.autoformat`
-- to true on lua buffers, which LazyVim's format autocmd checks (`vim.b`
-- takes precedence over `vim.g`). Migration plan item D64.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user_lua_autoformat', { clear = true }),
  pattern = 'lua',
  desc = 'Enable format-on-save for Lua buffers',
  callback = function(args)
    vim.b[args.buf].autoformat = true
  end,
})
