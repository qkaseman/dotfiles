-- Multi-file search and replace with live preview.
return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  opts = { headerMaxWidth = 80 },
  keys = {
    {
      '<leader>sR',
      function()
        require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
      end,
      desc = 'Search and Replace',
    },
  },
}
