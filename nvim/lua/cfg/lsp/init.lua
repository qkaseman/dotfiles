-- TODO: Make a map of server name to config and use that rather
-- than manually specifying them.

local ok, installer = pcall(require, 'nvim-lsp-installer')
if not ok then
    return
end
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end

vim.opt.signcolumn = "number"
--vim.opt.signcolumn = "yes:2"

local servers = {
  'tsserver'
}

-- Install the list of servers.
installer.setup {
    ensure_installed = servers,
    automatic_installation = true,
    ui = { border = "rounded" },
}

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

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --buf_keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>')
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<space>ca', vim.lsp.buf.range_code_action, bufopts)
  -- buf_keymap(bufnr, 'n', '<leader>ca', ':Telescope lsp_code_actions<CR>')
  -- buf_keymap(bufnr, 'n', '<leader>ca', ':CodeActionMenu<CR>')

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions.
  vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- Typescript
local ok, typescript = pcall(require, 'typescript')
if not ok then
    return
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
  return
end

local caps = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
caps.textDocument.completion.completionItem.snippetSupport = true
caps.textDocument.completion.completionItem.preselectSupport = true
caps.textDocument.completion.completionItem.insertReplaceSupport = true
caps.textDocument.completion.completionItem.labelDetailsSupport = true
caps.textDocument.completion.completionItem.deprecatedSupport = true
caps.textDocument.completion.completionItem.commitCharactersSupport = true
caps.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
caps.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
caps.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        "",
        "quickfix",
        "refactor",
        "refactor.extract",
        "refactor.inline",
        "refactor.rewrite",
        "source",
        "source.organizeImports",
      },
    },
  },
}

typescript.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  -- LSP Config options
  server = {
    capabilities = caps,
    handlers = handlers,
    on_attach = on_attach,
  }
})

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
