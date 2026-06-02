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
--   <C-y>            accept (also accepts AI ghost text when present)
--   <C-n> / <C-p>    select next / previous (also <Up>/<Down>)
--   <C-space>        open menu / show docs if open
--   <C-e>            hide menu
--   <C-k>            toggle signature help
--
-- We additionally override `<Tab>`/`<S-Tab>` to `{ "fallback" }` so they ALWAYS
-- insert a tab character (or spaces, with `expandtab`) -- never accept
-- completions, never navigate snippet placeholders. Trade-off: snippet
-- placeholder navigation needs a different key if/when you use snippets.
--
-- Setting `<Tab>` explicitly also prevents LazyVim's `config = function`
-- from injecting its own Tab handler that would do `snippet_forward,
-- ai_nes, ai_accept` before falling through.
--
-- Use the function form so we fully replace `opts.keymap` rather than merging
-- with LazyVim's `<C-y>` override.

return {
  'saghen/blink.cmp',
  opts = function(_, opts)
    opts.keymap = {
      preset = 'default',
      ['<Tab>'] = { 'fallback' },
      ['<S-Tab>'] = { 'fallback' },
    }
  end,
}
