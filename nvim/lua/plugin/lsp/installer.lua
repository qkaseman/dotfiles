local lsp_installer = require('nvim-lsp-installer')

local M = {}

-- Install the list of servers.
M.install = function(servers)
  lsp_installer.setup {
    ensure_installed = servers,
    automatic_installation = true,
    ui = { border = "rounded" },
  }
end

return M
