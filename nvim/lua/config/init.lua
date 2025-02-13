-- Load configurations and bootstrap plugins.

-- `leader` has to be set before plugins get loaded or they will configure
-- themselves with the wrong keybind. `<SPACE>` is easier than `/`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Load all plugins first so user settings override theirs
require('config.lazy')
require('config.options')
require('config.keymaps')
require('config.autocmds')
