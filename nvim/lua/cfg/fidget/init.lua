-- Standalone UI for `nvim-lsp` progress.
local ok, fidget = pcall(require, 'fidget')
if not ok then
  return
end

fidget.setup({})
