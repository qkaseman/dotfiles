-- Use the built-in wildcharm colorscheme. tokyonight (LazyVim's default) and
-- catppuccin (registered as a fallback) ship as plugins; disable both since
-- we don't use them.
--
-- Custom papercolor.nvim is at `~/.config/papercolor.nvim/` and will be wired
-- in later (deferred per migration plan item 4).

return {
  { 'LazyVim/LazyVim', opts = { colorscheme = 'wildcharm' } },
  { 'folke/tokyonight.nvim', enabled = false },
  { 'catppuccin/nvim', enabled = false },
}
