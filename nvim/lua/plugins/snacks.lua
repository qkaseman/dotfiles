-- Snacks: configure the parts we want to behave differently.
--
-- - Disable terminal: toggleterm replaces it (`<C-/>`, `<C-'>`, `<leader>T*`).
-- - Animate already disabled globally via `vim.g.snacks_animate = false` in
--   options.lua; mirroring it here for explicitness.
-- - Explorer: show hidden + gitignored entries by default.

return {
  {
    'folke/snacks.nvim',
    opts = {
      terminal = { enabled = false },
      animate = { enabled = false },
      -- Disable snacks notifier so vim.notify falls back to vim's default
      -- bottom-row :echomsg style instead of floating snacks toasts.
      notifier = { enabled = false },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    -- LazyVim's `<leader>n` opens snacks notification history. With notifier
    -- disabled there's nothing in that history; redirect to vim's :messages
    -- buffer instead.
    keys = {
      { '<leader>n', '<cmd>messages<cr>', desc = 'Message History' },
      -- LazyVim's `<leader>un` (dismiss notifications) becomes a no-op too.
      { '<leader>un', false },
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
