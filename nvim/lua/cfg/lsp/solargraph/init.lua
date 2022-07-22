-- Ruby... ewwww....
local M = {}

function M.setup()
  local caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').solargraph.setup({
    capabilities = caps,
    flags = {
      debounce_text_changes = 150,
    },
  });
end

return M
