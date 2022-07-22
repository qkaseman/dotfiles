vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { noremap = true })

vim.cmd([[
  function! FloatermStrategy(cmd)
    execute 'FloatermKill scratch'
    execute 'FloatermNew! --autoclose=2 --name=scratch '.a:cmd.' | less -X'
  endfunction
  let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
  let g:test#strategy = 'floaterm'
]])
