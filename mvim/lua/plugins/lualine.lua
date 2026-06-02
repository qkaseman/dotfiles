-- Statusline with mode, branch, diagnostics, and file info.
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = { statusline = { 'dashboard' } },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'diagnostics', { 'filename', path = 1 } },
      lualine_x = { 'diff', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'neo-tree', 'lazy', 'trouble' },
  },
}
