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
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Handle installation of LSPs and related tools to stdpath for Neovim
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful async status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- NOTE: Make sure any plugins that add new capabilities get added to
      -- the `capabilities` table passed to the LSPs. (the LSPs? LSPs?)
      -- TODO: see if these could be pulled up higher in the config/au? Easier
      -- to not miss it then.

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
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

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of
          -- an error or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor, for when
          -- types are declared without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Jump to the declaration of the word under the cursor. In C, this
          -- would go to the header; in TypeScript, to `const foo: Type;`.
          -- For high-level languages this will be the same thing as the
          -- word's definition.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map(
            'gW',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            'Open Workspace Symbols'
          )

          -- Jump to the definition of the type of the word under your cursor.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Toggle inline hints, if supported. Generally this is a terrible
          -- feature as it displaces code and screws with line length, but
          -- _can_ have its uses.
          -- TODO: send msg if not supported.
          local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- Merge default Neovim LSP capabilities with any additional capabilities
      -- from plugins.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

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
        -- vtsls wraps the VS Code TypeScript extension as an LSP server,
        -- providing more code actions, better inlay hints, and server-side
        -- fuzzy matching over the built-in ts_ls.
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        vtsls = {
          filetypes = {
            'javascript', 'javascriptreact', 'javascript.jsx',
            'typescript', 'typescriptreact', 'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = { completeFunctionCalls = true },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'bashls',
        'cssls',
        'cucumber_language_server',
        'eslint-lsp', -- JS/TS
        'gradle_ls',
        'html-lsp',
        -- 'java-language-server',
        'jsonls',
        -- 'kotlin-language-server',
        'python-lsp-server',
        -- 'rubocop', -- Ruby
        'somesass_ls',
        'stylelint-lsp', -- CSS/Sass
        'yamlls',

        -- Linters (some also format)
        'commitlint',
        'editorconfig-checker',
        -- 'erb-lint',
        -- 'eslint_d', -- JS/TS
        'ktlint', -- Kotlin
        'markdownlint',
        -- 'stylelint', -- CSS/Sass

        -- Formatters
        -- 'erb-formatter',
        'prettierd',
        'stylua',
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
