-- [[ Bootstrap `lazy.nvim` plugin manager. ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.env.LAZY or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if not ok then
  vim.api.nvim_echo({
    { ('Unable to load lazy from: %s\n'):format(lazypath), 'ErrorMsg' },
    { '\nPress any key to exit...', 'MoreMsg' },
  }, true, {})
  vim.fn.getchar()
  os.exit(1)
end

-- TODO: Make a PR to have `kickstart.nvim` use `spec = ` rather than
-- un-named first arg. Makes Lua LSP happier and seems to be what the
-- documentation actually wants you to do as well (as there is only a single
-- reference to the un-named argument in the primary `setup` docs).
lazy.setup({
  spec = {
    { import = 'plugins' },
  },
  ui = {
    -- Use Nerd Font icons if they exist, otherwise use unicode icons.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom
    -- plugins will load during startup. If you know what you're doing,
    -- you can set this to `true` to have all your custom plugins lazy-loaded
    -- by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin
    -- that support versioning, have outdated releases, which may break your
    -- Neovim install.
    version = false, -- always use the latest git commit
  },
  -- TODO: what is the difference between this and manually setting the plugin?
  -- install = { colorscheme = { 'tokyonight', 'astrotheme', 'habamax' } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
