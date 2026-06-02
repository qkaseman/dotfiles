-- LSP, mason, and language extras consolidated into one file so the full
-- "what's installed" view lives in a single place.
--
-- Strategy:
-- 1. Enable LazyVim language extras for langs that have them. Each extra
--    pulls in the right LSP, formatter, linter, treesitter parsers, and
--    sometimes DAP adapters with sensible defaults.
-- 2. Add to mason `ensure_installed` for tools the extras don't cover.
-- 3. Override LazyVim's default LSP keymaps via `lspconfig.opts.servers["*"]
--    .keys` to switch from LazyVim's two-letter keys to kickstart's `gr*`
--    family. The `opts_extend = { "servers.*.keys" }` setting on lspconfig
--    means our list is appended to LazyVim's, with `false` entries
--    removing keys.

return {
  -----------------------------------------------------------
  -- Language extras (enable LazyVim's curated language packs)
  -----------------------------------------------------------
  { import = 'lazyvim.plugins.extras.lang.typescript' }, -- vtsls + eslint
  { import = 'lazyvim.plugins.extras.lang.python' },     -- basedpyright + ruff
  { import = 'lazyvim.plugins.extras.lang.json' },       -- jsonls + SchemaStore
  { import = 'lazyvim.plugins.extras.lang.yaml' },       -- yamlls + SchemaStore
  { import = 'lazyvim.plugins.extras.lang.markdown' },   -- marksman + markdownlint-cli2 + markdown-toc
  { import = 'lazyvim.plugins.extras.lang.java' },       -- jdtls
  { import = 'lazyvim.plugins.extras.dap.core' },        -- nvim-dap + nvim-dap-ui + mason-nvim-dap

  -----------------------------------------------------------
  -- Mason ensure_installed for languages without an extra
  -----------------------------------------------------------
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        -- LSP servers
        'bash-language-server',
        'css-lsp',
        'cucumber-language-server',
        'gradle-language-server',
        'html-lsp',
        'some-sass-language-server',
        'stylelint-lsp',
        -- Linters
        'commitlint',
        'editorconfig-checker',
        'ktlint',
        -- Formatters
        'prettierd',
      },
    },
  },

  -----------------------------------------------------------
  -- LSP keymap overrides (kickstart-style `gr*` family)
  -----------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ['*'] = {
          keys = {
            -- Disable LazyVim's two-letter LSP keys (kickstart uses 3-letter `gr*`).
            { 'gd', false },
            { 'gD', false },
            { 'gr', false },
            { 'gI', false },
            { 'gy', false },
            { 'K', false },
            { 'gK', false },
            { '<c-k>', false, mode = 'i' },
            -- Drop `<leader>c*` entries that move to `gr*` family.
            { '<leader>ca', false, mode = { 'n', 'x' } },
            { '<leader>cr', false },
            { '<leader>cA', false },
            { '<leader>co', false },

            -- Kickstart-style additions (only fire when LSP attached).
            { 'grn', vim.lsp.buf.rename, desc = 'Rename', has = 'rename' },
            { 'gra', vim.lsp.buf.code_action, desc = 'Code Action',
              mode = { 'n', 'x' }, has = 'codeAction' },
            { 'grr', function() Snacks.picker.lsp_references() end,
              desc = 'References', nowait = true },
            { 'gri', function() Snacks.picker.lsp_implementations() end,
              desc = 'Implementations' },
            { 'grd', function() Snacks.picker.lsp_definitions() end,
              desc = 'Definition', has = 'definition' },
            { 'grD', vim.lsp.buf.declaration, desc = 'Declaration' },
            { 'grt', function() Snacks.picker.lsp_type_definitions() end,
              desc = 'Type Definition' },
            { 'grA', LazyVim.lsp.action.source, desc = 'Source Action',
              has = 'codeAction' },
            { 'grO', LazyVim.lsp.action['source.organizeImports'],
              desc = 'Organize Imports', has = 'codeAction' },
            { 'gW', function() Snacks.picker.lsp_workspace_symbols() end,
              desc = 'Workspace Symbols' },
          },
        },
      },
    },
  },

  -----------------------------------------------------------
  -- markdownlint config flag (preserve XDG path; deferred decision item)
  -----------------------------------------------------------
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters.markdownlint = vim.tbl_deep_extend('force', opts.linters.markdownlint or {}, {
        args = {
          '--disable=line-length',
          '--config',
          (vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config')) .. '/markdownlint/config.json',
          '--',
        },
      })
    end,
  },
}
