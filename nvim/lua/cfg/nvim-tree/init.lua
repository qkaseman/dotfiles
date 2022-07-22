local ok, tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

tree.setup({
  git = {
    ignore = false,
  },
  renderer = {
    highlight_opened_files = "icon",
  },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
