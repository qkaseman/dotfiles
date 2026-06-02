-- which-key spec overrides. LazyVim's defaults register groups under
-- prefixes we've moved or repurposed; this file fixes the labels so the
-- popup matches reality.
--
-- LazyVim sets `opts_extend = { "spec" }` on which-key, so our entries
-- here ARE appended to LazyVim's spec. Group definitions in which-key v3
-- are last-write-wins for a given lhs, so the entries below override
-- LazyVim's labels for the same prefix.

return {
  'folke/which-key.nvim',
  opts = {
    spec = {
      -- `<leader>f` is now a direct format binding (kickstart-style),
      -- not a group prefix. Relabel from LazyVim's "file/find".
      { '<leader>f', desc = 'Format buffer' },
      -- `<leader>F` is format injected (capital F, kickstart-style extension).
      { '<leader>F', desc = 'Format injected' },
      -- `<leader>q` is now a direct diagnostic-loclist binding, not the
      -- session group prefix. Relabel from LazyVim's "quit/session".
      { '<leader>q', desc = 'Diagnostic loclist' },
      -- Hunks moved from `<leader>gh*` to `<leader>h*`.
      { '<leader>h', group = 'git hunks', mode = { 'n', 'v' } },
      { '<leader>gh', hidden = true },
      -- Sessions moved from `<leader>q*` to `<leader>Q*`.
      { '<leader>Q', group = 'session' },
      -- Toggleterm uses `<leader>T*` to leave `<leader>t*` free.
      { '<leader>T', group = 'terminal' },
    },
  },
}
