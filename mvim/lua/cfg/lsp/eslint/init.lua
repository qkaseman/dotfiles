local M = {}

function M.setup()
  local caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').eslint.setup({
    capabilities = caps,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = {
      ['window/showMessageRequest'] = function(_, result, _) return result end,
    },
  });
end

return M
