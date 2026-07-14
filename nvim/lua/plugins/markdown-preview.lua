-- markdown-preview.nvim opens a browser preview of the current markdown
-- buffer with live reload. The browser handles GFM, mermaid diagrams,
-- and KaTeX math natively -- alacritty can't display inline images via
-- the kitty graphics protocol or sixel, so in-buffer image rendering
-- (via render-markdown.nvim's image extension, etc.) is a non-starter.
-- This plugin is the complement to render-markdown.nvim: that one
-- decorates the buffer in-place, this one opens a real browser view.
--
-- We build from source instead of using `mkdp#util#install` because the
-- prebuilt arm64 macOS binary is unreliable (Gatekeeper quarantine,
-- arch mismatches -- error -88 at startup). `npm install` in app/ sets
-- up the Node-based preview server which runs directly under
-- mise-managed node.

return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  ft = { 'markdown' },
  build = 'cd app && npm install',
  keys = {
    {
      '<leader>cp',
      '<cmd>MarkdownPreviewToggle<cr>',
      ft = 'markdown',
      desc = 'Markdown preview',
    },
  },
}
