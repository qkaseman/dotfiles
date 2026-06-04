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
-- Custom overrides:
--
-- 1. `<Tab>` and `<S-Tab>` -> `{ "fallback" }`. Always insert a tab character
--    (or spaces, with `expandtab`). Never accept completions, never navigate
--    snippet placeholders. Setting these explicitly also prevents LazyVim's
--    `config = function` from injecting an auto-Tab handler that would chain
--    `snippet_forward, ai_nes, ai_accept` before fallback.
--
-- 2. `<C-n>` and `<C-p>` -> snippet placeholder navigation FIRST, completion
--    menu navigation SECOND. blink.cmp keymap entries are chains: each
--    function returns true if it handled the event, false otherwise. So
--    when inside an active snippet, C-n moves to the next placeholder; if
--    no snippet is active (or you've reached the end), it falls through to
--    cycling the completion menu. Same for C-p in reverse.
--
--    This puts snippet nav on the same C-n/C-p keys used elsewhere for
--    next/prev navigation (search, hunks, etc.) -- consistent across
--    contexts -- and keeps Tab strictly as a tab character.

return {
  'saghen/blink.cmp',
  opts = function(_, opts)
    opts.keymap = {
      preset = 'default',
      ['<Tab>'] = { 'fallback' },
      ['<S-Tab>'] = { 'fallback' },
      ['<C-n>'] = { 'snippet_forward', 'select_next' },
      ['<C-p>'] = { 'snippet_backward', 'select_prev' },
    }
  end,
}
