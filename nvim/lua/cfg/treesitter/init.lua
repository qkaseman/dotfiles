local ok, cfg = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

cfg.setup {
  ensure_installed = 'all',
  highlight = {
    enable = true,
    -- Must be false for `spellsitter`.
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_tresitter#foldexpr()')
vim.cmd('set foldnestmax=5')

require('spellsitter').setup()
