local setup_buffer_keymaps = function(bufnr)
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
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('v', '<space>ca', vim.lsp.buf.range_code_action, bufopts)
  vim.keymap.set('n', '<leader>ca', ':Telescope lsp_code_actions<CR>', bufopts)
  vim.keymap.set('v', '<leader>ca', ':Telescope lsp_range_code_actions<CR>', bufopts)
  -- vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>', bufopts)
  -- vim.keymap.set('v', '<leader>ca', ':CodeActionMenu<CR>', bufopts)

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions.
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

return function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  setup_buffer_keymaps(bufnr)

  -- Can this be done better?
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end
