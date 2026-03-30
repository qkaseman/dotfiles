-- Colorscheme infrastructure. Loaded for tokyonight but actual scheme is wildcharm.
return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    -- Incorrectly considers some fields required.
    ---@diagnostic disable-next-line missing-fields
    -- require('tokyonight').setup({
    --   styles = {
    --     comments = { italic = false },
    --    },
    -- })

    vim.cmd.colorscheme('wildcharm')
  end,
}
