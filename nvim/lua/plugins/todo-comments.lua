-- todo-comments customization:
-- 1. Add a custom QUESTION keyword (magenta).
-- 2. Custom highlight style: leading characters not styled (multi-line
--    comments don't apply consistently to the leading characters, looks
--    weird), keyword highlighted with a background, rest of comment with
--    the keyword's foreground color.
-- 3. Pattern allows the optional colon after keyword (e.g. `TODO: foo` AND
--    `TODO foo` both match).

return {
  'folke/todo-comments.nvim',
  opts = {
    keywords = {
      QUESTION = { icon = '?', color = '#d70087' },
    },
    merge_keywords = true,
    highlight = {
      -- `before` doesn't apply cleanly to multi-line comments (their
      -- leading characters don't get the highlight), so leave it empty.
      before = '',
      keyword = 'bg',
      after = 'fg',
      pattern = [[.*<((KEYWORDS):?)\s*]],
    },
    signs = true,
  },
}
