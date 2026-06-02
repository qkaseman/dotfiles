-- Structured diagnostics, references, and quickfix viewer.
return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols' },
    { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP References' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
  },
}
