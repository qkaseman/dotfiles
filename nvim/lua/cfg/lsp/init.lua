-- The dependencies are set up properly in 'plugin.lua' so only need to check if `lspconfig` is present.
-- We don't actually use it in this file but it provides safety for all other
-- `requires` to not be wrapped in `pcall`.
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end
local util = require("lspconfig.util")
local installer_core = require('mason')
local installer_lsp = require('mason-lspconfig')

 -- TODO: Extend this so it's a "server name" and "callback" association where the callback is the setup function.
local servers = {
  'tsserver',
  'sumneko_lua',
  'bashls',
  'cmake',
  'cssls',
  'cucumber_language_server',
  'dockerls',
  'eslint',
  'html',
  'jsonls',
  'jdtls', -- Java
  'kotlin_language_server',
  'pyright',
  'solargraph', -- Ruby
  'rust_analyzer',
  'lemminx', -- XML
  'yamlls'
}

-- Install
installer_core.setup {
  ui = { border = "rounded" },
}
installer_lsp.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- LSP config
vim.diagnostic.config({
  virtual_text = false, -- errors inline
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
require('cfg.lsp.tsserver').setup()
require('cfg.lsp.sumneko_lua').setup()
require('cfg.lsp.bashls').setup()
require('cfg.lsp.cmake').setup()
require('cfg.lsp.cssls').setup()
require('cfg.lsp.cucumber_language_server').setup()
require('cfg.lsp.dockerls').setup()
require('cfg.lsp.eslint').setup()
require('cfg.lsp.html').setup()
require('cfg.lsp.jsonls').setup()
require('cfg.lsp.jdtls').setup()
require('cfg.lsp.kotlin_language_server').setup()
require('cfg.lsp.pyright').setup()
require('cfg.lsp.solargraph').setup()
require('cfg.lsp.rust_analyzer').setup()
require('cfg.lsp.lemminx').setup()
require('cfg.lsp.yamlls').setup()
