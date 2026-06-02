-- Snacks: collection of small QoL plugins
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    scratch = { enabled = true },
    terminal = { enabled = false },
    words = { enabled = true },
  },
  keys = {
    { '<leader>n', '<cmd>messages<cr>', desc = 'Message History' },
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    { ']]', function() Snacks.words.jump(vim.v.count1, true) end, desc = 'Next Reference', mode = { 'n', 'x', 'o' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1, true) end, desc = 'Prev Reference', mode = { 'n', 'x', 'o' } },
  },
}
