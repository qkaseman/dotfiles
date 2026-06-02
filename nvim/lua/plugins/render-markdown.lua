-- render-markdown.nvim from LazyVim's `lang.markdown` extra. Decorates
-- markdown buffers with extmark-based "rendered view" -- heading icons +
-- backgrounds, code block backgrounds, bullet substitution, table grid
-- drawing, callouts, link icons, etc. The rendering is anti-conceal-aware
-- (turns off in insert mode), which makes the visual switch jarring.
--
-- We keep the plugin loaded but DISABLED at startup, paired with
-- `conceallevel = 0` (item D68). `<leader>um` toggles BOTH together so
-- enabling the fancy view also enables vim's native markdown concealment
-- (bold/italic/code-marker hiding).
--
-- LazyVim's `lang.markdown` extra binds `<leader>um` to
-- `Snacks.toggle({ name = "Render Markdown", get/set = render-markdown })`
-- via the plugin's `config` callback. We replace that callback with a
-- bundled toggle so both layers flip together.

return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    -- Plugin starts disabled by default. Toggle on with <leader>um.
    enabled = false,
  },
  ft = { 'markdown', 'norg', 'rmd', 'org', 'codecompanion' },
  config = function(_, opts)
    require('render-markdown').setup(opts)

    Snacks.toggle({
      name = 'Markdown Rendering',
      get = function()
        return require('render-markdown').get() == true
      end,
      set = function(state)
        require('render-markdown').set(state)
        vim.opt.conceallevel = state and 2 or 0
      end,
    }):map('<leader>um')
  end,
}
