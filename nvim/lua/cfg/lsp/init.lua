-- The dependencies are set up properly in 'plugin.lua' so only need to check if `lspconfig` is present.
-- We don't actually use it in this file but it provides safety for all other
-- `requires` to not be wrapped in `pcall`.
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end
local util = require("lspconfig.util")
local installer = require('nvim-lsp-installer')

 -- TODO: Extend this so it's a "server name" and "callback" association where the callback is the setup function.
local servers = {
  'tsserver',
  'sumneko_lua',
}

-- Install
installer.setup {
    ensure_installed = servers,
    automatic_installation = true,
    ui = { border = "rounded" },
}

-- LSP config
vim.diagnostic.config({
  virtual_text = true, -- errors inline
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    header = '',
    footer = '',
    source = true,
    focus = false,
    format = function(diagnostic)
      if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
        return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
      end
      return diagnostic.message
    end,
  }
})

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- Keymaps

-- Hook to run after the `setup` function is called for each `lsp` server.
-- Used to setup the same keymap for each server, though they can add their own
-- with their own `on_attach` function. The common ones will override them if
-- they use the same keymap though.
util.on_setup = util.add_hook_after(util.on_setup, function(config)
    if config.on_attach then
        config.on_attach = util.add_hook_after(config.on_attach, require("cfg.lsp.on-attach"))
    else
        config.on_attach = require("cfg.lsp.on-attach")
    end
end)

require('cfg.lsp.tsserver').setup()
require('cfg.lsp.sumneko_lua').setup()
