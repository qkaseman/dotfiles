-- Override LazyVim's blink.cmp keymap to use kickstart's preset.
--
-- LazyVim default: `preset = "enter"` with an extra `<C-y>` binding -- so
-- both `<CR>` AND `<C-y>` accept the highlighted completion. Pressing Enter
-- in insert mode while the completion menu is visible accepts instead of
-- inserting a newline, which is annoying.
--
-- Kickstart: `preset = "default"` -- `<C-y>` accepts, `<CR>` is NOT mapped
-- (Enter inserts a newline normally, even with the menu open). This matches
-- vim's built-in `ins-completion` semantics. See `:help blink-cmp-config-keymap`
-- for the preset definitions.
--
-- The default preset includes:
--   <C-y>            accept
--   <C-n> / <C-p>    select next / previous (also <Up>/<Down>)
--   <C-space>        open menu / show docs if open
--   <C-e>            hide menu
--   <C-k>            toggle signature help
--   <Tab> / <S-Tab>  navigate snippet placeholders only
--
-- Use the function form so we fully replace `opts.keymap` rather than merging
-- with LazyVim's `<C-y>` override (which would still leave the `enter` preset
-- in place if we just set `preset = "default"` declaratively).

return {
  'saghen/blink.cmp',
  opts = function(_, opts)
    opts.keymap = {
      preset = 'default',
    }
  end,
}
