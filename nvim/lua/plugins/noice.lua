-- Disable noice.nvim entirely. LazyVim ships it as a fancy UI replacement
-- for the cmdline, messages, and popup menus, but we prefer Neovim's
-- native UI.
--
-- This restores:
-- - The bottom-row cmdline (vim default), instead of noice's floating one
-- - `:echo` / `:echomsg` rendering at the bottom (vim default)
-- - The native popup menu for completion fallback
--
-- LazyVim feature loss: the `<leader>sn*` noice command palette, `<S-Enter>`
-- redirect-to-noice-split for verbose output, and noice's filtered routing
-- of long messages. These are nice-to-have, not workflow-critical.
return {
  'folke/noice.nvim',
  enabled = false,
}
