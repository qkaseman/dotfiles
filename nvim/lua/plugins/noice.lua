-- Noice (LazyVim default) puts a `<leader>sn*` group for its own commands
-- (Noice last/history/all/dismiss). We need `<leader>sn` free for kickstart's
-- "search nvim config files" action. Disable the noice subgroup; access its
-- commands via `:Noice <subcommand>` directly when needed.
return {
  'folke/noice.nvim',
  keys = {
    { '<leader>sn', false },
    { '<leader>snl', false },
    { '<leader>snh', false },
    { '<leader>sna', false },
    { '<leader>snd', false },
    { '<leader>snt', false },
  },
}
