-- Inspired by/Copied from:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/ui.lua

local M = {}

-- Use Treesitter for folds.
--
-- Contains minor optimisations to avoid calling Treesitter if it doesn't
-- support the buffer filetype.
function M.expr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].has_ts_folds == nil then
    -- Treesitter needs a real filetype to do anything.
    if vim.bo[buf].filetype == '' then
      return '0'
    end
    if vim.bo[buf].filetype:find('dashboard') then
      vim.b[buf].has_ts_folds = false
    else
      vim.b[buf].has_ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].has_ts_folds and vim.treesitter.foldexpr() or '0'
end

return M
