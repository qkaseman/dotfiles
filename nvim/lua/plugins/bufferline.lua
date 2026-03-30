-- Buffer tab line with LSP diagnostics and pin support.
return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
    },
  },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle Pin' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Close Unpinned' },
  },
}
