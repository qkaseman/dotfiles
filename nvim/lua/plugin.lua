local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.loader.enable() -- enable experimental faster module loader
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({

  -- load colourscheme first
  {
    'NLKNguyen/papercolor-theme',
    lazy = false,
    priority = 1000, -- load before all other non-lazy plugs
    config = function()
      require('cfg.theme')
    end
  },

  -- Adds :Rename, :SudoWrite, and other cool commands)
  'tpope/vim-eunuch',

  {
    -- look at moving the treesitter files to a dir inside of the data dir
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'RRethy/nvim-treesitter-textsubjects',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
    build = ':TSUpdate',
    config = function()
      require('cfg.treesitter')
    end,
  },

  { 'rafamadriz/friendly-snippets', lazy = false },


  {
    'neovim/nvim-lspconfig',
    dependencies = {
      --{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      --{ "folke/neodev.nvim", opts = {} },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'b0o/schemastore.nvim',
      -- Add LSP highlight groups for those that don't support the LSP client yet
      'folke/lsp-colors.nvim',
      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          'hrsh7th/cmp-buffer',
          'onsails/lspkind.nvim',
          'hrsh7th/cmp-nvim-lsp-signature-help',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-document-symbol',
          'saadparwaiz1/cmp_luasnip',
          'lukas-reineke/cmp-under-comparator',
          'hrsh7th/cmp-cmdline',
          'doxnit/cmp-luasnip-choice',
          'L3MON4D3/LuaSnip',
          {
            'David-Kunz/cmp-npm',
            dependencies = {
              'nvim-lua/plenary.nvim',
            }
          },
        },
        config = function()
          require('cfg.cmp')
        end,
      },
    },
    config = function()
      require('cfg.lsp')
    end
  },

  {
    'voldikss/vim-floaterm',
    config = function()
      require('cfg.vim-floaterm')
    end
  },

  {
    'vim-test/vim-test',
    config = function() require('cfg.vim-test') end
  },

  {
    'glepnir/dashboard-nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', name = 'nvim-tree-web-devicons' },
    },
    event = 'VimEnter',
    config = function() require('cfg.dashboard') end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('cfg.lualine') end
  },

  -- The paste plugin you didn't know you wanted. Adjust indentation to
  -- the destination context.
  -- This might be the greatest thing ever.
  {
    'sickill/vim-pasta',
    config = function() require('cfg.vim-pasta') end
  },

  -- Code-aware line splitting and joining.
  { 'AndrewRadev/splitjoin.vim' },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('cfg.nvim-tree') end
  },

  {
    'j-hui/fidget.nvim',
    branch = 'legacy',
    dependencies = {
      'nvim-lspconfig',
    },
    config = function() require('cfg.fidget') end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function() require('cfg.telescope') end
  },
})



