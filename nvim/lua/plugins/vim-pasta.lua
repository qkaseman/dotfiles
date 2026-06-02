-- Indent-aware paste: replaces `p`/`P` with smart variants that re-indent
-- pasted text to match destination indent. Disabled for filetypes where
-- whitespace is structurally significant -- changing block indent on paste
-- would corrupt the file's meaning.
return {
  'sickill/vim-pasta',
  event = 'VeryLazy',
  init = function()
    vim.g.pasta_disabled_filetypes = { 'python', 'coffee', 'yaml', 'markdown', 'slim' }
  end,
}
