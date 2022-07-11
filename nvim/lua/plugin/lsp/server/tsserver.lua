local typescript = require('typescript')

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    on_attach = require('plugin.lsp.on-attach').on_attach,
  }
})
