local M = {}

function M.setup()
  local caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').kotlin_language_server.setup({
    capabilities = caps,
    flags = {
      debounce_text_changes = 150,
    },
  });
end

return M
