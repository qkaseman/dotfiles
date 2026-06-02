-- F-key bindings for DAP (debug adapter protocol). Kickstart-style.
-- Migration plan item 100.
--
-- The actual DAP plugin is enabled via `extras.dap.core` in `lsp.lua`.
-- This file only adds the key bindings. Lazy-loads on first F-key press.

return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>', function() require('dap').continue() end,  desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end,  desc = 'Debug: Step Out' },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    },
  },
}
