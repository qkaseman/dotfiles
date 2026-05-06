-- Show you pending keybinds and spelling suggestions.
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    -- delay between pressing a key and opening which-key (ms)
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font, -- Poor name, this enables icon mappings.
      -- Use Nerd Font icons if installed, otherwise use strings.
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    -- TODO: Evaluate these keybinds, not 100% sure what each is for yet.
    spec = {
      { '<leader>b', group = '[B]uffer' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>q', group = '[Q]uit/Session' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>u', group = '[U]I Toggle' },
      { '<leader>x', group = 'Diagnostics/Quickfi[x]' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
