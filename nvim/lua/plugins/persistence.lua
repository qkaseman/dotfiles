-- Persistence (session manager) -- relocate session keys from `<leader>q*`
-- (which we've reclaimed for kickstart's `vim.diagnostic.setloclist` action,
-- per item 75) to `<leader>Q*` (capital Q).
return {
  'folke/persistence.nvim',
  keys = {
    -- Disable LazyVim defaults under <leader>q*.
    { '<leader>qs', false },
    { '<leader>qS', false },
    { '<leader>ql', false },
    { '<leader>qd', false },
    -- Replicated under <leader>Q*.
    { '<leader>Qs', function() require('persistence').load() end,                   desc = 'Restore Session' },
    { '<leader>QS', function() require('persistence').select() end,                 desc = 'Select Session' },
    { '<leader>Ql', function() require('persistence').load({ last = true }) end,    desc = 'Restore Last Session' },
    { '<leader>Qd', function() require('persistence').stop() end,                   desc = 'Stop Saving Session' },
  },
}
