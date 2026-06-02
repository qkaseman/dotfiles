-- Terminal integration via toggleterm.nvim. Replaces snacks.nvim's terminal
-- (disabled in `snacks.lua` plugin spec). Provides float/horizontal/vertical
-- terminals plus REPL, lazygit, btm, gdu launchers, and send-line/selection.
--
-- All `<leader>T*` (capital T) per migration plan item 110 to leave
-- `<leader>t*` free for kickstart-style toggles or future test extras.

-- Resolve gdu binary name per platform (AstroNvim pattern).
local gdu = 'gdu'
if vim.fn.executable(gdu) ~= 1 then
  if vim.fn.has('win32') == 1 then
    gdu = 'gdu_windows_amd64.exe'
  elseif vim.fn.has('mac') == 1 then
    gdu = 'gdu-go'
  end
end

local function term(cmd, dir)
  return function()
    require('toggleterm.terminal').Terminal:new({
      cmd = cmd,
      direction = dir or 'float',
      hidden = true,
    }):toggle()
  end
end

return {
  'akinsho/toggleterm.nvim',
  opts = {
    size = function(t)
      if t.direction == 'horizontal' then return 15 end
      if t.direction == 'vertical' then return vim.o.columns * 0.4 end
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
    { "<c-'>", '<cmd>ToggleTerm<cr>', mode = { 'n', 't' }, desc = 'Toggle Last Terminal' },
    { '<leader>Tf', '<cmd>ToggleTerm direction=float<cr>',      desc = 'Float Terminal' },
    { '<leader>TH', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Horizontal Terminal' },
    { '<leader>Tv', '<cmd>ToggleTerm direction=vertical<cr>',   desc = 'Vertical Terminal' },
    { '<leader>Tn', term('node', 'vertical'),                   desc = 'Node REPL' },
    { '<leader>Tp', term('python3', 'vertical'),                desc = 'Python REPL' },
    { '<leader>Tl', term('lazygit'),                            desc = 'Lazygit' },
    { '<leader>Tt', term('btm'),                                desc = 'Bottom (process viewer)' },
    { '<leader>Tu', term(gdu),                                  desc = 'Gdu (disk usage)' },
    { '<leader>Ts', '<cmd>ToggleTermSendCurrentLine<cr>',                 desc = 'Send Line to Terminal' },
    { '<leader>Ts', '<cmd>ToggleTermSendVisualSelection<cr>', mode = 'v', desc = 'Send Selection to Terminal' },
  },
}
