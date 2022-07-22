-- Make sure to run `:PackerSync` after editing this file, otherwise the things
-- won't get updated properly. It seems like it might be a pain to have it be
-- done automatically as it will delete the existing plugins (it seems). Would
-- be nice to have a smart "is it installed" and install specific plugins. Will
-- have to look into if that is possible later.
local fn = vim.fn

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "plugin.lua" }
)

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.api.nvim_command("packadd packer.nvim")
end

local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  compile_path = fn.stdpath('data') .. "/site/pack/packer/start/packer.nvim/plugin/packer.lua",
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

return packer.startup(function(use)
  -- Let packer manage itself
  use({ 'wbthomason/packer.nvim' })

  -- Adds :Rename, :SudoWrite, and other cool commands)
  use({ 'tpope/vim-eunuch' })

  -- automatically create parent dirs when saving
  use({ 'jessarcher/vim-heritage' })

  use({ 'NLKNguyen/papercolor-theme', config = function() require('cfg.theme') end })

  --TODO: may need a unix guard around here
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    requires = { 'lewis6991/spellsitter.nvim', },
    config = function() require('cfg.treesitter') end
  })

  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      {
        'L3MON4D3/LuaSnip',
        requires = { "rafamadriz/friendly-snippets" },
        config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        "onsails/lspkind-nvim",
        config = function() require("lspkind").init() end,
      }, {
        'David-Kunz/cmp-npm',
        requires = {
          'nvim-lua/plenary.nvim',
        }
      },
    },
    config = function() require('cfg.cmp') end
  })

  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'jose-elias-alvarez/typescript.nvim',
      'b0o/schemastore.nvim',
      'hrsh7th/nvim-cmp',
      -- Add LSP highlight groups for those that don't support the LSP client yet
      'folke/lsp-colors.nvim',
    },
    config = function() require('cfg.lsp') end
  })

  use({
    'glepnir/dashboard-nvim',
    config = function() require('cfg.dashboard') end
  })

  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
