-- Terminal integration via toggleterm.nvim (AstroNvim-style).
-- Replaces snacks.nvim terminal. Delete this file and
-- re-enable snacks terminal to revert.

-- Resolve gdu binary name per platform (AstroNvim pattern).
local gdu = 'gdu'
if vim.fn.executable(gdu) ~= 1 then
  if vim.fn.has('win32') == 1 then
    gdu = 'gdu_windows_amd64.exe'
  elseif vim.fn.has('mac') == 1 then
    gdu = 'gdu-go'
  end
end

return {
  'akinsho/toggleterm.nvim',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then return 15 end
      if term.direction == 'vertical' then return vim.o.columns * 0.4 end
    end,
    open_mapping = [[<c-/>]],
    direction = 'float',
    float_opts = { border = 'rounded' },
    shade_terminals = false,
    -- Navigate out of terminal with C-hjkl (like normal splits).
    on_open = function()
      local opts = { buffer = 0, silent = true }
      vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<cr>]], opts)
      vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<cr>]], opts)
      vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<cr>]], opts)
      vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<cr>]], opts)
    end,
  },
  keys = {
    { '<c-/>', desc = 'Toggle Terminal (float)' },
    { '<c-\'>', '<cmd>ToggleTerm<cr>', mode = { 'n', 't' }, desc = 'Toggle Last Terminal' },
    { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Float Terminal' },
    { '<leader>tH', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Horizontal Terminal' },
    { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Vertical Terminal' },
    { '<leader>tn', function()
      require('toggleterm.terminal').Terminal:new({ cmd = 'node', direction = 'vertical' }):toggle()
    end, desc = 'Node REPL' },
    { '<leader>tp', function()
      require('toggleterm.terminal').Terminal:new({ cmd = 'python3', direction = 'vertical' }):toggle()
    end, desc = 'Python REPL' },
    { '<leader>tl', function()
      require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true }):toggle()
    end, desc = 'Lazygit' },
    { '<leader>gg', function()
      require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true }):toggle()
    end, desc = 'Lazygit' },
    { '<leader>tt', function()
      require('toggleterm.terminal').Terminal:new({ cmd = 'btm', direction = 'float', hidden = true }):toggle()
    end, desc = 'Bottom (process viewer)' },
    { '<leader>tu', function()
      require('toggleterm.terminal').Terminal:new({ cmd = gdu, direction = 'float', hidden = true }):toggle()
    end, desc = 'Gdu (disk usage)' },
    { '<leader>ts', '<cmd>ToggleTermSendCurrentLine<cr>', desc = 'Send Line to Terminal' },
    { '<leader>ts', '<cmd>ToggleTermSendVisualSelection<cr>', mode = 'v', desc = 'Send Selection to Terminal' },
  },
}
