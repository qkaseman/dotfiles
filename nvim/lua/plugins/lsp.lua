-- LSP, mason, and language extras consolidated into one file so the full
-- "what's installed" view lives in a single place.
--
-- Strategy:
-- 1. LazyVim language extras are enabled in `lua/config/lazy.lua` (between
--    LazyVim core and user plugins) so they load in the correct order.
--    Currently enabled: lang.typescript, lang.python, lang.json, lang.yaml,
--    lang.markdown, lang.java, dap.core.
-- 2. Add to mason `ensure_installed` for tools the extras don't cover.
-- 3. Override LazyVim's default LSP keymaps via `lspconfig.opts.servers["*"]
--    .keys` to switch from LazyVim's two-letter keys to kickstart's `gr*`
--    family. The `opts_extend = { "servers.*.keys" }` setting on lspconfig
--    means our list is appended to LazyVim's, with `false` entries
--    removing keys.

return {
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
  -- markdownlint-cli2 config flag
  -----------------------------------------------------------
  -- LazyVim's `lang.markdown` extra uses `markdownlint-cli2` (not the older
  -- `markdownlint` cli). Point it at the existing config in this dotfiles
  -- repo at `$XDG_CONFIG_HOME/markdownlint/config.json`.
  --
  -- nvim-lint's default args for markdownlint-cli2 are `{ "-" }` -- the dash
  -- tells the cli to read from stdin (which nvim-lint pipes the buffer
  -- through). We prepend `--config <path>` and keep the stdin marker.
  --
  -- Long-term home for the config file is a deferred decision (item 8).
  {
    'mfussenegger/nvim-lint',
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters['markdownlint-cli2'] = vim.tbl_deep_extend('force', opts.linters['markdownlint-cli2'] or {}, {
        args = {
          '--config',
          (vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config')) .. '/markdownlint/config.json',
          '-',
        },
      })
    end,
  },
}
