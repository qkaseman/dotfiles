--- Format the buffer on save
--
-- @param bufnr - buffer to format
local function format_on_save(bufnr)
  -- Only auto-format specific file types.
  local enable_filetypes = { lua = true }
  if enable_filetypes[vim.bo[bufnr].filetype] then
    return {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
  end
  return nil
end

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = format_on_save,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
