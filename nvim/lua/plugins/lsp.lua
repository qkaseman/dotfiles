-- LSP Plugins
return {
  { -- `lazydev` configures Lua LSP for your Neovim config, runtime and
    -- plugins used for completion, annotations and signatures of Neovim
    -- apis. Super nice.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Documentation for all modules shipped in Luvit (a NodeJS-style async
  -- runtime for Lua, see [luvit.io](https://luvit.io/) for more details.
  { 'Bilal2453/luvit-meta', lazy = true },

  { -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Handle installation of LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful async status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- NOTE: Make sure any plugins that add new capabilities get added to
      -- the `capabilities` table passed to the LSPs. (the LSPs? LSPs?)
      -- TODO: see if these could be pulled up higher in the config/au? Easier
      -- to not miss it then.

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(attach_event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = attach_event.buf, desc = 'LSP: ' .. desc })
          end
          -- TODO: `symbol` rather than `word`? `word` just seems wrong.

          -- Jump to the definition of the word under your cursor.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor, for when
          -- types are declared without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the type of the word under your cursor.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Jump to the declaration of the word under the cursor. In C, this
          -- would go to the header; in TypeScript, to `const foo: Type;`.
          -- For high-level languages this will be the same thing as the
          -- word's definition.
          -- TODO: How does this differ from `lsp_implementations`?
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          map(
            '<leader>ds',
            require('telescope.builtin').lsp_document_symbols,
            '[D]ocument [S]ymbols'
          )

          -- Fuzzy find all the symbols in your current workspace.
          map(
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            '[W]orkspace [S]ymbols'
          )

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action. This is weirdly named, it isn't for all
          -- actions on code (such as `rename`), it's for LSP suggestions such
          -- as ways to fix errors or suggested code snippets.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- In-buffer reference highlighting
          local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
          if
            client
            and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
          then
            local highlight_augroup =
              vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            -- Highlight references of the word under the cursor if it rests
            -- there for a little while.
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = attach_event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- But clear it when the cursor starts moving again.
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = attach_event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            -- And clear it when LSP is detached from the buffer.
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(detach_event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = 'lsp-highlight',
                  buffer = detach_event.buf,
                })
              end,
            })
          end

          -- Toggle inline hints, if supported. Generally this is a terrible
          -- feature as it displaces code and screws with line length, but
          -- _can_ have its uses.
          -- TODO: send msg if not supported.
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = attach_event.buf })
              )
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Don't update LSP in insert mode.
      vim.diagnostic.config({ update_in_insert = false })

      -- Use those Nerd Font icons if they exist.
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config({ signs = { text = diagnostic_signs } })
      end

      -- Merge default Neovim LSP capabilities with any additional capabilities
      -- from plugins.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated
      --    filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used
      --    to disable certain LSP features.
      --  - settings (table): Override the default settings passed when
      --    initializing the server. What you can do in the settings depends
      --    on the server. For example, to see the options for `lua_ls`, you
      --    could go to: https://luals.github.io/wiki/settings/
      --
      -- TODO: Create/use a type for this
      local servers = {
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'bashls',
        'cssls',
        'cucumber_language_server',
        'ts_ls',
        'gradle_ls',
        'jsonls',
        'yamlls',
        'somesass_ls',
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
      })

      -- Override any default LSP server configurations with user-specified
      -- options.
      --
      -- `mason-lspconfig` doesn't provide proper type information, not all
      -- fields are required.
      ---@diagnostic disable-next-line: missing-fields
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = vim.tbl_deep_extend('force', {
              flags = {
                debounce_text_changes = 150,
              },
            }, servers[server_name] or {})
            server.capabilities =
              vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
