local M = {}

function M.setup()
  local caps = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').jsonls.setup({
    capabilities = caps,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  });
end

return M
