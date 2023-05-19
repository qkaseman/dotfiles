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
    run = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
    config = function() require('cfg.treesitter') end
  })

  use( {
    'L3MON4D3/LuaSnip',
    requires = {
      "rafamadriz/friendly-snippets"
    },
    config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
  })

  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'saadparwaiz1/cmp_luasnip',
        requires = {
          -- Sadly, only one level of `requires` nesting is supported.
          'L3MON4D3/LuaSnip',
        },
      }, {
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
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
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

  use({
    'voldikss/vim-floaterm',
    config = function() require('cfg.vim-floaterm') end
  })

  use({
    'vim-test/vim-test',
    config = function() require('cfg.vim-test') end
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('cfg.lualine') end
  })

  -- The paste plugin you didn't know you wanted. Adjust indentation to
  -- the destination context.
  -- This might be the greatest thing ever.
  use({
    'sickill/vim-pasta',
    config = function() require('cfg.vim-pasta') end
  })

  -- Code-aware line splitting and joining.
  use({ 'AndrewRadev/splitjoin.vim' })

  use({
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('cfg.nvim-tree') end
  })

  use({
    'j-hui/fidget.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    config = function() require('cfg.fidget') end
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function() require('cfg.telescope') end
  })

  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
