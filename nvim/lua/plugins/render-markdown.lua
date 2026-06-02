-- Disable render-markdown.nvim. LazyVim's `lang.markdown` extra ships it as
-- a "pretty" view of markdown buffers: it uses extmarks to render `**bold**`
-- as bold, hide list-marker characters, style code fences, etc. when not in
-- insert mode.
--
-- The result is that the file looks one way in insert mode and a different
-- way in normal/visual mode, which is jarring. We already set
-- `conceallevel = 0` (item D68) to keep raw markdown markers visible;
-- render-markdown does its own extmark-based concealment that ignores
-- conceallevel, so it has to be disabled here too.
--
-- Plain treesitter highlighting (still active) gives sufficient color
-- distinction without the rewriting.
return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = false,
}
