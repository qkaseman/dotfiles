-- Make sure to run `:PackerSync` after editing this file, otherwise the things
-- won't get updated properly. It seems like it might be a pain to have it be
-- done automatically as it will delete the existing plugins (it seems). Would
-- be nice to have a smart "is it installed" and install specific plugins. Will
-- have to look into if that is possible later.
local fn = vim.fn

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerSync", group = packer_group, pattern = "plugin.lua" }
)

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")

function config(plug)
  require('user.plugin.'..plug)
end

return require("packer").startup({
  function(use)
    use { 'wbthomason/packer.nvim' } -- Let packer manage itself

    use {
      'NLKNguyen/papercolor-theme',
      as = 'papercolor',
      config = config('papercolor')
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      requires = {
          'lewis6991/spellsitter.nvim',
      },
      config = function()
        config('treesitter')
        require('spellsitter').setup()
      end
    }

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
