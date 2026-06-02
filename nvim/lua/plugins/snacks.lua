-- Snacks: configure the parts we want to behave differently.
--
-- - Disable terminal: toggleterm replaces it (`<C-/>`, `<C-'>`, `<leader>T*`).
-- - Animate already disabled globally via `vim.g.snacks_animate = false` in
--   options.lua; mirroring it here for explicitness.
-- - Explorer: show hidden + gitignored entries by default (matches the
--   `filtered_items.visible = true` behavior from mvim's neo-tree config).

return {
  {
    'folke/snacks.nvim',
    opts = {
      terminal = { enabled = false },
      animate = { enabled = false },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },

  -- Disable LazyVim's snacks_picker `<leader>f*` keys. They're absorbed into
  -- the kickstart-style `<leader>s*` namespace defined in `lua/config/keymaps.lua`.
  --
  -- The keys live in `extras/editor/snacks_picker.lua` which auto-loads when
  -- `vim.g.lazyvim_picker = "auto"` resolves to snacks (the default in 15.x).
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>ff', false },
      { '<leader>fF', false },
      { '<leader>fr', false },
      { '<leader>fR', false },
      { '<leader>fb', false },
      { '<leader>fB', false },
      { '<leader>fc', false },
      { '<leader>fg', false },
    },
  },
}
